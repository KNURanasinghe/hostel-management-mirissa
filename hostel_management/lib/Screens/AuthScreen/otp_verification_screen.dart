import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hostel_management/Const/font_weight_const.dart';
import 'package:hostel_management/LocalServices/shared_pref_service.dart';
import 'package:hostel_management/Screens/AuthScreen/create_new_password.dart';
import 'package:hostel_management/Services/auth_service.dart';
import 'package:hostel_management/Widgets/PageRoute/custom_page_route.dart';
import 'package:hostel_management/Widgets/Text/inter_text_widget.dart';
import 'package:hostel_management/Widgets/gradient_button.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String email;
  final String? userId; // Add userId parameter

  const OTPVerificationScreen({
    super.key, 
    required this.email,
    this.userId, // Make it optional for backward compatibility
  });

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  // Change to 4 controllers for 4-digit OTP
  final List<TextEditingController> _controllers = List.generate(
    4, // Changed from 6 to 4
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode()); // Changed from 6 to 4
  bool _isLoading = false;
  bool _isResending = false;

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    // Handle pasted OTP (multiple digits)
    if (value.length > 1) {
      _handlePastedOTP(value, index);
      return;
    }

    // Handle single digit input
    if (value.length == 1 && index < 3) { // Changed from 5 to 3
      _focusNodes[index + 1].requestFocus();
    }

    // Update UI state when text changes
    setState(() {});
  }

  void _onKeyEvent(KeyEvent event, int index) {
    // Handle backspace/delete for clearing boxes one by one
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.backspace ||
          event.logicalKey == LogicalKeyboardKey.delete) {
        if (_controllers[index].text.isEmpty && index > 0) {
          // If current box is empty and backspace is pressed, go to previous box and clear it
          _focusNodes[index - 1].requestFocus();
          _controllers[index - 1].clear();
        } else if (_controllers[index].text.isNotEmpty) {
          // If current box has text, clear it
          _controllers[index].clear();
        }
        setState(() {});
      }
    }
  }

  void _handlePastedOTP(String pastedText, int startIndex) {
    // Clean the pasted text to only include digits
    String cleanedText = pastedText.replaceAll(RegExp(r'[^0-9]'), '');

    // Limit to 4 digits maximum (changed from 6)
    if (cleanedText.length > 4) {
      cleanedText = cleanedText.substring(0, 4);
    }

    // Clear all fields first
    for (var controller in _controllers) {
      controller.clear();
    }

    // Fill the controllers starting from the first box
    for (int i = 0; i < cleanedText.length && i < 4; i++) { // Changed from 6 to 4
      _controllers[i].text = cleanedText[i];
    }

    // Focus on the next empty box or the last box if all are filled
    if (cleanedText.length < 4) { // Changed from 6 to 4
      _focusNodes[cleanedText.length].requestFocus();
    } else {
      _focusNodes[3].requestFocus(); // Changed from 5 to 3
      // Hide keyboard when all fields are filled
      FocusScope.of(context).unfocus();
    }

    setState(() {});
  }

  bool _isOTPComplete() {
    return _controllers.every((controller) => controller.text.isNotEmpty);
  }

  String _getOTP() {
    return _controllers.map((controller) => controller.text).join();
  }

  Future<void> _verifyOTP() async {
    if (!_isOTPComplete() || _isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Use userId from widget parameter or fallback to SharedPrefs
      final userId = widget.userId ?? await SharedPrefService.getUserId();
      
      if (userId == null) {
        throw Exception('User ID not found. Please restart the process.');
      }

      final otp = _getOTP();
      final response = await ApiService.verifyOtp(userId, otp);
      print('OTP Verification Response: $response');

      // Hide keyboard before navigation
      FocusScope.of(context).unfocus();

      // Navigate to create new password screen with userId and verified OTP
      Navigator.pushReplacement(
        context,
        ScalePageRoute(
          page: CreateNewPassword(
            userId: userId,
            verifiedOtp: otp, // Pass the verified OTP
          ),
        ),
      );
    } catch (e) {
      print('Error verifying OTP: $e');
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to verify OTP. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _resendOTP() async {
    if (_isResending) return;

    setState(() {
      _isResending = true;
    });

    try {
      final response = await ApiService.forgotPassword(widget.email);
      print('Resend OTP Response: $response');

      // Clear all fields when resending
      _clearAllFields();

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('OTP sent successfully to ${widget.email}'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      print('Error resending OTP: $e');
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to resend OTP. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isResending = false;
        });
      }
    }
  }

  void _clearAllFields() {
    for (var controller in _controllers) {
      controller.clear();
    }
    _focusNodes[0].requestFocus();
    setState(() {});
  }

  Widget _buildOTPField(int index) {
    return Container(
      width: 56, // Slightly wider for 4 fields (was 48 for 6 fields)
      height: 56,
      decoration: BoxDecoration(
        color: Color(0xFFF9FAFB),
        border: Border.all(
          color:
              _controllers[index].text.isNotEmpty
                  ? Color(0xFF0EA5E9)
                  : Color(0xFFE5E7EB),
          width: _controllers[index].text.isNotEmpty ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: KeyboardListener(
        focusNode: FocusNode(),
        onKeyEvent: (event) => _onKeyEvent(event, index),
        child: TextField(
          controller: _controllers[index],
          focusNode: _focusNodes[index],
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          style: GoogleFonts.inter(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Color(0xFF111827),
          ),
          inputFormatters: [
            // Allow pasting of multiple digits but limit to 4 digits total
            LengthLimitingTextInputFormatter(4), // Changed from 6 to 4
            FilteringTextInputFormatter.digitsOnly,
          ],
          decoration: InputDecoration(
            counterText: '',
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
          ),
          onChanged: (value) {
            _onChanged(value, index);
          },
          onTap: () {
            _controllers[index].selection = TextSelection.fromPosition(
              TextPosition(offset: _controllers[index].text.length),
            );
          },
          onEditingComplete: () {
            // Hide keyboard when all fields are complete
            if (_isOTPComplete()) {
              FocusScope.of(context).unfocus();
            }
          },
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    bool isComplete = _isOTPComplete();

    return GestureDetector(
      onTap: isComplete && !_isLoading ? _verifyOTP : null,
      child: Container(
        width: double.infinity,
        height: 56,
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isComplete ? null : Color(0xFFE5E7EB),
          gradient:
              isComplete
                  ? LinearGradient(
                    colors: [Color(0xFF0EA5E9), Color(0xFF2853AF)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  )
                  : null,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child:
              _isLoading
                  ? SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      strokeWidth: 2,
                    ),
                  )
                  : InterTextWidget(
                    text: 'Continue',
                    fontSize: 18,
                    color: isComplete ? Colors.white : Color(0xFF9CA3AF),
                    fontWeight: FontWeightConst.semiBold,
                  ),
        ),
      ),
    );
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
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight:
                MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                kToolbarHeight,
          ),
          child: IntrinsicHeight(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.045),

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

                  // Welcome Text
                  InterTextWidget(
                    text: 'Welcome',
                    fontSize: 24,
                    color: Color(0xFF111827),
                    fontWeight: FontWeightConst.bold,
                    letterSpacing: 0,
                  ),

                  SizedBox(height: 8),

                  // Enter OTP Text
                  InterTextWidget(
                    text: 'Enter OTP',
                    fontSize: 24,
                    color: Color(0xFF111827),
                    fontWeight: FontWeightConst.bold,
                    letterSpacing: 0.5,
                  ),

                  SizedBox(height: 16),

                  // Description Text - Updated for 4-digit
                  Text.rich(
                    TextSpan(
                      text:
                          'We have just sent you 4 digit code via your\nemail ', // Changed from 6 to 4
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: Color(0xFF434E58),
                        fontWeight: FontWeight.w400,
                      ),
                      children: [
                        TextSpan(
                          text: widget.email,
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            color: Color(0xFF171725),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 38),

                  // OTP Input Fields
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                          4, // Changed from 6 to 4
                          (index) => _buildOTPField(index),
                        ),
                      ),
                      SizedBox(height: 18),

                      // Continue Button
                      _buildContinueButton(),

                      SizedBox(height: 24),

                      // Resend Code
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Didn\'t receive code? ',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: Color(0xFF66707A),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          GestureDetector(
                            onTap: _isResending ? null : _resendOTP,
                            child:
                                _isResending
                                    ? SizedBox(
                                      width: 16,
                                      height: 16,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                              Color(0xFF2853AF),
                                            ),
                                        strokeWidth: 2,
                                      ),
                                    )
                                    : Text(
                                      'Resend Code',
                                      style: GoogleFonts.inter(
                                        fontSize: 14,
                                        color: Color(0xFF2853AF),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Flexible spacer that adjusts when keyboard appears
                  Expanded(child: SizedBox(height: 20)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}