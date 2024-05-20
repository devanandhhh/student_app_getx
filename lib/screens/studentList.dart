// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_managemnt_app/getx/studentinfoC.dart';
import 'package:student_managemnt_app/screens/addStudent.dart';
import 'package:student_managemnt_app/screens/details.dart';
import '../functions/functions.dart';

class StudentInfo extends StatelessWidget {
  StudentInfo({Key? key}) : super(key: key);

  // late List<Map<String, dynamic>> _studentsData = [];
  final StudentInfoController controller = Get.put(StudentInfoController());

  // @override
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text(
            "STUDENT LIST",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(80),
            child: Container(
              color: Colors.amber,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  controller: controller.searchController,
                  // onChanged: (value) {
                  //   setState(() {
                  //     _refreshStudentsData();
                  //   });

                  // },
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    labelText: "Search ",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(39)),
                  ),
                ),
              ),
            ),
          ),
        ),
        body: Obx(() {
          if (controller.studentsData.isEmpty) {
            return Center(child: Text("No students available."));
          } else {
            return ListView.separated(
              itemBuilder: (context, index) {
                final student = controller.studentsData[index];
                final id = student['id'];
                final imageUrl = student['imageurl'];
                return ListTile(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return Details(student: student);
                    }));
                  },
                  leading: GestureDetector(
                    onTap: () {
                      if (imageUrl != null) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.file(File(imageUrl)),
                                ],
                              ),
                            );
                          },
                        );
                      }
                    },
                    child: CircleAvatar(
                      backgroundImage:
                          imageUrl != null ? FileImage(File(imageUrl)) : null,
                      child: imageUrl == null ? Icon(Icons.person) : null,
                    ),
                  ),
                  title: Text(student['name']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          controller.showEditDialog(index);
                        },
                        icon: Icon(
                          Icons.edit,
                          color: Colors.grey,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: Text("Delete Student"),
                              content: Text("Are you sure you want to delete?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    await deleteStudent(id);
                                    controller.refreshStudentsData();
                                    Navigator.of(context).pop();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content:
                                                Text("Deleted Successfully")));
                                  },
                                  child: Text(
                                    "Ok",
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                        icon: Icon(Icons.delete, color: Colors.grey),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: controller.studentsData.length,
            );
          }
        }),
        floatingActionButton: FloatingActionButton(
          foregroundColor: Colors.amber,
          child: Icon(Icons.add),
          onPressed: () {
            Get.to(AddStudent());
            // Navigator.of(context) 
            //     .push(MaterialPageRoute(builder: (ctx) => AddStudent()));
          },
        ),
      ),
    );
  }
}
