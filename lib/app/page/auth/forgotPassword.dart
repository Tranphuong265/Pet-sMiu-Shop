import 'package:flutter/material.dart';
import 'package:app_api/app/page/auth/login.dart';

class ForgotpasswordPage extends StatefulWidget {
  const ForgotpasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotpasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotpasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quên mật khẩu',
        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Mulish',
                            color: Color.fromRGBO(50, 75, 73, 1)),
),
        centerTitle: true,
        leading: IconButton(
          icon: Image.asset('assets/images/roll_back.png'), // Thay đổi icon ở đây
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 35),
              child: Text(
                'Nhập mã xác nhận để đặt lại mật khẩu gửi về số điện thoại của bạn (6 ký tự)',
                style: TextStyle(
                  fontSize: 14,
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
                      color: Color.fromRGBO(166, 203, 199,
                          0.767), // Màu viền khi TextFormField không được focus
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(176, 238, 231,
                          1), // Màu viền khi TextFormField được focus
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(
                          170, 213, 209, 1), // Màu viền khi có lỗi
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(189, 189, 189,
                          1), // Màu viền khi TextFormField bị vô hiệu hóa
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(20.0, 24.0, 20.0, 24.0),
                  fillColor: Color.fromRGBO(176, 238, 231, 0.25), // Màu nền mờ
                  filled: true, // Đảm bảo nền được lấp đầy
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 35),
              child: Text(
                'Yêu cầu gửi lại mã OTP',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal),
              ),
            ),
            const SizedBox(height: 350),
            Center(
              child: SizedBox(
                width: 350,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    backgroundColor: const Color.fromRGBO(170, 213, 209, 10),
                    minimumSize: const Size(0, 50),
                    padding: const EdgeInsets.symmetric(vertical: 10),
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
                      fontSize: 24,
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
