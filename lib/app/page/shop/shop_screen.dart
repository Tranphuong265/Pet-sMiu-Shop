import 'dart:async';
import 'dart:math'; // Thêm import này để tạo số ngẫu nhiên
import 'package:app_api/app/data/api.dart';
import 'package:app_api/app/data/sqlite.dart';
import 'package:app_api/app/model/cart.dart';
import 'package:app_api/app/model/product.dart';
import 'package:app_api/app/page/cart/cart_screen.dart';
import 'package:app_api/app/page/product/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:app_api/app/page/shop/search_reslut_page.dart';
import 'package:intl/intl.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final DatabaseHelper _databaseService = DatabaseHelper();
  late List<ProductModel> _filteredProducts = [];
  final PageController _pageController = PageController();
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 0;
  late Timer _timer;
  final TextEditingController _searchController = TextEditingController(); // Thêm controller

  List<String> _categories = []; // Danh sách các danh mục

  Future<void> _getProducts(String accountID, String token) async {
    try {
      List<ProductModel> allProducts = await APIRepository().getProduct(
        accountID,
        token,
      );

      setState(() {
        _filteredProducts = allProducts;
        _extractCategories(); // Lấy danh mục từ sản phẩm
      });
    } catch (ex) {
      print(ex);
    }
  }

  void _extractCategories() {
    // Tạo danh sách các danh mục từ các sản phẩm
    final Set<String> categoriesSet = {}; // Sử dụng Set để loại bỏ trùng lặp

    for (var product in _filteredProducts) {
      if (product.categoryName != null && product.categoryName!.isNotEmpty) {
        categoriesSet.add(product.categoryName!);
      }
    }

    setState(() {
      _categories = categoriesSet.toList(); // Chuyển đổi Set thành List
    });

    // In ra danh sách các danh mục
    print('Danh mục sản phẩm: $_categories');
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

    // Hiển thị thông báo khi sản phẩm được thêm vào giỏ hàng
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${pro.name} đã được thêm vào giỏ hàng!'),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.green,
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


  void _search() {
    final query = _searchController.text.trim(); // Xóa khoảng trắng đầu và cuối
    if (query.isEmpty) {
      // Nếu không có ký tự hoặc chỉ có khoảng trắng
      return; // Không thực hiện tìm kiếm
    }

    // Xóa nội dung trong TextField
    _searchController.clear();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchResultsPage(query: query, allProducts: _filteredProducts),
      ),
    );
  }

  Map<String, List<ProductModel>> _groupProductsByCategory() {
    final Map<String, List<ProductModel>> categorizedProducts = {};

    for (var product in _filteredProducts) {
      final category = product.categoryName ?? 'Uncategorized';
      if (!categorizedProducts.containsKey(category)) {
        categorizedProducts[category] = [];
      }
      categorizedProducts[category]!.add(product);
    }

    return categorizedProducts;
  }

  void _scrollToCategory(String category) {
    final categorizedProducts = _groupProductsByCategory();
    final index = categorizedProducts.keys.toList().indexOf(category);
    if (index != -1) {
      _scrollController.animateTo(
        index * 360.0, // Adjust the offset as needed
        duration: const Duration(milliseconds: 750),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void initState() {
    super.initState();

    String accountID = "21dh111491";
    String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiMDg4OTIyNDA2NCIsIklEIjoiMjFESDExMTUwNyIsImp0aSI6IjYzZTJhY2YwLWJlZGQtNDU1OC1iNDY3LWU5ZjA3MDU4NmMyMSIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcm9sZSI6IlN0dWRlbnQiLCJleHAiOjE3Mjg4MjI5ODF9.kR2whi_5zqGw66vBuvnwIN7xR8DD0vPp6zWD9BGoEKc";

    _getProducts(accountID, token);

    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    _searchController.dispose(); // Dispose controller khi không sử dụng
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categorizedProducts = _groupProductsByCategory();

    return Scaffold(
      appBar: AppBar(
        title: Text('Pet\'s Miu'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Image.asset('assets/images/cart.png'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30.0),
                        border: Border.all(
                          color: Color.fromARGB(255, 195, 241, 231),
                          width: 1.5,
                        ),
                      ),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search food, accessories, etc.....',
                          hintStyle: TextStyle(color: Color.fromARGB(255, 69, 73, 72)),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Color.fromARGB(255, 198, 246, 235),
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                        ),
                        onSubmitted: (value) => _search(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _categories.map((category) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: _buildCategoryButton(category,() {
                      _scrollToCategory(category);
                    }),
                  );
                }).toList(),
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CustomScrollView(
                controller: _scrollController,
                slivers: categorizedProducts.entries.map((entry) {
                  final categoryName = entry.key;
                  final products = entry.value;
                  return _buildSection(categoryName, products);
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryButton(String category, VoidCallback onPressed) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: Color.fromARGB(255, 175, 243, 243),
      foregroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10), // Điều chỉnh padding
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.white,
                blurRadius: 4,              
                ),
            ],
          ),
          child: Center(
            child: Image.asset(
              'assets/images/iconbottom.jpg', // Đường dẫn đến biểu tượng lưu trong assets
              width: 24,
              height: 24,
              //color: Colors.black,
            ),
          ),
        ),
        const SizedBox(width: 8), // Khoảng cách giữa biểu tượng và văn bản
        Text(
          category,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    ),
  );
}

  Widget _buildSection(String title, List<ProductModel> products) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 327.5, // Chiều cao cho danh sách ngang
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0), // Khoảng cách giữa các Card
                  child: _buildProduct(products[index], context),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProduct(ProductModel pro, BuildContext context) {
    final discountPercent = 50; // Tạo số ngẫu nhiên từ 0 đến 50
    final discountedPrice = pro.price + (pro.price * discountPercent / 100);

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
        color: const Color(0xFFE8F0F2),
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0), // Padding cụ thể cho từng hướng
                child: Container(
                  height: 140,
                  width: 140,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 212, 211, 211),
                    borderRadius: BorderRadius.circular(15),
                    image: pro.imageUrl != null && pro.imageUrl!.isNotEmpty && pro.imageUrl != 'Null'
                        ? DecorationImage(
                            image: NetworkImage(pro.imageUrl),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if (pro.imageUrl == null || pro.imageUrl!.isEmpty || pro.imageUrl == 'Null')
                        Padding(
                          padding: const EdgeInsets.all(8.0), // Padding cho 'No image' Text
                          child: const Text(
                            'No image',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Container(
                width: 200, // Chiều rộng của card
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 50,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${NumberFormat('#,##0').format(pro.price)}',
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                          Text(
                            '${NumberFormat('#,##0').format(discountedPrice)}',
                            style: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              '-$discountPercent%',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 17.5),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          width: 100,
                          height: 35,
                          child: TextButton(
                            onPressed: () async {
                              _onSave(pro);
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.red,
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