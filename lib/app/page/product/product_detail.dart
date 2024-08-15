import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Để sử dụng định dạng số
import 'package:app_api/app/model/product.dart';
import 'dart:async';
import 'package:app_api/app/data/api.dart';
import 'package:app_api/app/data/sqlite.dart';
import 'package:app_api/app/model/cart.dart';
import 'package:app_api/app/page/cart/cart_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetailPage extends StatefulWidget {
  final ProductModel product;

  ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final DatabaseHelper _databaseService = DatabaseHelper();
  int _quantity = 1;
  late Timer _timer;
  int _cartCount = 0;

  Future<void> _getProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<ProductModel> allProducts = await APIRepository().getProductAdmin(
      prefs.getString('accountID').toString(),
      prefs.getString('token').toString(),
    );
    // Bạn có thể xử lý dữ liệu sản phẩm ở đây nếu cần
  }

  void _addToCart() async {
    await _databaseService.insertProduct(Cart(
      productID: widget.product.id,
      name: widget.product.name,
      des: widget.product.description,
      price: widget.product.price,
      img: widget.product.imageUrl,
      count: _quantity,
    ));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Đã thêm sản phẩm vào giỏ hàng')),
    );
    await _updateCartInfo();
  }

  void _increaseQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decreaseQuantity() {
    setState(() {
      if (_quantity > 1) {
        _quantity--;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getProducts();

    // Khởi tạo Timer để tự động chuyển đổi hình ảnh (nếu có)
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      // Thay đổi hình ảnh ở đây (nếu có)
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Hủy Timer để tránh rò rỉ bộ nhớ
    super.dispose();
  }

  Future<void> _updateCartInfo() async {
    final count = await _databaseService.getTotalCount();

    setState(() {
      _cartCount = count;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pet\'s Miu'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Image.asset('assets/images/roll_back.png'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: <Widget>[
          Stack(
            children: [
              IconButton(
                icon: Image.asset('assets/images/cart.png'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartScreen(),
                    ),
                  );
                },
              ),
              if (_cartCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 10,
                    child: Text(
                      '$_cartCount',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hiển thị hình ảnh sản phẩm (nếu có)
            Container(
              width: double.infinity, // Kích thước cố định của Container
              height: 250, // Kích thước cố định của Container
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0), // Độ bo góc
                color: Colors.grey[200],
              ),
              child: widget.product.imageUrl != null &&
                      widget.product.imageUrl!.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(15.0), // Độ bo góc
                      child: Image.network(
                        widget.product.imageUrl!,
                        fit: BoxFit.contain, // Điều chỉnh hình ảnh để vừa vặn với Container
                      ),
                    )
                  : Center(
                      child: Text(
                        'Không có hình ảnh',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
            ),

            SizedBox(height: 20),
            // Tên sản phẩm
            Text(
              widget.product.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            // Mô tả sản phẩm
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  widget.product.description,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 8),
            // Số lượng sản phẩm và giá sản phẩm
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  padding: EdgeInsets.all(1.5), // Khoảng cách bên trong khung
                  decoration: BoxDecoration(
                    color:
                        Color.fromARGB(255, 127, 238, 232), // Màu nền của khung
                    border: Border.all(
                        color: Color.fromARGB(
                            255, 127, 238, 232)), // Màu sắc của khung
                    borderRadius: BorderRadius.circular(12.0), // Độ bo góc
                  ),
                  child: IconButton(
                    icon: Icon(Icons.remove),
                    color: Colors.white, // Màu sắc của biểu tượng
                    iconSize: 20.0, // Kích thước của biểu tượng
                    onPressed: _decreaseQuantity,
                  ),
                ),
                SizedBox(width: 12), // Khoảng cách giữa hai nút
                Text(
                  '$_quantity',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 12), // Khoảng cách giữa nút và giá
                Container(
                  width: 40,
                  height: 40,
                  padding: EdgeInsets.all(0.0), // Khoảng cách bên trong khung
                  decoration: BoxDecoration(
                    color:
                        Color.fromARGB(255, 127, 238, 232), // Màu nền của khung
                    border: Border.all(
                        color: Color.fromARGB(
                            255, 185, 248, 245)), // Màu sắc của khung
                    borderRadius: BorderRadius.circular(12.0), // Độ bo góc
                  ),
                  child: IconButton(
                    icon: Icon(Icons.add),
                    color: Colors.white, // Màu sắc của biểu tượng
                    iconSize: 24.0, // Kích thước của biểu tượng
                    onPressed: _increaseQuantity,
                  ),
                ),
                Spacer(),
                Text(
                  '${NumberFormat('#,##0').format(widget.product.price)} đ',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            SizedBox(height: 40),
            // Nút mua sản phẩm
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _addToCart,
                    icon: Icon(Icons.add_shopping_cart, color: Colors.white),
                    label: Text(
                      'Thêm vào giỏ',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 154, 232, 224),
                      padding: EdgeInsets.symmetric(vertical: 12),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(width: 18),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _addToCart,
                    icon: Icon(Icons.shopping_bag, color: Colors.white),
                    label: Text(
                      'Mua hàng',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 199, 34, 34),
                      padding: EdgeInsets.symmetric(vertical: 12),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
