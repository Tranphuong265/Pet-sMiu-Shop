import 'package:app_api/app/page/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_api/app/page/auth/login.dart'; // Đảm bảo import đúng đường dẫn
import 'package:app_api/app/data/api.dart'; // Đảm bảo import đúng đường dẫn

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController _currentPassController = TextEditingController();
  final TextEditingController _newPassController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  @override
  void dispose() {
    _currentPassController.dispose();
    _newPassController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  Future<void> _changePassword() async {
    String currentPassword = _currentPassController.text.trim();
    String newPassword = _newPassController.text.trim();
    String confirmPassword = _confirmPassController.text.trim();

    if (currentPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mật khẩu cũ không được bỏ trống')),
      );
      return;
    }

    if (newPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mật khẩu mới không được bỏ trống')),
      );
      return;
    }

    if (confirmPassword != newPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mật khẩu xác nhận không khớp')),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    try {
      final body = FormData.fromMap({
        'OldPassword': currentPassword,
        'NewPassword': newPassword,
      });

      Response res = await Dio().put(
        'https://huflit.id.vn:4321/api/Auth/ChangePassword',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
        data: body,
      );

      if (res.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Đổi mật khẩu thành công')),
        );
        // Đăng xuất người dùng và điều hướng đến trang đăng nhập
        await prefs.remove('token');
        await prefs.remove('user');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Đổi mật khẩu thất bại')),
        );
      }
    } catch (e) {
      print("Error changing password: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lỗi hệ thống, vui lòng thử lại sau')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Đổi mật khẩu',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Image.asset('assets/images/roll_back.png'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(35.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color.fromRGBO(170, 213, 209, 1)),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  controller: _currentPassController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Mật khẩu cũ",
                    labelStyle: TextStyle(color: Colors.black),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.fromLTRB(12, 16, 12, 16),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color.fromRGBO(170, 213, 209, 1)),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  controller: _newPassController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Mật khẩu mới",
                    labelStyle: TextStyle(color: Colors.black),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.fromLTRB(12, 16, 12, 16),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color.fromRGBO(170, 213, 209, 1)),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  controller: _confirmPassController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Xác nhận mật khẩu mới",
                    labelStyle: TextStyle(color: Colors.black),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.fromLTRB(12, 16, 12, 16),
                  ),
                ),
              ),
              const SizedBox(height: 60),
              Center(
                child: ElevatedButton(
                  onPressed: _changePassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 180, 236, 237), // Màu nền
                    foregroundColor: Colors.white, // Màu chữ
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    textStyle: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
                  ),
                  child: const Text('Đổi mật khẩu'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
