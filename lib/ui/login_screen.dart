import 'package:flutter/material.dart';
import 'package:otp/ui/otp_screen.dart';
import '../country_picker.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPhoneNumberFocused = false;
  bool _isPasswordFocused = false;
  bool _isPhoneNumberValid = true;
  bool _isPasswordValid = true;
  late CountryModel _selectedCountry;

  @override
  void initState() {
    super.initState();
    _selectedCountry = const CountryModel(name: 'United States', dialCode: '+1', code: 'US', flag: '🇺🇸'); // Set default country
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/registration.png',
                  height: screenHeight * 0.3,
                  fit: BoxFit.contain,
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                const Text(
                  'Login',
                  style: TextStyle(fontSize: 28, color: Colors.black),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                SizedBox(
                  height: screenHeight * 0.04,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: screenWidth > 600 ? screenWidth * 0.2 : 16),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0),
                        blurRadius: 6.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CountryPicker(
                            callBackFunction: (name, dialCode, flag) {
                              setState(() {
                                _selectedCountry = CountryModel(name: name, dialCode: dialCode, code: _selectedCountry.code, flag: flag);
                              });
                            },
                            headerText: 'Select Country',
                            headerBackgroundColor: Theme.of(context).primaryColor,
                            headerTextColor: Colors.white,
                          ),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: TextField(
                              controller: _phoneNumberController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                hintText: 'Phone Number',
                                errorText: _isPhoneNumberFocused && !_isPhoneNumberValid ? 'Enter a valid phone number' : null,
                                prefixIcon: const Icon(Icons.phone),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _isPhoneNumberValid = value.length == 10;
                                });
                              },
                              onTap: () {
                                setState(() {
                                  _isPhoneNumberFocused = true;
                                  _isPasswordFocused = false; // Reset password field focus
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          errorText: _isPasswordFocused && !_isPasswordValid ? 'Password must be at least 6 characters' : null,
                          prefixIcon: const Icon(Icons.lock),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _isPasswordValid = value.length >= 6;
                          });
                        },
                        onTap: () {
                          setState(() {
                            _isPasswordFocused = true;
                            _isPhoneNumberFocused = false; // Reset phone number field focus
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => const OtpScreen()),
                              );
                            },
                            child: const Text(
                              'Forget Password?',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (_isPhoneNumberValid && _isPasswordValid) {
                                print('Phone Number: ${_phoneNumberController.text}');
                                print('Password: ${_passwordController.text}');
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Please enter valid phone number and password.'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.yellow,
                              foregroundColor: Colors.black,
                            ),
                            child: const Text('Login'),
                          ),
                        ],
                      ),
                    ],
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
