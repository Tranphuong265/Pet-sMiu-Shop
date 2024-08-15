import 'package:flutter/material.dart';
import 'package:app_api/app/page/auth/login.dart';
import 'package:app_api/app/page/register.dart';

import 'dart:math';

class ConfirmOtpPage extends StatefulWidget {
  const ConfirmOtpPage({Key? key}) : super(key: key);

  @override
  State<ConfirmOtpPage> createState() => _ConfirmOtpPageState();
}

class _ConfirmOtpPageState extends State<ConfirmOtpPage> {
  static String _generateRandomNumberID() {
    final random = Random();
    return List.generate(10, (_) => random.nextInt(10)).join();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    },
                    backgroundColor: const Color.fromRGBO(170, 213, 209, 10),
                    shape: const CircleBorder(),
                    child: const Icon(Icons.arrow_back_ios,color: Colors.white,),
                  ),
                ),
                const Expanded(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Xác nhận đăng ký',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 80,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 35),
              child: Text(
                'Nhập mã xác nhận được gửi về số điện thoại của bạn (6 ký tự)',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.only(left: 35),
              child: Text(
                'Mã xác nhận',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  child: TextFormField(
    decoration: const InputDecoration(
      hintText: 'Nhập mã xác nhận',
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color.fromRGBO(170, 213, 209, 1), // Màu viền khi TextFormField không được focus
          width: 1.0,
        ),
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color.fromRGBO(170, 213, 209, 1), // Màu viền khi TextFormField được focus
          width: 2.0,
        ),
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color.fromRGBO(170, 213, 209, 1), // Màu viền khi có lỗi
          width: 1.0,
        ),
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color.fromRGBO(189, 189, 189, 1), // Màu viền khi TextFormField bị vô hiệu hóa
          width: 1.0,
        ),
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      contentPadding: EdgeInsets.fromLTRB(20.0, 24.0, 20.0, 24.0),
      fillColor: Color.fromRGBO(176, 238, 231, 0.5), // Màu nền mờ
      filled: true, // Đảm bảo nền được lấp đầy
    ),
  ),
),
            const Padding(
              padding: EdgeInsets.only(left: 35),
              child: Text(
                'Yêu cầu gửi lại mã',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
              ),
            ),
            const SizedBox(height: 200),
            Center(
              child: SizedBox(
                width: 450,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    backgroundColor: const Color.fromRGBO(170, 213, 209, 10),
                    minimumSize: const Size(0, 50),
                    padding: const EdgeInsets.symmetric(vertical: 25),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                  },
                  child: const Text(
                    'Xác nhận',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
