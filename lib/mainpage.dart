import 'dart:convert';
import 'package:app_api/app/model/user.dart';
import 'package:app_api/app/page/News/newsScreen.dart';
import 'package:app_api/app/page/cart/cart_screen.dart';
import 'package:app_api/app/page/category/category_list.dart';
import 'package:app_api/app/page/profile/detail.dart';
import 'package:app_api/app/page/history/history_screen.dart';
import 'package:app_api/app/page/home/home_screen.dart';
import 'package:app_api/app/page/product/product_list.dart';
import 'package:app_api/app/page/profile/account.dart';
import 'package:app_api/app/page/shop/shop_screen.dart';
//import 'package:app_api/app/route/page3.dart';
import 'package:flutter/material.dart';
import 'app/page/defaultwidget.dart';
import 'app/data/sharepre.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart'; 

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  User user = User.userEmpty();
  int _selectedIndex = 2 ;

  getDataUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String strUser = pref.getString('user')!;

    user = User.fromJson(jsonDecode(strUser));
    setState(() { });
  }

  @override
  void initState() {
    super.initState();
    getDataUser();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _widgetOptions(BuildContext context) => <Widget>[
        NewsScreen(),
        ShopPage(),
        HomeBuilder(),
        HistoryScreen(),
        AccountWidget(),
      ];
      static const List<TabItem> items = [
    TabItem(
      icon: Icons.favorite_border,
      title: 'Tin tức',
    ),
    TabItem(
      icon: Icons.shopping_cart_outlined,
      title: 'Shop',
    ),
    TabItem(
      icon: Icons.home_outlined,
      title: 'Trang chủ',
    ),
    TabItem(
      icon: Icons.people_alt_outlined,
      title: 'Đơn hàng',
    ),
    TabItem(
      icon: Icons.person_outline,
      title: 'Tôi',
    ),
  ];
      

  @override
  Widget build(BuildContext context) {
    return Scaffold(/*
      appBar: AppBar(
        title: const Text("HL Mobile"),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 243, 152, 33),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  user.imageURL!.length < 5
                      ? const SizedBox()
                      : CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(
                            user.imageURL!,
                          )),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(user.fullName!),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
                _selectedIndex = 0;
                setState(() {});
              },
            ),
            ListTile(
              leading: const Icon(Icons.contact_mail),
              title: const Text('History'),
              onTap: () {
                Navigator.pop(context);
                _selectedIndex = 1;
                setState(() {});
              },
            ),
            ListTile(
              leading: const Icon(Icons.contact_mail),
              title: const Text('Cart'),
              onTap: () {
                Navigator.pop(context);
                _selectedIndex = 2;
                setState(() {});
              },
            ),
            ListTile(
              leading: const Icon(Icons.pages),
              title: const Text('Category'),
              onTap: () {
                Navigator.pop(context);
                _selectedIndex = 0;
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const CategoryList()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.pages),
              title: const Text('Product'),
              onTap: () {
                Navigator.pop(context);
                _selectedIndex = 0;
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ProductList()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.pages),
              title: const Text('Page3'),
              onTap: () {
                Navigator.pop(context);
                _selectedIndex = 0;
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Page3()));
              },
            ),
            const Divider(
              color: Colors.black,
            ),
            user.accountId == ''
                ? const SizedBox()
                : ListTile(
                    leading: const Icon(Icons.exit_to_app),
                    title: const Text('Logout'),
                    onTap: () {
                      logOut(context);
                    },
                  ),
          ],
        ),
      ),*/
      body: Center(
        child: _widgetOptions(context).elementAt(_selectedIndex),
      ),
     bottomNavigationBar: BottomBarInspiredOutside(
        items: items,
        backgroundColor: Color.fromARGB(255, 213, 232, 239),
        color: Colors.black,
        colorSelected: Color.fromARGB(255, 96, 43, 43),
        indexSelected: _selectedIndex,
        onTap: (int index) => setState(() {
          _selectedIndex = index;
        }),
        top: -28,
        animated: true,
        itemStyle: ItemStyle.circle,
        chipStyle: const ChipStyle(notchSmoothness: NotchSmoothness.softEdge),
      ),
      //body: _loadWidget(_selectedIndex),
    );
  }
}
