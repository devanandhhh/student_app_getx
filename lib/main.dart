import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_managemnt_app/screens/addStudent.dart';
// import 'package:sqflite/sqflite.dart';
import 'package:student_managemnt_app/screens/studentList.dart';
import 'functions/functions.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "STUDENT DATABASE",
      theme: ThemeData(primarySwatch: Colors.yellow),
      home:  StudentInfo(),
      // .AddStudent(),
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: '/addStudentC', page:()=> AddStudent(),),
        GetPage(name: '/studentinfoC', page:()=>StudentInfo())
      ],
    );
  }
}
