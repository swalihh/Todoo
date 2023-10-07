import 'dart:io';

import 'package:flutter/material.dart';
import 'package:new_provider/provider/studentmodal.dart';
import 'package:new_provider/screens/adding.dart';
import 'package:new_provider/screens/edit_page.dart';
import 'package:new_provider/screens/search.dart';
import 'package:provider/provider.dart';


class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StudentProvider>(
      builder: (context, studentdata, child) =>  Scaffold(
    appBar: AppBar(   
      title: const Text("Student List"),
      actions: [IconButton(onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return  Search();
        },));
      }, icon:const Icon(Icons.search))],
    ),
    floatingActionButton: FloatingActionButton.extended(onPressed: (){
    
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return  Adding(); 
      },));
    },  label: const Text('Add Student'),
      ),
      
      body:Column(
        children: [
          Expanded (
            child: ListView.builder(
             itemCount: studentdata.studentList.length, 
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final student =studentdata.studentList[index];
              return Card(
                child: ListTile(

                  leading:  CircleAvatar(backgroundImage: FileImage(File(student.imagePath))),
                  title: Text(student.name),
                  subtitle: Text(student.age),
                  trailing: PopupMenuButton(
                      onSelected: (Value){
                        if(Value=='Edit'){
                         
                         Navigator.of(context).push(MaterialPageRoute(builder: (context) => Editpage(student:student,index: index),));
                        }else if(Value == 'Delete'){
                          studentdata.delete(index);
                        }
                      },
                          
                      itemBuilder: (context) {
                        return [
                          const PopupMenuItem(
                            child: Text('Edit'),
                            value: 'Edit',
                          ),
                          const PopupMenuItem(child: Text('Delete'),
                          value: 'Delete',),
                        ];
                      },
                    ),
                ),
              );
            },),
          )
        ],
      ) ,
      ),
    );
  }
}