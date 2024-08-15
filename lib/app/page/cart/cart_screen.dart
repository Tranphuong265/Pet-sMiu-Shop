import 'package:app_api/app/data/api.dart';
import 'package:app_api/app/data/sqlite.dart';
import 'package:app_api/app/model/cart.dart';
import 'package:app_api/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:app_api/app/page/cart/paymentSuccess.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

import 'package:flutter/rendering.dart';
import 'package:flutter/cupertino.dart'; 

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<List<Cart>> _getProducts() async {
    return await _databaseHelper.products();
  }
  // Hàm tính tổng tiền từ các sản phẩm trong giỏ hàng
  double _calculateTotal(List<Cart> cartItems) {
    double total = 0;
    for (var item in cartItems) {
      total += item.price * item.count; // Cộng dồn giá của từng sản phẩm
    }
    return total;
  }

  String address = 'Địa chỉ nhận hàng';
  String receiverName = 'Tên người nhận';
  String phoneNumber = '(+84) ';
  String street = 'Số + tên đường';
  String district = 'Phường, Quận, TP.HCM';

  void _editFields() {
    TextEditingController receiverController =
        TextEditingController(text: receiverName);
    TextEditingController phoneController =
        TextEditingController(text: phoneNumber);
    TextEditingController streetController =
        TextEditingController(text: street);
    TextEditingController districtController =
        TextEditingController(text: district);

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: const Text(
                'Địa chỉ nhận hàng',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(170, 213, 209, 1),
                ),
              ),
              content: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 60,
                        child: TextFormField(
                          controller: receiverController,
                          decoration: const InputDecoration(
                            labelText: 'Tên người nhận',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(170, 213, 209, 1),
                                width: 1.0,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(170, 213, 209, 1),
                                width: 2.0,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(170, 213, 209, 1),
                                width: 1.0,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(189, 189, 189, 1),
                                width: 1.0,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 24.0, 20.0, 24.0),
                            fillColor: Color.fromRGBO(176, 238, 231, 0.5),
                            filled: true,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Tên người nhận không được để trống';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 13),
                      SizedBox(
                        height: 60,
                        child: TextFormField(
                          controller: phoneController,
                          decoration: const InputDecoration(
                            labelText: 'Số điện thoại',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(170, 213, 209, 1),
                                width: 1.0,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(170, 213, 209, 1),
                                width: 2.0,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(170, 213, 209, 1),
                                width: 1.0,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(189, 189, 189, 1),
                                width: 1.0,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 24.0, 20.0, 24.0),
                            fillColor: Color.fromRGBO(176, 238, 231, 0.5),
                            filled: true,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Số điện thoại không được để trống';
                            }
                            final phoneNumber = value.trim();
                            if (phoneNumber.length < 10 ||
                                phoneNumber.length > 11) {
                              return 'Số điện thoại phải có từ 10 đến 11 chữ số';
                            }
                            if (!RegExp(r'^[0-9]+$').hasMatch(phoneNumber)) {
                              return 'Số điện thoại chỉ được chứa chữ số';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 13),
                      SizedBox(
                        height: 60,
                        child: TextFormField(
                          controller: streetController,
                          decoration: const InputDecoration(
                            labelText: 'Số + tên đường',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(170, 213, 209, 1),
                                width: 1.0,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(170, 213, 209, 1),
                                width: 2.0,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(170, 213, 209, 1),
                                width: 1.0,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(189, 189, 189, 1),
                                width: 1.0,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 24.0, 20.0, 24.0),
                            fillColor: Color.fromRGBO(176, 238, 231, 0.5),
                            filled: true,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Số + tên đường không được để trống';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 13),
                      SizedBox(
                        height: 60,
                        child: TextFormField(
                          controller: districtController,
                          decoration: const InputDecoration(
                            labelText: 'Phường, Quận, TP.HCM',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(170, 213, 209, 1),
                                width: 1.0,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(170, 213, 209, 1),
                                width: 2.0,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(170, 213, 209, 1),
                                width: 1.0,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(189, 189, 189, 1),
                                width: 1.0,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 24.0, 20.0, 24.0),
                            fillColor: Color.fromRGBO(176, 238, 231, 0.5),
                            filled: true,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Phường, Quận, TP.HCM không được để trống';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            // Xóa lỗi khi người dùng nhập liệu
                            _formKey.currentState?.validate();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue, // Màu nền xanh dương
                    foregroundColor: Colors.white, // Màu chữ trắng
                  ),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      setState(() {
                        receiverName = receiverController.text;
                        phoneNumber = phoneController.text;
                        street = streetController.text;
                        district = districtController.text;
                      });
                      Navigator.of(context).pop();
                    } else {
                      // Đặt lại các trường và xóa lỗi khi lưu
                      _formKey.currentState?.reset();
                    }
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue, // Màu nền xanh dương
                    foregroundColor: Colors.white, // Màu chữ trắng
                  ),
                  child: const Text('Save'),
                ),
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Giỏ hàng'),
        centerTitle: true,
        leading: IconButton(
          icon: Image.asset('assets/images/roll_back.png'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: FutureBuilder<List<Cart>>(
        future: _getProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Đã xảy ra lỗi: ${snapshot.error}'),
            );
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Giỏ hàng đang trống',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Mainpage()),
                      );
                    },
                    child: Text('Quay lại mua sắm'),
                  ),
                ],
              ),
            );
          } else {
            return Column(
              children: [
                //
                Expanded(
                  flex: 8, // Tỷ lệ chiếm 2 phần

                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: 350,
                      // height:10 ,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(202, 250, 245, 1),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(32)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 16, left: 40, top: 16, bottom: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                address,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  height: 2,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              InkWell(
                                onTap: _editFields,
                                child: Row(
                                  children: [
                                    Text(
                                      receiverName,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        height: 2,
                                      ),
                                    ),
                                    const Text(
                                      ' | ',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        height: 2,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        phoneNumber,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          height: 2,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: _editFields,
                                child: Text(
                                  street,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    height: 2,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: _editFields,
                                child: Text(
                                  district,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    height: 2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                //
                Expanded(
                  flex: 12, // Tỷ lệ chiếm 2 phần
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final itemProduct = snapshot.data![index];
                        return _buildProduct(itemProduct, context);
                      },
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Hiển thị tổng tiền hàng
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Tiền hàng ',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          Text(
                            '${NumberFormat.currency(locale: 'vi', symbol: 'đ').format(_calculateTotal(snapshot.data!))}',
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.0),
                      // Hiển thị giảm giá
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Giảm giá',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          Text(
                            '-${NumberFormat.currency(locale: 'vi', symbol: 'đ').format(50000)}', // Giảm giá cố định
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.0),
                      // Hiển thị phí vận chuyển
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Phí vận chuyển',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          Text(
                            '${NumberFormat.currency(locale: 'vi', symbol: 'đ').format(50000)}', // Phí vận chuyển cố định
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      // Hiển thị tổng tiền
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Tổng tiền',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                          Text(
                            '${NumberFormat.currency(locale: 'vi', symbol: 'đ').format(_calculateTotal(snapshot.data!) + 50000 - 50000 // Tổng tiền = Tiền hàng - Giảm giá + Phí vận chuyển
                                )}',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                          onPressed: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            List<Cart> temp = await _databaseHelper.products();

                            bool success = await APIRepository().addBill(
                              temp,
                              prefs.getString('token').toString(),
                            );

                            if (success) {
                              _databaseHelper.clear();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PaymentSuccess(),
                                ),
                              );
                            } else {
                              // Hiển thị thông báo lỗi nếu cần
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Failed to add bill')),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 32.0),
                            textStyle: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                            backgroundColor: Color.fromARGB(255, 163, 232, 239),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/cart.png', // Đường dẫn đến biểu tượng của bạn
                                width: 24.0, // Kích thước của biểu tượng
                                height: 24.0,
                                color: Colors.white,
                              ),
                              SizedBox(width: 8.0),
                              Text(
                                "Mua hàng",
                                style: TextStyle(
                                  color: Colors.white, // Màu chữ trắng
                                  fontSize: 20.0, // Kích thước chữ
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildProduct(Cart pro, BuildContext context) {
    double itemTotalPrice = pro.price * pro.count;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 10.0,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            Container(
              width: 75,
              height: 95,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: pro.img.isNotEmpty
                    ? DecorationImage(
                        image: NetworkImage(pro.img),
                        fit: BoxFit.cover,
                      )
                    : null,
                color: pro.img.isEmpty
                    ? Color.fromARGB(255, 216, 215, 215)
                    : Colors.transparent,
              ),
              child: pro.img.isEmpty
                  ? Center(
                      child: Text(
                        'No image',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pro.name,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  /*
                  Text(
                    pro.des,
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                  ),*/
                  const SizedBox(height: 8.0),
                  Text(
                    'Price: ' + NumberFormat('#,##0').format(itemTotalPrice),
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      DatabaseHelper().deleteProduct(pro.productID);
                      // Dummy function for delete
                      print('Delete product');
                    });
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Color.fromARGB(255, 238, 51, 82),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Color.fromARGB(255, 160, 226, 235),
                      ),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            //pro.count = (pro.count > 0) ? pro.count - 1 : 0;
                            DatabaseHelper().minus(pro);
                          });
                        },
                        icon: Icon(
                          Icons.remove,
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      pro.count.toString(),
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Color.fromARGB(255, 160, 226, 235),
                      ),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            //count++;
                            DatabaseHelper().add(pro);
                          });
                        },
                        icon: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
