import 'package:app_api/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:app_api/app/page/cart/cart_screen.dart';
import 'package:app_api/app/page/home/home_screen.dart';


class PaymentSuccess extends StatelessWidget {
  const PaymentSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/images/chanmeologo.png', // Đường dẫn tới hình ảnh
                        width: 200,
                        height: 150,
                        //fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 60.0),
                    const Text(
                      'Đặt hàng thành công!!\nMeow meow~~',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 37,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Montserrat',
                        color: Color.fromRGBO(50, 75, 73, 1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Mainpage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(190, 232, 228, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 120.0,
                    vertical: 9.0,
                  ),
                ),
                child: const Text(
                  'Quay lại',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
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
