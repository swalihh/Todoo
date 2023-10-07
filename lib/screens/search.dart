import 'dart:io';

import 'package:flutter/material.dart';
import 'package:new_provider/provider/studentmodal.dart';
import 'package:provider/provider.dart';


class Search extends StatelessWidget {
  Search({super.key});
  TextEditingController searchController = TextEditingController();
  List<StudentModel> filtered = [];
  @override
  Widget build(BuildContext context) {
    return Consumer<StudentProvider>(
      builder: (context, studentData, child) => SafeArea(
          child: Scaffold(
              appBar: AppBar(
                  title: const Text("Search here"),
                  centerTitle: true,
  ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  TextFormField(
                      onChanged: (value) {
                        searchStudent(studentData.studentList, value, studentData);
                      },
                      style: const TextStyle(color: Colors.white),
                      controller: searchController,
                      decoration: InputDecoration(
                        suffixIcon: const Icon(Icons.search),
                        suffixIconColor: Colors.black87,
                        filled: true,
                        fillColor: Color.fromARGB(106, 254, 254, 254),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(15)),
                        hintText: "Search",
                      )),
                  const SizedBox(height: 10),
                  Expanded(
                      child: filtered.isNotEmpty
                          ? ListView.separated(
                              itemCount: filtered.length,
                              separatorBuilder: (context, index) =>
                                  const Divider(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final student = filtered[index];
                                return ListTile(
                                  tileColor: Colors.black12,
                                  title: Text(student.name),
                                  subtitle: Text(student.age),
                                  leading: CircleAvatar(
                                      radius: 25,
                                      backgroundImage:
                                          FileImage(File(student.imagePath))),
                                 
                                );
                              },
                            )
                          : const Center(
                              child:  Text('Not Found',style: TextStyle(color: Colors.white),)))
                ]),
              ))),
    );
  }

  searchStudent(List<StudentModel> students, String studentName,
      StudentProvider studentData) {
    filtered = students
        .where((element) =>
            element.name.toLowerCase().contains(studentName.toLowerCase()))
        .toList();
    studentData.serch(filtered);
  }
}
