import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_api/app/data/api.dart';
import 'package:app_api/app/model/category.dart';
import 'package:app_api/app/model/product.dart';

class ProductAdd extends StatefulWidget {
  final bool isUpdate;
  final ProductModel? productModel;

  const ProductAdd({Key? key, this.isUpdate = false, this.productModel}) : super(key: key);

  @override
  State<ProductAdd> createState() => _ProductAddState();
}

class _ProductAddState extends State<ProductAdd> {
  String? selectedCate;
  List<CategoryModel> categorys = [];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _desController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _imgController = TextEditingController();
  final TextEditingController _catIdController = TextEditingController();
  String titleText = "";

  @override
  void initState() {
    super.initState();
    _getCategorys();

    if (widget.productModel != null && widget.isUpdate) {
      _nameController.text = widget.productModel!.name;
      _desController.text = widget.productModel!.description;
      _priceController.text = widget.productModel!.price.toString();
      _imgController.text = widget.productModel!.imageUrl;
      _catIdController.text = widget.productModel!.categoryId.toString();
    }

    titleText = widget.isUpdate ? "Update Product" : "Add New Product";
  }

  Future<void> _getCategorys() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<CategoryModel> temp = await APIRepository().getCategory(
      prefs.getString('accountID').toString(),
      prefs.getString('token').toString(),
    );

    setState(() {
      categorys = temp;
      if (categorys.isNotEmpty) {
        selectedCate = categorys.first.id.toString();
        _catIdController.text = selectedCate!;
      }
    });
  }

  Future<void> _onSave() async {
    final name = _nameController.text;
    final des = _desController.text;
    final price = double.parse(_priceController.text);
    final img = _imgController.text;
    final catId = int.parse(_catIdController.text);
    
    SharedPreferences pref = await SharedPreferences.getInstance();
    await APIRepository().addProduct(
      ProductModel(
        id: 0,
        name: name,
        imageUrl: img,
        categoryId: catId,
        categoryName: '',
        price: price,
        description: des,
      ),
      pref.getString('token').toString(),
    );

    setState(() {});
    Navigator.pop(context);
  }

  Future<void> _onUpdate() async {
    final name = _nameController.text;
    final des = _desController.text;
    final price = double.parse(_priceController.text);
    final img = _imgController.text;
    final catId = int.parse(_catIdController.text);
    
    SharedPreferences pref = await SharedPreferences.getInstance();
    await APIRepository().updateProduct(
      ProductModel(
        id: widget.productModel!.id,
        name: name,
        imageUrl: img,
        categoryId: catId,
        categoryName: '',
        price: price,
        description: des,
      ),
      pref.getString('accountID').toString(),
      pref.getString('token').toString(),
    );

    setState(() {});
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titleText),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Name:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter name',
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Price:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter price',
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Image URL:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _imgController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter imageURL',
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Description:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _desController,
              maxLines: 5,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter description',
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Category:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: selectedCate,
              items: categorys
                  .map((item) => DropdownMenuItem<String>(
                        value: item.id.toString(),
                        child: Text(item.name, style: const TextStyle(fontSize: 20)),
                      ))
                  .toList(),
              onChanged: (item) {
                setState(() {
                  selectedCate = item;
                  _catIdController.text = item!;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                widget.isUpdate ? _onUpdate() : _onSave();
              },
              child: Text(widget.isUpdate ? 'Update Product' : 'Add Product'),
            ),
          ],
        ),
      ),
    );
  }
}
