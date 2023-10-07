import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_provider/provider/studentmodal.dart';
import 'package:new_provider/screens/home.dart';
import 'package:new_provider/widget/image_picker.dart';
import 'package:provider/provider.dart';

class Editpage extends StatelessWidget {
  Editpage({super.key, required this.student, required this.index});
  final StudentModel student;
  final int index; 
    XFile? imagefile;
  File? image;
  String imagEPath = '';

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    nameController.text = student.name;
    ageController.text = student.age;
    imagEPath=student.imagePath;
    return Consumer<StudentProvider>(
      builder: (context, studentData, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Edit'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              height: 405,
              color: const Color.fromARGB(255, 74, 74, 73),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(22.0),
                child: Container(
                  child: Column(
                    children: [
                          GestureDetector(
                    onTap: () async {
                      imagefile = await ImagePickService().pickCropImage(
                          cropAspectRatio:
                              const CropAspectRatio(ratioX: 1, ratioY: 1),
                          imageSource: ImageSource.gallery);
                      if (imagefile != null) {
                        image = File(imagefile!.path);

                        imagEPath = studentData.imageFunction(image!.path);
                      }
                    },
                    child: CircleAvatar(
                      radius: 65,
                      backgroundImage: FileImage(File(imagEPath)),
                    ),
                  ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          hintText: 'Name',
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                        style: const TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: ageController,
                        decoration: const InputDecoration(
                          hintText: 'Age',
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                        style: const TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                         updateData(studentData,context,index); 
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 51, 176, 183),
                            fixedSize: const Size(double.maxFinite, 50)),
                        child: const Text("Update Data"),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  updateData(StudentProvider studentdata, BuildContext context,int index) {
    final name = nameController.text.trim();
    final age = ageController.text.trim();
    
    if (name.isNotEmpty && age.isNotEmpty) {
      final studentobj = StudentModel(name: name, age: age,imagePath: imagEPath);
      studentdata.update(index,studentobj);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color.fromARGB(255, 51, 176, 183),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(10),
          content: Text(
            'Updated Succesfully',
            style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
          )));
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const Home(),
          ),
          (route) => false);
    }
  }
}
