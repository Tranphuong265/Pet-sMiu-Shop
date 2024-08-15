import 'package:app_api/app/config/const.dart';
import 'package:app_api/app/data/api.dart';
import '../register.dart';
import 'package:app_api/mainpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../../data/sharepre.dart';
import 'package:app_api/app/page/auth/forgotPassword.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController accountController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //
  bool _obscurePassword = true;
  final _passWordcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  //



  login() async {
    //lấy token (lưu share_preference)
    String token = await APIRepository()
        .login(accountController.text, passwordController.text);
    var user = await APIRepository().current(token);
    // save share
    saveUser(user);
    //
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Mainpage()));
    return token;
  }

  @override
  void initState() {
    super.initState();
    // autoLogin();
  }

  autoLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('user') != null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Mainpage()));
    }
  }
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:Image.asset(
                        'assets/images/chanmeologo.png',
                        width: 55,
                        height: 55,
      ),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                children: [
                  const Text(
                  'Đăng Nhập',
                  style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Mulish',
                      color: Color.fromRGBO(50, 75, 73, 1)),
                ),
                const SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Canh giữa các button
                    children: [
                      SizedBox(
                        width: 176,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            //  "Đăng nhập bằng Google"
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(170, 213, 209, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/googleIcon.webp', // Đường dẫn đến file ảnh logo Google
                                width: 20.0,
                                height: 20.0,
                              ),
                              const SizedBox(
                                  width: 8.0), // Khoảng cách giữa icon và text
                              const Text(
                                'With Google',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                          width: 8.0), // Khoảng cách 8 độ giữa các button
                      SizedBox(
                        width: 55,
                        height: 50,
                        child: GestureDetector(
                          onTap: () {
                            //  "Đăng nhập bằng Facebook"
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(
                                    color: Color.fromRGBO(
                                  170,
                                  213,
                                  209,
                                  1,
                                )),
                                color: Colors.white),
                            child: Icon(
                              Icons.facebook,
                              color: Color.fromRGBO(129, 181, 176, 1),
                              size: 32,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                          width: 8.0), // Khoảng cách 8 độ giữa các button
                      SizedBox(
                        width: 55,
                        height: 50,
                        child: GestureDetector(
                          onTap: () {
                            //  "Đăng nhập bằng Twitter"
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(255, 255, 255, 1),
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(
                                  color: Color.fromRGBO(
                                    170,
                                    213,
                                    209,
                                    1,
                                  ),
                                )),
                            child: Center(
                              child: Image.asset(
                                'assets/images/iconTW.png',
                                width: 35,
                                height: 35,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'với Số điện thoại',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      fontFamily: 'Mulish'),
                ),
                const SizedBox(height: 30), // khung điền số điện thoại
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFormField(
                    //controller: _phoneNumbercontroller,
                    controller: accountController,
                    decoration: const InputDecoration(
                      hintText: 'Số điện thoại',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(170, 213, 209,
                              1), // Màu viền khi TextFormField không được focus
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(170, 213, 209,
                              1), // Màu viền khi TextFormField được focus
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(
                              170, 213, 209, 1), // Màu viền khi có lỗi
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                      disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(189, 189, 189,
                                1), // Màu viền khi TextFormField bị vô hiệu hóa
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 24.0, 20.0, 24.0),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập số điện thoại của bạn';
                      }
                      return null;
                    },
                  ),
                ),
                /*
                  TextFormField(
                    controller: accountController,
                    decoration: const InputDecoration(
                      labelText: "Account",
                      icon: Icon(Icons.person),
                    ),
                  ),*/
                  const SizedBox(height: 5),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFormField(
                    //controller: _passWordcontroller,
                    controller: passwordController,

                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      hintText: 'Mật khẩu',
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(170, 213, 209,
                              1), // Màu viền khi TextFormField không được focus
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(170, 213, 209,
                              1), // Màu viền khi TextFormField được focus
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(
                              170, 213, 209, 1), // Màu viền khi có lỗi
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                      disabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(189, 189, 189,
                                1), // Màu viền khi TextFormField bị vô hiệu hóa
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      contentPadding:
                          const EdgeInsets.fromLTRB(20.0, 24.0, 20.0, 24.0),
                      suffixIcon: IconButton(
                        icon: Icon(_obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập mật khẩu của bạn';
                      }
                      return null;
                    },
                  ),
                ),
                  /*
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Password",
                      icon: Icon(Icons.password),
                    ),
                  ),*/
                  const SizedBox(height: 10),
                  const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 250),
                      child: Text(
                        '',
                        style:
                            TextStyle(color: Color.fromRGBO(170, 213, 209, 10)),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ForgotpasswordPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'Quên mật khẩu?',
                        style: TextStyle(
                          color: Color.fromRGBO(53, 122, 72, 10),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Chưa có tài khoản? ',
                      style: TextStyle(color: Color.fromRGBO(21, 52, 72, 1)),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Register()));
                        /*
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const RegisterPage()), // Replace with your Forgot Password page
                        );*/
                      },
                      child: const Text(
                        'Đăng ký',
                        style: TextStyle(
                            color: Color.fromRGBO(41, 102, 97, 1),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),
                SizedBox(
                  width: 400,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          backgroundColor:
                              const Color.fromRGBO(170, 213, 209, 10),
                          minimumSize: const Size(0, 50),
                          padding: const EdgeInsets.symmetric(vertical: 14)),
                          onPressed: login,
                          /*
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Mainpage()),
                          );
                        }
                      },*/
                      child: const Text(
                        'Đăng nhập',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                /*
                  Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                        onPressed: login,
                        child: const Text("Login"),
                      )),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                          child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Register()));
                        },
                        child: const Text("Register"),
                      ))
                    ],
                  )*/
                ],
              ),
            ),
          ),
        ),
      ),
    );
    
  }
}
