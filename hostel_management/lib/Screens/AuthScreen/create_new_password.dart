// Replace your entire create_new_password.dart with this:

import 'package:flutter/material.dart';
import 'package:hostel_management/Const/const.dart';
import 'package:hostel_management/Const/font_weight_const.dart';
import 'package:hostel_management/Screens/AuthScreen/auth_screen.dart';
import 'package:hostel_management/Services/auth_service.dart';
import 'package:hostel_management/Widgets/PageRoute/custom_page_route.dart';
import 'package:hostel_management/Widgets/Text/inter_text_widget.dart';
import 'package:hostel_management/Widgets/TextBox/custom_text_box.dart';
import 'package:hostel_management/Widgets/gradient_button.dart';

class CreateNewPassword extends StatefulWidget {
  final String? userId;
  final String? verifiedOtp;

  const CreateNewPassword({super.key, this.userId, this.verifiedOtp});

  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  bool _isLoading = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 20),
                Text("Updating password..."),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            children: [
              Image.asset("assets/success_icon.png", height: 68, width: 68),
              SizedBox(height: 10),
              InterTextWidget(
                text: "Success",
                fontSize: 18,
                color: Color(0xFF171725),
                fontWeight: FontWeightConst.semiBold,
              ),
            ],
          ),
          content: InterTextWidget(
            text: "Your password is successfully created",
            fontSize: 14,
            color: Color(0xFF66707A),
            fontWeight: FontWeightConst.semiBold,
          ),
          actions: [
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();

                  // Navigate back to auth screen
                  Navigator.pushAndRemoveUntil(
                    context,
                    ScalePageRoute(page: AuthScreen()),
                    (route) => false,
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.width * 0.1,
                  decoration: ShapeDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(0.1, 0.5), // Start closer to center
                      end: Alignment(0.9, 0.5), // End closer to center
                      colors: [
                        const Color(0xFF00B1D6),
                        const Color(0xFF00358D),
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Center(
                    child: InterTextWidget(
                      text: "Continue",
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _handleResetPassword() async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (_passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      _showErrorDialog('Please fill all fields');
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      _showErrorDialog('Passwords do not match');
      return;
    }

    if (_passwordController.text.length < 6) {
      _showErrorDialog('Password must be at least 6 characters');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    _showLoadingDialog();

    try {
      final userId = widget.userId;
      final otp = widget.verifiedOtp;

      if (userId == null || otp == null) {
        throw Exception('Session expired. Please restart the process.');
      }

      final response = await ApiService.resetPasswordWithOtp(
        userId,
        otp,
        _passwordController.text,
      );

      print('Password reset response: $response');

      Navigator.of(context).pop(); // Close loading dialog
      _showSuccessDialog(); // Show success dialog
    } catch (e) {
      print('Error resetting password: $e');
      Navigator.of(context).pop(); // Close loading dialog
      _showErrorDialog(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF111827)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.08),

              // Logo
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: Center(
                  child: Image(image: AssetImage('assets/splash_logo.png')),
                ),
              ),
              SizedBox(height: 24),

              InterTextWidget(
                text: 'Create New Password',
                fontSize: 24,
                color: Color(0xFF111827),
                fontWeight: FontWeightConst.bold,
              ),
              SizedBox(height: 8),

              InterTextWidget(
                text: 'Enter your new password',
                fontSize: 16,
                color: Color(0xFF434E58),
                fontWeight: FontWeightConst.regular,
              ),
              SizedBox(height: 32),

              CustomTextFromBox(
                labelText: 'Enter new password',
                isPassword: true,
                controller: _passwordController,
                focusNode: _passwordFocusNode,
              ),

              CustomTextFromBox(
                labelText: 'Confirm new password',
                isPassword: true,
                controller: _confirmPasswordController,
                focusNode: _confirmPasswordFocusNode,
              ),

              SizedBox(height: 24),

              GestureDetector(
                onTap: _isLoading ? null : _handleResetPassword,
                child: GradientButton(
                  text: 'Update Password',
                  width: MediaQuery.of(context).size.width,
                ),
              ),

              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
