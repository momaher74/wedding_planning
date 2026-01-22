import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/registration_model.dart';

class RegistrationController extends GetxController {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final _isLoading = false.obs;
  final _errorMessage = Rxn<String>();
  final _registrationData = Rxn<RegistrationModel>();

  bool get isLoading => _isLoading.value;
  String? get errorMessage => _errorMessage.value;
  RegistrationModel? get registrationData => _registrationData.value;

  // PROTOTYPE: Validation commented out
  // bool get isValidForm =>
  //     fullNameController.text.isNotEmpty &&
  //     emailController.text.isNotEmpty &&
  //     emailController.text.contains('@') &&
  //     phoneController.text.isNotEmpty &&
  //     phoneController.text.length >= 10;
  bool get isValidForm => true; // Always valid for prototype

  @override
  void onInit() {
    super.onInit();
    fullNameController.addListener(() => update());
    emailController.addListener(() => update());
    phoneController.addListener(() => update());
  }

  Future<bool> register() async {
    // PROTOTYPE: Validation commented out
    // if (!isValidForm) {
    //   _errorMessage.value = 'يرجى ملء جميع الحقول بشكل صحيح';
    //   return false;
    // }

    _isLoading.value = true;
    _errorMessage.value = null;

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      _registrationData.value = RegistrationModel(
        fullName: fullNameController.text,
        email: emailController.text,
        phoneNumber: phoneController.text,
      );

      _isLoading.value = false;
      return true;
    } catch (e) {
      _isLoading.value = false;
      _errorMessage.value = 'حدث خطأ أثناء التسجيل';
      return false;
    }
  }

  void clearError() {
    _errorMessage.value = null;
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}
