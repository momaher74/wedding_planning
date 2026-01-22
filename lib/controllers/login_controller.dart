import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/user_model.dart';

class LoginController extends GetxController {
  final TextEditingController phoneController = TextEditingController();
  
  final isLoading = false.obs;
  final errorMessage = Rxn<String>();
  final currentUser = Rxn<UserModel>();

  // PROTOTYPE: Validation commented out
  // bool get isValidPhone => phoneController.text.isNotEmpty && 
  //                         phoneController.text.length >= 10;
  bool get isValidPhone => true; // Always valid for prototype

  @override
  void onInit() {
    super.onInit();
    phoneController.addListener(() {
      update();
    });
  }

  // Check if user is registered (returns true if registered, false if not)
  Future<bool> checkIfUserExists() async {
    // PROTOTYPE: Validation commented out
    // if (!isValidPhone) {
    //   errorMessage.value = 'يرجى إدخال رقم هاتف صحيح';
    //   return false;
    // }

    isLoading.value = true;
    errorMessage.value = null;

    try {
      // Simulate API call to check if user exists
      await Future.delayed(const Duration(seconds: 1));
      
      // TODO: Implement actual API call to check if user exists
      // For demo: assume user exists if phone starts with certain digits
      // In real app, this would be an API call
      final phone = phoneController.text;
      final userExists = phone.length >= 10; // Simple check for demo
      
      isLoading.value = false;
      return userExists;
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = 'حدث خطأ أثناء التحقق';
      return false;
    }
  }

  Future<bool> loginWithPhone() async {
    // PROTOTYPE: Validation commented out
    // if (!isValidPhone) {
    //   errorMessage.value = 'يرجى إدخال رقم هاتف صحيح';
    //   return false;
    // }

    isLoading.value = true;
    errorMessage.value = null;

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      // TODO: Implement actual phone authentication
      currentUser.value = UserModel(
        phoneNumber: phoneController.text,
        provider: 'phone',
      );
      
      isLoading.value = false;
      return true;
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = 'حدث خطأ أثناء تسجيل الدخول';
      return false;
    }
  }

  Future<bool> loginWithGoogle() async {
    isLoading.value = true;
    errorMessage.value = null;

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      // TODO: Implement Google Sign-In
      currentUser.value = UserModel(
        provider: 'google',
      );
      
      isLoading.value = false;
      return true;
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = 'حدث خطأ أثناء تسجيل الدخول مع Google';
      return false;
    }
  }

  Future<bool> loginWithFacebook() async {
    isLoading.value = true;
    errorMessage.value = null;

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      // TODO: Implement Facebook Sign-In
      currentUser.value = UserModel(
        provider: 'facebook',
      );
      
      isLoading.value = false;
      return true;
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = 'حدث خطأ أثناء تسجيل الدخول مع Facebook';
      return false;
    }
  }

  void clearError() {
    errorMessage.value = null;
  }

  @override
  void onClose() {
    phoneController.dispose();
    super.onClose();
  }
}

