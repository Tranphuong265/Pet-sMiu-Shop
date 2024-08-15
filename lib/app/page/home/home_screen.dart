import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app_api/app/data/api.dart';
import 'package:app_api/app/data/sqlite.dart';
import 'package:app_api/app/model/cart.dart';
import 'package:app_api/app/model/product.dart';
import 'package:app_api/app/page/cart/cart_screen.dart';
import 'package:app_api/app/page/product/product_detail.dart';

class HomeBuilder extends StatefulWidget {
  const HomeBuilder({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeBuilder> createState() => _HomeBuilderState();
}

class _HomeBuilderState extends State<HomeBuilder> {
  final DatabaseHelper _databaseService = DatabaseHelper();
  late List<ProductModel> _filteredProducts = [];
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late Timer _timer;
  int _cartCount = 0;

  Future<void> _getProducts(String accountID, String token) async {
    try {
      List<ProductModel> allProducts = await APIRepository().getProduct(
        accountID,
        token,
      );

      setState(() {
        _filteredProducts = allProducts; // Không cần lọc nữa
      });
    } catch (ex) {
      print(ex);
    }
  }

  Future<void> _onSave(ProductModel pro) async {
  try {
    await _databaseService.insertProduct(Cart(
      productID: pro.id,
      name: pro.name,
      des: pro.description,
      price: pro.price,
      img: pro.imageUrl,
      count: 1,
    ));
    setState(() {});
    await _updateCartInfo();

    // Hiển thị thông báo khi sản phẩm được thêm vào giỏ hàng
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${pro.name} đã được thêm vào giỏ hàng!'),
        duration: const Duration(seconds: 2),
        backgroundColor: Color.fromARGB(255, 109, 234, 161),
      ),
    );
  } catch (e) {
    // Xử lý lỗi nếu có
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Đã xảy ra lỗi khi thêm sản phẩm vào giỏ hàng.'),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }
}

  Future<void> _updateCartInfo() async {
    final count = await _databaseService.getTotalCount();

    setState(() {
      _cartCount = count;
    });
  }

  @override
  void initState() {
    super.initState();
    _updateCartInfo();

    // Cụ thể hóa giá trị accountID và token
    String accountID = "21dh111491";
    String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiMDg4OTIyNDA2NCIsIklEIjoiMjFESDExMTUwNyIsImp0aSI6IjYzZTJhY2YwLWJlZGQtNDU1OC1iNDY3LWU5ZjA3MDU4NmMyMSIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcm9sZSI6IlN0dWRlbnQiLCJleHAiOjE3Mjg4MjI5ODF9.kR2whi_5zqGw66vBuvnwIN7xR8DD0vPp6zWD9BGoEKc";

    _getProducts(accountID, token);

    // Khởi tạo Timer để tự động chuyển đổi hình ảnh
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pet\'s Miu'),
        centerTitle: true,
        automaticallyImplyLeading: false, // Loại bỏ nút back mặc định
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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              background: PageView(
                controller: _pageController,
                children: [
                  Padding(
                    padding: EdgeInsets.all(12.0), // Điều chỉnh lề theo mong muốn
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0), // Điều chỉnh độ bo góc
                      child: Image.asset('assets/images/banner.png', fit: BoxFit.cover),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Image.asset('assets/images/DogFood1.jpeg', fit: BoxFit.cover),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Image.asset('assets/images/banner.png', fit: BoxFit.cover),
                    ),
                  ),
                ],
              ),
            ),
            pinned: false,
            automaticallyImplyLeading: false, // Đảm bảo không có nút back
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Best Seller',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          _filteredProducts.isEmpty
              ? SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Text(
                        "No products available",
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ),
                )
              : SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 items per row
                    crossAxisSpacing: 25.0,
                    mainAxisSpacing: 50.0,
                    childAspectRatio: 0.595, // adjust to fit your design
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: _buildProduct(_filteredProducts[index], context),
                      );
                    },
                    childCount: _filteredProducts.length,
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildProduct(ProductModel pro, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(product: pro),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: const Color(0xFFE8F0F2), // Màu nền tương tự như hình
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  height: 125,
                  width: 130,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 225, 218, 218),
                    borderRadius: BorderRadius.circular(15),
                    image: pro.imageUrl != null && pro.imageUrl!.isNotEmpty && pro.imageUrl != 'Null'
                        ? DecorationImage(
                            image: NetworkImage(pro.imageUrl),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  alignment: Alignment.center,
                  child: pro.imageUrl == null || pro.imageUrl!.isEmpty || pro.imageUrl == 'Null'
                      ? const Text(
                          'No image',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 8.0),
              Container(
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(15), // Bo góc dưới bên trái
                    bottomRight: Radius.circular(15), // Bo góc dưới bên phải
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 50, // Chiều cao cố định để đủ cho 2 dòng
                        child: Text(
                          pro.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        'Giá: ${NumberFormat('#,##0').format(pro.price)} VND',
                        style: const TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          width: 100,
                          height: 35,
                          child: TextButton(
                            onPressed: () async {
                              await _onSave(pro);
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.red, // Màu nền nút "Mua ngay"
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13),
                              ),
                            ),
                            child: const Text(
                              'Mua ngay',
                              style: TextStyle(fontSize: 14, color: Colors.white),
                            ),
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
