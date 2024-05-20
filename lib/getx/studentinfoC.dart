import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_managemnt_app/functions/functions.dart';
import 'package:student_managemnt_app/screens/model.dart';

class StudentInfoController extends GetxController {
  var studentsData = <Map<String, dynamic>>[].obs;
  TextEditingController searchController = TextEditingController();

    @override
  void onInit() {
    super.onInit();
    refreshStudentsData();
    searchController.addListener(() {
      refreshStudentsData();
    });
  }
  
  Future<void> refreshStudentsData() async {
    List<Map<String, dynamic>> students = await getAllStudents();
    if (searchController.text.isNotEmpty) {
      students = students
          .where((student) => student['name']
              .toString()
              .toLowerCase()
              .contains(searchController.text.toLowerCase()))
          .toList();
    }
    studentsData.value = students;
  }

  Future<void> showEditDialog(int index) async {
    final student = studentsData[index];
    final TextEditingController nameController =
        TextEditingController(text: student['name']);
    final TextEditingController rollnoController =
        TextEditingController(text: student['rollno'].toString());
    final TextEditingController phonenoController =
        TextEditingController(text: student['phoneno'].toString());
    final TextEditingController ageController =
        TextEditingController(text: student['age'].toString());

    Get.dialog(AlertDialog(
      title: Text('Edit Student'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Name"),
            ),
            TextFormField(
              controller: rollnoController,
              decoration: InputDecoration(labelText: "Roll No"),
            ),
            TextFormField(
              controller: phonenoController,
              decoration: InputDecoration(labelText: "Phone No"),
            ),
            TextFormField(
              controller: ageController,
              decoration: InputDecoration(labelText: " Age"),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.blue),
            )),
        TextButton(
            onPressed: () async {
              await updateStudent(StudentModel(
                  id: student['id'],
                  rollno: rollnoController.text,
                  name: nameController.text,
                  phoneno: phonenoController.text,
                  age: ageController.text,
                  imageurl: student['imageurl']));
              Get.back();
              refreshStudentsData();
              Get.snackbar('Success', 'change Updatad',
                  backgroundColor: Colors.green, colorText: Colors.white);
            },
            child:const Text(
              'Save',
              style: TextStyle(color: Colors.blue),
            ))
      ],
    ));
  }

  Future<void> deleteStudentbyId(int id) async {
    await deleteStudent(id);
    refreshStudentsData();
    Get.snackbar('Success', 'Deleted Successfully',
        backgroundColor: Colors.green, colorText: Colors.white);
  }
}
