import 'package:app_api/app/data/api.dart';
import 'package:app_api/app/model/register.dart';
import 'package:app_api/app/page/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:app_api/app/page/auth/OTP.dart';

import 'dart:math';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String? _gender;
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _numberIDController = TextEditingController(text: _generateRandomNumberID());
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController(text: '0' + _generateRandomPhone());
  final TextEditingController _schoolKeyController = TextEditingController(text: '2024');
  final TextEditingController _schoolYearController = TextEditingController(text: '2024');
  final TextEditingController _birthDayController = TextEditingController();
  final TextEditingController _imageURL = TextEditingController(text: '');
  String temp = '';

  // Quản lý trạng thái ẩn/hiện mật khẩu cho từng trường
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  Future<String> register() async {
    return await APIRepository().register(Signup(
        accountID: _accountController.text,
        birthDay: _birthDayController.text,
        password: _passwordController.text,
        confirmPassword: _confirmPasswordController.text,
        fullName: _fullNameController.text,
        phoneNumber: _phoneNumberController.text,
        schoolKey: _schoolKeyController.text,
        schoolYear: _schoolYearController.text,
        gender: getGender(),
        imageUrl: _imageURL.text,
        numberID: _numberIDController.text));
  }

  static String _generateRandomNumberID() {
    final random = Random();
    return List.generate(10, (_) => random.nextInt(10)).join();
  }

  static String _generateRandomPhone() {
    final random = Random();
    return List.generate(9, (_) => random.nextInt(9)).join();
  }

  String getGender() {
    return _gender ?? "Other";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset(
          'assets/images/chanmeologo.png',
          width: 55,
          height: 55,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 16),
              child: const Text(
                'Đăng Ký',
                style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Mulish',
                    color: Color.fromRGBO(50, 75, 73, 1)),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    signUpWidget(),
                    const SizedBox(height: 50),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              width: 300, // Chiều rộng cụ thể
                              height: 60, // Chiều cao cụ thể
                              child: ElevatedButton(
                                /*onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ConfirmOtpPage()),
                          );
                        },*/
                                
                                onPressed: () async {
                                  String response = await register();
                                  if (response == "ok") {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const LoginScreen(),
                                      ),
                                    );
                                  } else {
                                    print(response);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50), // Bán kính bo góc
                                  ),
                                  backgroundColor: const Color.fromRGBO(170, 213, 209, 1), // Màu nền
                                ),
                                child: const Text(
                                  'Đăng ký',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold), // Kích thước chữ
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget textField(
    TextEditingController controller,
    String hint, {
    bool obscureText = false, // Thay đổi để yêu cầu trạng thái ẩn/hiện mật khẩu
    Widget? suffixIcon, // Thêm suffixIcon để tùy chọn hiển thị icon
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(
              color: Colors.teal,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(
              color: Colors.teal,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(
              color: Colors.teal,
            ),
          ),
          suffixIcon: suffixIcon, // Hiển thị suffixIcon nếu có
        ),
      ),
    );
  }

  Widget signUpWidget() {
    return Column(
      children: [
        textField(_fullNameController, "Họ và tên"),
        const SizedBox(height: 10),
        textField(_accountController, "Số điện thoại"),
        const SizedBox(height: 10),
        textField(
          _passwordController,
          "Mật khẩu",
          obscureText: _obscurePassword,
          suffixIcon: IconButton(
            icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
            onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
          ),
        ),
        const SizedBox(height: 10),
        textField(
          _confirmPasswordController,
          "Nhập lại mật khẩu",
          obscureText: _obscureConfirmPassword,
          suffixIcon: IconButton(
            icon: Icon(_obscureConfirmPassword ? Icons.visibility_off : Icons.visibility),
            onPressed: () {
              setState(() {
                _obscureConfirmPassword = !_obscureConfirmPassword;
              });
            },
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                value: _gender,
                hint: const Text("Giới tính"),
                items: const [
                  DropdownMenuItem(
                    value: "Male",
                    child: Text("Nam"),
                  ),
                  DropdownMenuItem(
                    value: "Female",
                    child: Text("Nữ"),
                  ),
                  DropdownMenuItem(
                    value: "Other",
                    child: Text("Khác"),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _gender = value!;
                  });
                },
                decoration: InputDecoration(
                  hintText: "Giới tính",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: const BorderSide(
                      color: Colors.teal,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: const BorderSide(
                      color: Colors.teal,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: const BorderSide(
                      color: Colors.teal,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: TextFormField(
                controller: _birthDayController,
                decoration: InputDecoration(
                  hintText: 'Ngày sinh',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: const BorderSide(
                      color: Colors.teal,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: const BorderSide(
                      color: Colors.teal,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: const BorderSide(
                      color: Colors.teal,
                    ),
                  ),
                  suffixIcon: const Icon(
                    Icons.calendar_today,
                    color: Colors.teal,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
