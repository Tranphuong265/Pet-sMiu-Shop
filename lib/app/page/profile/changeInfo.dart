import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_api/app/page/profile/detail.dart';
import 'package:app_api/app/model/user.dart';
import 'package:app_api/app/data/api.dart'; // Đảm bảo import đúng đường dẫn
import 'dart:convert';
import 'package:dio/dio.dart';  // Import thư viện Dio

class Changeinfo extends StatefulWidget {
  const Changeinfo({super.key});

  @override
  State<Changeinfo> createState() => _ChangeInfoState();
}

class _ChangeInfoState extends State<Changeinfo> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getDataUser();
  }

  void _getDataUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String strUser = pref.getString('user') ?? '';
    if (strUser.isNotEmpty) {
      User user = User.fromJson(jsonDecode(strUser));
      _nameController.text = user.fullName ?? '';
      _phoneController.text = user.phoneNumber ?? '';
      _genderController.text = user.gender ?? '';
      _dateController.text = user.birthDay ?? '';
    } else {
      print('Không có dữ liệu người dùng trong SharedPreferences');
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _genderController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  void _showGenderPicker() async {
    final selectedGender = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Chọn giới tính'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: const Text('Nam'),
              onTap: () => Navigator.pop(context, 'Nam'),
            ),
            ListTile(
              title: const Text('Nữ'),
              onTap: () => Navigator.pop(context, 'Nữ'),
            ),
            ListTile(
              title: const Text('Khác'),
              onTap: () => Navigator.pop(context, 'Khác'),
            ),
          ],
        ),
      ),
    );

    if (selectedGender != null) {
      setState(() {
        _genderController.text = selectedGender;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        _dateController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
      });
    }
  }

  Future<bool> updateProfile(User user, String token) async {
    try {
      final body = FormData.fromMap({
        "numberID": user.idNumber,
        "accountID": user.accountId,
        "fullName": user.fullName,
        "phoneNumber": user.phoneNumber,
        "imageURL": user.imageURL,
        "birthDay": user.birthDay,
        "gender": user.gender,
        "schoolYear": user.schoolYear,
        "schoolKey": user.schoolKey,
      });

      Response res = await Dio().put(
        'https://huflit.id.vn:4321/api/Auth/updateProfile',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
        data: body,
      );
      print("Thành công");
      return res.statusCode == 200;
    } catch (e) {
      print("Error updating profile: $e");
      return false;
    }
  }

  void _validateAndSubmit() async {
    String name = _nameController.text.trim();
    String phone = _phoneController.text.trim();
    String gender = _genderController.text.trim();
    String dateOfBirth = _dateController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Họ và tên không được bỏ trống')),
      );
      return;
    }

    if (phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Số điện thoại không được bỏ trống')),
      );
      return;
    }

    if (gender.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Giới tính không được bỏ trống')),
      );
      return;
    }

    if (dateOfBirth.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ngày sinh không được bỏ trống')),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    // Lấy thông tin người dùng từ SharedPreferences
    String strUser = prefs.getString('user') ?? '';
    User user = User.fromJson(jsonDecode(strUser));

    // Cập nhật thông tin người dùng
    user.fullName = name;
    user.phoneNumber = phone;
    user.birthDay = dateOfBirth;
    user.gender = gender;

    bool success = await updateProfile(user, token);

    if (success) {
      await prefs.setString('user', jsonEncode(user.toJson()));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Detail(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cập nhật thông tin thất bại')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Thay đổi thông tin',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Image.asset('assets/images/roll_back.png'),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const Detail(),
              ),
            );
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
                  border:
                      Border.all(color: const Color.fromRGBO(170, 213, 209, 1)),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: "Họ và tên",
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
                  border:
                      Border.all(color: const Color.fromRGBO(170, 213, 209, 1)),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    labelText: "Số điện thoại",
                    labelStyle: TextStyle(color: Colors.black),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.fromLTRB(12, 16, 12, 16),
                  ),
                  keyboardType: TextInputType.phone,
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  border:
                      Border.all(color: const Color.fromRGBO(170, 213, 209, 1)),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  controller: _genderController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: "Giới tính",
                    labelStyle: TextStyle(color: Colors.black),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.fromLTRB(12, 16, 12, 16),
                  ),
                  onTap: _showGenderPicker,
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  border:
                      Border.all(color: const Color.fromRGBO(170, 213, 209, 1)),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  controller: _dateController,
                  decoration: const InputDecoration(
                    labelText: "Ngày sinh",
                    labelStyle: TextStyle(color: Colors.black),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.fromLTRB(12, 16, 12, 16),
                  ),
                  readOnly: true,
                  onTap: () => _selectDate(context),
                ),
              ),
              const SizedBox(height: 90),
              Center(
                child: ElevatedButton(
                  onPressed: _validateAndSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(170, 213, 209, 1), // Màu nền của nút
                    foregroundColor: Colors.white, // Màu chữ của nút
                    padding: const EdgeInsets.symmetric(horizontal: 85, vertical: 16), // Kích thước nút
                    textStyle: const TextStyle(fontSize: 18), // Kích thước chữ
                  ),
                  child: const Text('Thay đổi thông tin'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
