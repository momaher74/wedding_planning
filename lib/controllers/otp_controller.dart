import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/otp_model.dart';

class OTPController extends GetxController {
  final TextEditingController codeController = TextEditingController();
  final String phoneNumber;
  
  final isLoading = false.obs;
  final errorMessage = Rxn<String>();
  final otpData = Rxn<OTPModel>();
  final resendTimer = 60.obs; // 60 seconds countdown
  final canResend = false.obs;
  Timer? _timer;

  // PROTOTYPE: Validation commented out
  // bool get isValidCode => codeController.text.length == 6;
  bool get isValidCode => true; // Always valid for prototype

  OTPController({required this.phoneNumber});

  @override
  void onInit() {
    super.onInit();
    codeController.addListener(() {
      update(); // Notify listeners when code changes
      // PROTOTYPE: Auto-submit validation commented out
      // Auto-submit when 6 digits are entered
      // if (codeController.text.length == 6 && !isLoading.value) {
      //   verifyCode();
      // }
    });
    _startResendTimer();
  }

  void _startResendTimer() {
    canResend.value = false;
    resendTimer.value = 60;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendTimer.value > 0) {
        resendTimer.value--;
      } else {
        canResend.value = true;
        timer.cancel();
      }
    });
  }

  Future<bool> verifyCode() async {
    // PROTOTYPE: Validation commented out
    // if (!isValidCode) {
    //   errorMessage.value = 'يرجى إدخال رمز التحقق المكون من 6 أرقام';
    //   return false;
    // }

    isLoading.value = true;
    errorMessage.value = null;

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // TODO: Implement actual OTP verification
      // For demo, accept any 6-digit code
      otpData.value = OTPModel(
        phoneNumber: phoneNumber,
        code: codeController.text,
        isVerified: true,
      );

      isLoading.value = false;
      return true;
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = 'رمز التحقق غير صحيح';
      return false;
    }
  }

  Future<void> resendCode() async {
    if (!canResend.value) return;

    isLoading.value = true;
    errorMessage.value = null;

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      codeController.clear();
      _startResendTimer();
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = 'حدث خطأ أثناء إعادة الإرسال';
    }
  }

  void clearError() {
    errorMessage.value = null;
  }

  @override
  void onClose() {
    _timer?.cancel();
    codeController.dispose();
    super.onClose();
  }
}
