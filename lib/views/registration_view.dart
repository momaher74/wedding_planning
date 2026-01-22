import 'package:flutter/material.dart';
import '../controllers/registration_controller.dart';
import '../core/app_colors.dart';
import 'otp_verification_view.dart';

class RegistrationView extends StatefulWidget {
  const RegistrationView({super.key});

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  late final RegistrationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = RegistrationController();
    _controller.addListener(_onControllerChanged);
  }

  void _onControllerChanged() {
    if (_controller.errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_controller.errorMessage!),
          backgroundColor: Colors.red,
        ),
      );
      _controller.clearError();
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 40),
                        
                        // Title Section
                        _buildTitle(),
                        
                        const SizedBox(height: 48),
                        
                        // Input Fields
                        _buildFullNameInput(),
                        
                        const SizedBox(height: 32),
                        
                        _buildEmailInput(),
                        
                        const SizedBox(height: 32),
                        
                        _buildPhoneInput(),
                        
                        const SizedBox(height: 16),
                        
                        // Instruction Text
                        _buildInstructionText(),
                        
                        const SizedBox(height: 100),
                        
                        // Continue Button
                        Padding(
                          padding: const EdgeInsets.only(bottom: 40),
                          child: _buildContinueButton(),
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
      padding: const EdgeInsets.all(16.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: IconButton(
          icon: const Icon(Icons.arrow_forward, color: AppColors.darkBrown),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      children: [
        const Text(
          'يسجل',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.darkBrown,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'في أقل من دقيقة',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w300,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildFullNameInput() {
    return _buildInputField(
      label: 'الاسم بالكامل',
      hint: 'أدخل الاسم الكامل',
      controller: _controller.fullNameController,
      keyboardType: TextInputType.name,
    );
  }

  Widget _buildEmailInput() {
    return _buildInputField(
      label: 'عنوان البريد الإلكتروني',
      hint: 'أدخل عنوان البريد الالكتروني',
      controller: _controller.emailController,
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget _buildPhoneInput() {
    return _buildInputField(
      label: 'رقم التليفون',
      hint: 'أدخل رقم الهاتف',
      controller: _controller.phoneController,
      keyboardType: TextInputType.phone,
    );
  }

  Widget _buildInputField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required TextInputType keyboardType,
  }) {
    return Stack(
      children: [
        // Underline
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 1,
            color: Colors.grey.shade400,
          ),
        ),
        // Label on the right
        Positioned(
          top: 0,
          right: 0,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.darkBrown,
            ),
          ),
        ),
        // Input field
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 14,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.darkBrown,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInstructionText() {
    return Center(
      child: Text(
        'سنرسل رمز التحقق.',
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey.shade600,
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, child) {
        return SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: _controller.isLoading ? null : _handleRegister,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
              disabledBackgroundColor: Colors.grey.shade300,
            ),
            child: _controller.isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Text(
                    'يكمل',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
          ),
        );
      },
    );
  }

  Future<void> _handleRegister() async {
    final success = await _controller.register();
    if (success && mounted) {
      // Navigate to OTP verification screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => OTPVerificationView(
            phoneNumber: _controller.phoneController.text,
          ),
        ),
      );
    }
  }
}

