// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:student_managemnt_app/getx/addStudentC.dart';
import 'package:student_managemnt_app/getx/studentinfoC.dart';
// import 'package:student_managemnt_app/screens/studentList.dart';

// import '../functions/functions.dart';
// import 'model.dart';

// ignore: must_be_immutable
class AddStudent extends StatelessWidget {
   AddStudent({super.key});

  // final _formKey = GlobalKey<FormState>();
AddStudentController controller =Get.put(AddStudentController());
StudentInfoController bController =Get.put(StudentInfoController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Student Information",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.blue,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsetsDirectional.all(25),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
              Obx(() => CircleAvatar(
                  backgroundColor: Colors.yellow,
                  // backgroundImage: AssetImage('assets/images/addimageicon.png'),
                  maxRadius: 80,
                  child: GestureDetector(
                      onTap: () async {
                        // File? pickimage = await _pickImageFromCamera();
                        // setState(() {
                        //   _selectedImage = pickimage;
                        // });
                        await controller.pickImage();
                      },
                      child: controller.selectedImagePatch.isNotEmpty
                          ? ClipOval(
                              child: Image.file(
                                File(controller.selectedImagePatch.value), 
                                fit: BoxFit.cover,
                                width: 140,
                                height: 140,
                              ),
                            )
                          : Icon(Icons.add_a_photo, size: 50),),
                ), ) ,
                SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: controller.nameController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: "Student Name",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: controller.ageController,
                  decoration: const InputDecoration(
                    labelText: "Age",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.school),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Age is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: controller.rollnoController,
                  decoration: const InputDecoration(
                    labelText: "Roll number",
                    prefixIcon: Icon(Icons.numbers),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Roll no is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: controller.phoneController,
                  maxLength: 10,
                  decoration: const InputDecoration(
                    labelText: "Phone Number",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.phone),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Phone number is required';
                    }
                    final phoneRegExp = RegExp(r'^[0-9]{10}$');
                    if (!phoneRegExp.hasMatch(value)) {
                      return 'Invalid phone number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 45),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          // if (_formKey.currentState!.validate()) {
                          //   if (_selectedImage == null) {
                          //     ScaffoldMessenger.of(context).showSnackBar(
                          //       SnackBar(
                          //         backgroundColor: Colors.red,
                          //         content: Text(
                          //           "You must select an image",
                          //           style: TextStyle(
                          //             color: Colors.white,
                          //           ),
                          //         ),
                          //       ),
                          //     );
                          //   } else {
                          //     Navigator.of(context).pushAndRemoveUntil(
                          //         MaterialPageRoute(
                          //           builder: (ctx) => StudentInfo(),
                          //         ),
                          //         (route) => false);

                          //     final student = StudentModel(
                          //       rollno: rollnoController.text,
                          //       name: nameController.text,
                          //       phoneno: phonenoController.text,
                          //       age: agecontroller.text,
                          //       imageurl: _selectedImage != null
                          //           ? _selectedImage!.path
                          //           : null,
                          //     );
                          //     await addStudent(student);

                          //     ScaffoldMessenger.of(context).showSnackBar(
                          //       SnackBar(
                          //         backgroundColor: Colors.green,
                          //         content: Text(
                          //           "Data Added Successfully",
                          //           style: TextStyle(
                          //             color: Colors.white,
                          //           ),
                          //         ),
                          //       ),
                          //     );
                          //     rollnoController.clear();
                          //     nameController.clear();

                          //     phonenoController.clear();
                          //     agecontroller.clear();
                          //     setState(() {
                          //       _selectedImage = null;
                          //     });
                          //   }
                          // }
                          controller.saveStudent();
                          bController.refreshStudentsData();
                         Get.back(); 

                         
                        },
                        child: Text(
                          "Save",
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
