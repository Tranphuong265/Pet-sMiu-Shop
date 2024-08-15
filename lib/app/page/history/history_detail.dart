import 'package:flutter/material.dart';
import 'package:app_api/app/model/bill.dart'; // Đảm bảo import đúng model của bạn
import 'package:intl/intl.dart';

class HistoryDetail extends StatelessWidget {
  final List<BillDetailModel> bill;

  const HistoryDetail({Key? key, required this.bill}) : super(key: key);

  void _editFields() {
    // Thực hiện hành động khi người dùng nhấn vào các trường để chỉnh sửa
    print('Edit fields');
  }

  @override
  Widget build(BuildContext context) {
    // Tính tổng giá tiền của các sản phẩm
    double totalAmount = bill.fold(0, (sum, item) => sum + item.total);
    double discount = 50000; // Giảm giá cố định
    double shippingFee = 50000; // Phí vận chuyển cố định
    double finalTotal = totalAmount - discount + shippingFee;

    String address = 'Địa chỉ nhận hàng';
    String receiverName = 'Minh Quang';
    String phoneNumber = '0336998569';
    String street = '1111 Âu Cơ';
    String district = 'Phường 12, Quận Tân Bình, TP.HCM';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết hóa đơn'),
        centerTitle: true,
         leading: IconButton(
          icon: Image.asset('assets/images/roll_back.png'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        
      ),
      body: Column(
        children: [
          // Phần thông tin địa chỉ và người nhận
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: 325,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Color.fromRGBO(202, 250, 245, 1),
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
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
                          ),
                        ),
                        const Text(
                          ' | ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            phoneNumber,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
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
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Phần danh sách sản phẩm và tổng tiền
          Expanded(
            child: ListView.builder(
              itemCount: bill.length,
              itemBuilder: (context, index) {
                var data = bill[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        // Cột đầu tiên chứa hình ảnh
                        Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(
                                8.0), // Bo góc với bán kính 8.0
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                8.0), // Bo góc cho hình ảnh
                            child: data.imageUrl != null
                                ? Image.network(data.imageUrl,
                                    fit: BoxFit.cover)
                                : Icon(Icons.image, size: 50),
                          ),
                        ),
                        SizedBox(width: 20.0),
                        // Cột thứ hai chứa thông tin sản phẩm
                        Expanded(
                          flex: 8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.productName,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Text(
                                'Giá: ${NumberFormat.currency(locale: 'vi', symbol: 'đ').format(data.price)}',
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 8.0),
                        // Cột thứ ba chứa số lượng
                        Expanded(
                          flex: 2,
                          child: Align(
                            alignment: Alignment
                                .bottomCenter, // Đặt text ở đáy của cột
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 55.0), // Thêm padding nếu cần
                              child: Text(
                                'X ${data.count}',
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
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
                      'Tiền hàng: ',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Text(
                      '${NumberFormat.currency(locale: 'vi', symbol: 'đ').format(totalAmount)}',
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
                      '-${NumberFormat.currency(locale: 'vi', symbol: 'đ').format(discount)}',
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
                      '${NumberFormat.currency(locale: 'vi', symbol: 'đ').format(shippingFee)}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                Divider(), // Sử dụng Divider thay cho dòng gạch ngang
                SizedBox(height: 8.0),
                // Hiển thị tổng tiền
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tổng tiền',
                      style: TextStyle(
                        fontSize: 27.5,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '${NumberFormat.currency(locale: 'vi', symbol: 'đ').format(finalTotal)}',
                      style: TextStyle(
                        fontSize: 27.5,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
