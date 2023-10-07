import 'package:flutter/material.dart';

class StudentModel{
  final name;
  final age;
final String imagePath;
   StudentModel(  {required this.name,required this.age,required  this.imagePath});
}




class StudentProvider extends ChangeNotifier{
 String imagePath='';
  List<StudentModel> studentList = [];
    List<StudentModel> searchFilter = [];

addStudent(studentobj) {
    studentList.add(studentobj);
    notifyListeners();
  }
   void delete(int index) {
    studentList.removeAt(index);
    notifyListeners();
  }
 update(int index, StudentModel student) {
    delete(index);
    studentList.insert(index, student);
    notifyListeners();
  }
  imageFunction(String imagepath) {
    imagePath = imagepath;
    notifyListeners();
    return imagePath;
  }
  
  serch(List<StudentModel> search) {
    searchFilter = search;
    notifyListeners();
  }

}