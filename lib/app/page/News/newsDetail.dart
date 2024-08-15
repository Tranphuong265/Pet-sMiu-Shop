import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Newsdetail extends StatelessWidget {
  final String imagePath;
  final String description;
  final String details;

  const Newsdetail({
    super.key,
    required this.imagePath,
    required this.description,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        /*leading: Align(alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            backgroundColor: const Color.fromRGBO(170, 213, 209, 10),
            shape: const CircleBorder(),
            child: const Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
        ),
        ),*/
        leading: IconButton(
          icon: Image.asset('assets/images/roll_back.png'), // Thay đổi icon ở đây
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Tin tức',
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.bold,
          fontSize: 32,
          color: Color.fromRGBO(50, 75, 73, 1)
        ),
      ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      imagePath,
                      width: double.infinity,
                      height: 350,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    details,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
