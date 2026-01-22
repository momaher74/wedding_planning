import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/otp_controller.dart';
import '../models/otp_model.dart';
import '../core/app_colors.dart';
import '../core/routes/app_routes.dart';

class OTPVerificationView extends StatelessWidget {
  final String phoneNumber;
  
  const OTPVerificationView({
    super.key,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OTPController(phoneNumber: phoneNumber));
    
    // Handle error messages
    ever(controller.errorMessage, (String? error) {
      if (error != null && error.isNotEmpty) {
        Get.snackbar(
          'خطأ',
          error,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        controller.clearError();
      }
    });
    
    // Handle successful verification
    ever(controller.otpData, (OTPModel? otpData) {
      if (otpData?.isVerified == true) {
        Get.offAllNamed(AppRoutes.home);
      }
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl, // RTL for Arabic
          child: Column(
            children: [
              // Back Button
              _buildBackButton(),
              
              // Main Content
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      children: [
                        SizedBox(height: 40.h),
                        
                        // Title Section
                        _buildTitle(),
                        
                        SizedBox(height: 48.h),
                        
                        // Instruction Text
                        _buildInstructionText(),
                        
                        SizedBox(height: 32.h),
                        
                        // Code Input
                        _buildCodeInput(controller),
                        
                        SizedBox(height: 16.h),
                        
                        // Resend Code
                        _buildResendCode(controller),
                        
                        SizedBox(height: 100.h),
                        
                        // Start Button
                        Padding(
                          padding: EdgeInsets.only(bottom: 40.h),
                          child: _buildStartButton(controller),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Align(
        alignment: Alignment.centerRight,
        child: IconButton(
          icon: Icon(Icons.arrow_forward, color: AppColors.darkBrown, size: 24.sp),
          onPressed: () => Get.back(),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      children: [
        Text(
          'تحقق',
          style: TextStyle(
            fontSize: 28.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.darkBrown,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'في أقل من دقيقة',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w300,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildInstructionText() {
    return Column(
      children: [
        Text(
          'لقد أرسلنا 6 أرقام رمز التحقق.',
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildCodeInput(OTPController controller) {
    return Stack(
      children: [
        // Underline
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 1.h,
            color: Colors.grey.shade400,
          ),
        ),
        // Label on the right
        Positioned(
          top: 0,
          right: 0,
          child: Text(
            'ادخل الرمز',
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.darkBrown,
            ),
          ),
        ),
        // Hint text
        Positioned(
          top: 20.h,
          right: 0,
          child: Text(
            'أدخل 6 أرقام',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey.shade500,
            ),
          ),
        ),
        // Input field
        Padding(
          padding: EdgeInsets.only(top: 40.h),
          child: TextField(
            controller: controller.codeController,
            keyboardType: TextInputType.number,
            maxLength: 6,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.darkBrown,
              letterSpacing: 8,
            ),
            decoration: InputDecoration(
              hintText: '------',
              hintStyle: TextStyle(
                color: Colors.grey.shade300,
                fontSize: 24.sp,
                letterSpacing: 8,
              ),
              border: InputBorder.none,
              counterText: '',
              contentPadding: EdgeInsets.zero,
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            onChanged: (value) {
              // Trigger update for button state - GetBuilder will rebuild
              controller.update();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildResendCode(OTPController controller) {
    return Obx(() {
      if (controller.canResend.value) {
        return GestureDetector(
          onTap: () => controller.resendCode(),
          child: Text(
            'إعادة إرسال الرمز',
            style: TextStyle(
              fontSize: 14.sp,
              color: Get.theme.colorScheme.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      } else {
        return Text(
          'إعادة إرسال الرمز خلال ${controller.resendTimer.value} ثانية',
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey.shade600,
          ),
        );
      }
    });
  }

  Widget _buildStartButton(OTPController controller) {
    return Obx(() {
      // PROTOTYPE: Validation commented out
      // final isValid = controller.codeController.text.length == 6;
      final isValid = true; // Always valid for prototype
      final isLoading = controller.isLoading.value;
      
      return SizedBox(
        width: double.infinity,
        height: 50.h,
        child: ElevatedButton(
          onPressed: isLoading || !isValid
              ? null
              : () => controller.verifyCode(),
          style: ElevatedButton.styleFrom(
            backgroundColor: Get.theme.colorScheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            elevation: 0,
            disabledBackgroundColor: Colors.grey.shade300,
          ),
          child: isLoading
              ? SizedBox(
                  width: 20.w,
                  height: 20.h,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Text(
                  'البدء',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
        ),
      );
    });
  }
}
