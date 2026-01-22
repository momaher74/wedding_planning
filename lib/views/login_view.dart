import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';
import '../widgets/floral_logo.dart';
import '../widgets/bride_groom_illustration.dart';
import '../core/app_colors.dart';
import '../core/routes/app_routes.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    
    // Handle error messages using worker
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

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl, // RTL for Arabic
          child: Column(
            children: [
              // Main Content
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      children: [
                        SizedBox(height: 20.h),
                        
                        // Logo
                        const FloralLogo(),
                        
                        SizedBox(height: 16.h),
                        
                        // App Name "Wedplan"
                        _buildAppName(),
                        
                        SizedBox(height: 24.h),
                        
                        // Bride and Groom Illustration
                        const BrideGroomIllustration(),
                        
                        SizedBox(height: 32.h),
                        
                        // Login Form
                        _buildLoginForm(controller),
                        
                        SizedBox(height: 24.h),
                        
                        // Continue Button
                        _buildContinueButton(controller),
                        
                        SizedBox(height: 16.h),
                        
                        // "Or continue with" text
                        _buildOrContinueText(),
                        
                        SizedBox(height: 16.h),
                        
                        // Social Login Buttons
                        _buildSocialLoginButtons(controller),
                        
                        SizedBox(height: 24.h),
                        
                        // Sign Up Link
                        _buildSignUpLink(),
                        
                        SizedBox(height: 40.h),
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

  Widget _buildAppName() {
    return Text(
      'Wedplan',
      style: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.italic,
        color: AppColors.darkBrown,
        letterSpacing: 1.5,
      ),
    );
  }

  Widget _buildLoginForm(LoginController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'قم بتسجيل دخولك الآن',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.darkBrown,
          ),
        ),
        SizedBox(height: 20.h),
        // Phone number input field
        Stack(
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
                'رقم التليفون',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.darkBrown,
                ),
              ),
            ),
            // Input field
            Padding(
              padding: EdgeInsets.only(top: 20.h),
              child: Row(
                children: [
                  Text(
                    '+1',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.darkBrown,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: TextField(
                      controller: controller.phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: 'دخل رقم الهاتف',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 14.sp,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.darkBrown,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContinueButton(LoginController controller) {
    return Obx(() => SizedBox(
      width: double.infinity,
      height: 50.h,
      child: ElevatedButton(
        onPressed: controller.isLoading.value ? null : () => _handlePhoneLogin(controller),
        style: ElevatedButton.styleFrom(
          backgroundColor: Get.theme.colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 0,
          disabledBackgroundColor: Colors.grey.shade300,
        ),
        child: controller.isLoading.value
            ? SizedBox(
                width: 20.w,
                height: 20.h,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                'يكمل',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
      ),
    ));
  }

  Widget _buildOrContinueText() {
    return Text(
      'أو متابعة',
      style: TextStyle(
        fontSize: 14.sp,
        color: AppColors.darkBrown,
      ),
    );
  }

  Widget _buildSocialLoginButtons(LoginController controller) {
    return Obx(() => Row(
      children: [
        // Google button
        Expanded(
          child: SizedBox(
            height: 50.h,
            child: ElevatedButton(
              onPressed: controller.isLoading.value ? null : () => _handleGoogleLogin(controller),
              style: ElevatedButton.styleFrom(
                backgroundColor: Get.theme.colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 0,
                disabledBackgroundColor: Colors.grey.shade300,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 24.w,
                    height: 24.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        'G',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.googleBlue,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'غوغل',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        // Divider
        Container(
          width: 1.w,
          height: 30.h,
          color: Colors.grey.shade400,
        ),
        SizedBox(width: 12.w),
        // Facebook button
        Expanded(
          child: SizedBox(
            height: 50.h,
            child: ElevatedButton(
              onPressed: controller.isLoading.value ? null : () => _handleFacebookLogin(controller),
              style: ElevatedButton.styleFrom(
                backgroundColor: Get.theme.colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 0,
                disabledBackgroundColor: Colors.grey.shade300,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 24.w,
                    height: 24.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        'f',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.facebookBlue,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'فيسبوك',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }

  Future<void> _handlePhoneLogin(LoginController controller) async {
    // First check if user exists
    final userExists = await controller.checkIfUserExists();
    
    if (!userExists) {
      // User doesn't exist, navigate to registration
      Get.toNamed(AppRoutes.registration);
    } else {
      // User exists, navigate to OTP verification
      Get.toNamed(
        AppRoutes.otpVerification,
        arguments: controller.phoneController.text,
      );
    }
  }

  Future<void> _handleGoogleLogin(LoginController controller) async {
    final success = await controller.loginWithGoogle();
    if (success) {
      Get.snackbar(
        'نجاح',
        'تم تسجيل الدخول مع Google بنجاح',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }

  Future<void> _handleFacebookLogin(LoginController controller) async {
    final success = await controller.loginWithFacebook();
    if (success) {
      Get.snackbar(
        'نجاح',
        'تم تسجيل الدخول مع Facebook بنجاح',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }

  Widget _buildSignUpLink() {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.registration);
      },
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey.shade600,
          ),
          children: [
            const TextSpan(text: 'ليس لديك حساب؟ '),
            TextSpan(
              text: 'سجل الآن',
              style: TextStyle(
                color: Get.theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
