import 'package:flutter/material.dart';
import 'package:app_api/app/page/auth/login.dart';
import 'package:url_launcher/url_launcher.dart';


class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

   void _launchURL(String url) async { 





































































































































































































































































    
    if (!await launch(url)) {
      throw 'Could not launch $url';
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(176, 238, 231, 1),
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              Column(
                children: [
                  //ICon bên trái hihi
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: ClipRRect(
                        child: Image.asset(
                          'assets/images/chanmeologo.png',
                          width: 55,
                          height: 55,
                        ),
                      ),
                    ),
                  ),
                  //Hình ảnh con mèo
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset(
                      'assets/images/meo.png',
                      width: 431.0,
                      height: 419.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              //Biểu tượng và text
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: 370,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(120),
                          topRight: Radius.circular(120))),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Image.asset(
                        'assets/images/chanmeo.png',
                        width: 60,
                        height: 60,
                        //fit: BoxFit.cover,
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      const Text(
                        'Chào mừng đến với \nPet\'s Miu',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 32.0,
                          fontFamily: 'Mulish',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 40),
                      // Nút OK
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(
                              170, 213, 209, 1), // Màu nền của nút
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 130.0, vertical: 10.0),
                        ),
                        child: const Text(
                          'OK',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Color.fromARGB(255, 252, 252, 252),
                          ),
                        ),
                      ),
                    const SizedBox(height: 20),
                      // Liên kết văn bản
                      GestureDetector(
                        onTap: () {
                          _launchURL('https://youtu.be/U_Wi5oPBco8');
                        },
                        child: const Text(
                          'Ấn vô đây',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}