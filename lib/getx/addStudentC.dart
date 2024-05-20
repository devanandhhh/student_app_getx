import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_managemnt_app/functions/functions.dart';
import 'package:student_managemnt_app/screens/model.dart';

class AddStudentController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final rollnoController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final ageController = TextEditingController();
  var selectedImagePatch = ''.obs;

  Future<void> pickImage() async {

    try{
  final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      selectedImagePatch.value = pickedImage.path;
    } else {
      selectedImagePatch.value = '';
      Get.snackbar('Error', 'no image selected',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
    }catch(e){
      selectedImagePatch.value='';
      Get.snackbar('Error', 'failed to pick image',backgroundColor: Colors.red,colorText: Colors.white);
    }
  
  }

  void saveStudent() async {
    if (formKey.currentState!.validate()) {
      if (selectedImagePatch.value.isEmpty) {
        Get.snackbar('Error', 'You must select and image',
            backgroundColor: Colors.red, colorText: Colors.white);
      } else {
        final student = StudentModel(
            rollno: rollnoController.text,
            name: nameController.text,
            phoneno: phoneController.text,
            age: ageController.text,
            imageurl: selectedImagePatch.value);
        await addStudent(student);
        Get.snackbar('Success', 'Data Added Successfully',
            backgroundColor: Colors.green, colorText: Colors.white);
        clearcontroller();
      }
    }
  }

  void clearcontroller() {
    rollnoController.clear();
    nameController.clear();
    phoneController.clear();
    ageController.clear();
    selectedImagePatch.value = '';
  }
}
