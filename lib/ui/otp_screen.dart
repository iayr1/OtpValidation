import 'package:flutter/material.dart';
import '../country_picker.dart'; // Import CountryPicker widget
import 'forget_password_screen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late TextEditingController _phoneNumberController;
  late TextEditingController _otpController;
  late CountryModel _selectedCountry; // Add selectedCountry variable

  @override
  void initState() {
    super.initState();
    _phoneNumberController = TextEditingController();
    _otpController = TextEditingController();
    _selectedCountry = const CountryModel(
        name: 'United States', dialCode: '+1', code: 'US', flag: '🇺🇸');
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  void _verifyPhoneNumber() {
    String phoneNumber =
        _selectedCountry.dialCode + _phoneNumberController.text;
    print('Verifying Phone Number: $phoneNumber');
  }

  void _verifyOtp(BuildContext context) {
    String otpCode = _otpController.text;
    print('Verifying OTP Code: $otpCode');

    // Navigate to ForgetPasswordScreen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ForgetPasswordScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Select your country:',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18.0),
                ),
                const SizedBox(height: 20.0),
                CountryPicker(
                  callBackFunction: (name, dialCode, flag) {
                    setState(() {
                      _selectedCountry = CountryModel(
                          name: name, dialCode: dialCode, flag: flag, code: '');
                    });
                  },
                  headerText: 'Select Country',
                  headerBackgroundColor: Theme.of(context).primaryColor,
                  headerTextColor: Colors.white,
                ),
                const SizedBox(height: 20.0),
                TextField(
                  controller: _phoneNumberController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: _verifyPhoneNumber,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    'Send OTP',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(height: 40.0),
                const Text(
                  'Enter OTP sent to your phone:',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18.0),
                ),
                const SizedBox(height: 20.0),
                TextField(
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'OTP Code',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () => _verifyOtp(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    'Verify OTP',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
