import 'dart:math'; // Để tạo số ngẫu nhiên cho khuyến mãi
import 'package:flutter/material.dart';
import 'package:app_api/app/model/product.dart';
import 'package:app_api/app/page/product/product_detail.dart';
import 'package:intl/intl.dart';
import 'package:app_api/app/data/sqlite.dart';
import 'package:app_api/app/model/cart.dart';

class SearchResultsPage extends StatelessWidget {
  final String query;
  final List<ProductModel> allProducts;
  final DatabaseHelper _databaseService = DatabaseHelper(); // Thay đổi đây cho phù hợp

  SearchResultsPage({Key? key, required this.query, required this.allProducts}) : super(key: key);

  Future<void> _onSave(BuildContext context, ProductModel product) async {
    try {
      await _databaseService.insertProduct(Cart(
        productID: product.id,
        name: product.name,
        des: product.description,
        price: product.price,
        img: product.imageUrl,
        count: 1,
      ));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${product.name} đã được thêm vào giỏ hàng!'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Không thể thêm sản phẩm vào giỏ hàng.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredProducts = allProducts
        .where((product) => product.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results'),
        centerTitle: true,
      ),
      body: filteredProducts.isEmpty
          ? Center(child: Text('Không có kết quả nào cho $query'))
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Kết quả tìm kiếm: $query',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.575,
                    ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      final discountPercent = Random().nextInt(51); // Tạo số ngẫu nhiên từ 0 đến 50
                      final discountedPrice = product.price + (product.price * discountPercent / 100);

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailPage(product: product),
                            ),
                          );
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          color: const Color(0xFFE8F0F2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 15,),
                              Container(
                                height: 140,
                                width: 140,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 204, 202, 202),
                                  borderRadius: BorderRadius.circular(15),
                                  image: product.imageUrl != null && product.imageUrl!.isNotEmpty && product.imageUrl != 'Null'
                                      ? DecorationImage(
                                          image: NetworkImage(product.imageUrl),
                                          fit: BoxFit.cover,
                                        )
                                      : null,
                                ),
                                child: product.imageUrl == null || product.imageUrl!.isEmpty || product.imageUrl == 'Null'
                                    ? Center(child: Text('No image'))
                                    : null,
                              ),
                              const SizedBox(height: 20,),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: double.infinity, // Cố định chiều rộng để giữ kích thước tên
                                      child: Text(
                                        product.name,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const SizedBox(height: 20.0),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${NumberFormat('#,##0').format(product.price)}',
                                          style: const TextStyle(fontSize: 14.0, color: Colors.red),
                                        ),
                                        Text(
                                          '${NumberFormat('#,##0').format(discountedPrice)}',
                                          style: const TextStyle(
                                            fontSize: 14.0,
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
                                    const SizedBox(height: 20),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Container(
                                        width: 100,
                                        height: 35,
                                        child: TextButton(
                                          onPressed: () async {
                                            await _onSave(context, product);
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
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
