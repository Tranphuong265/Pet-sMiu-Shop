import 'package:flutter/material.dart';
import 'newsItem.dart';
import 'newsDetail.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tin tức',
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.normal,
          fontSize: 32,
          color: Color.fromRGBO(50, 75, 73, 1)
        ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Newsdetail(
                    imagePath: 'assets/images/New/news_meo.png',
                    description: 'Một cặp đôi tại bang Utah (Mỹ) đã vô tình để sót con mèo cưng của họ trong kiện hàng trả lại, khiến mèo bị mắc kẹt trong 6 ngày không được ăn uống, cho đến khi được phát hiện tại bang California.',
                    details: 'Con mèo chui vào thùng carton chứa các món hàng gửi trả Amazon trong khi chủ nhân không để ý, khiến nó vô tình bị chuyển từ Utah đến California, cách 1.000 km.Hồi giữa tháng 4, một nhân viên nhà kho của Amazon ở California tìm thấy một con mèo tam thể trong một chiếc thùng carton kích cỡ 91x91 cm, gửi trả từ Utah 6 ngày trước. Nhân viên này gọi cho đồng nghiệp yêu mèo là Brandy Hunter.Hôm đó không phải ngày làm việc, nhưng Hunter tức tốc đến kho, mang theo thức ăn cho mèo. Cô thường giải cứu mèo mỗi khi có thời gian rảnh.Con vật sợ hãi không ăn, nhưng cuối cùng cũng để Hunter cưng nựng. "Hành vi của con mèo khiến tôi biết nó là mèo nhà chứ không phải mèo hoang. Tôi đưa nó về nhà tối đó", cô kể lại.Cách đó hơn 1.000 km, gia đình Carrie Steven Clark tại thành phố Lehi, Utah, như ngồi trên đống lửa khi con mèo cưng tên Galena đã mất tích gần một tuần. Gia đình Clark rất yêu con mèo 6 tuổi này, thậm chí còn nhịn ăn một ngày theo tín ngưỡng Công giáo để cầu nguyện nó sớm về nhà.',
                  ),
                ),
              );
            },
            child: const NewsItem(
              imagePath: 'assets/images/New/meochudu.png',
              description: 'Mèo cưng \'chu du bất đắc dĩ\' 1.000 km vì chui vào thùng hàng', fulltext: '',
            ),
          ),
          const SizedBox(height: 16.0),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Newsdetail(
                    imagePath: 'assets/images/New/meobotu.png',
                    description: 'Một người đàn ông tên Muhammad Danial Sukirman (31 tuổi) mới đây bị tòa án ở Singapore kết án 20 ngày tù vì bỏ mặc 43 con mèo trong một căn hộ trống.',
                    details: 'SINGAPORE-Người đàn ông bị tuyên án tù 20 ngày vì bỏ mặc 43 con mèo trong căn hộ trống, khiến chúng không được ăn uống thường xuyên suốt nhiều tháng.Muhammad Danial Sukirman, 31 tuổi, hôm 24/4 nhận tội với 10 cáo buộc về gây đau đớn không cần thiết đối với vật nuôi. Theo tài liệu của tòa án, Danial đã bỏ mặc 43 con mèo trong căn hộ bỏ hoang ở khu Ang Mo Kio, không cung cấp đầy đủ thức ăn nước uống cho chúng từ tháng 8/2021 đến tháng 11/2021.Khi được phát hiện, hai con mèo đã chết. Công tố viên cho biết đây là vụ án liên quan số lượng vật nuôi bị bỏ rơi lớn nhất từ trước đến nay.Cơ quan công tố lập luận sẽ quá khoan dung nếu chỉ phạt tiền và đề nghị tòa tuyên án tù đối với Danial, do hành vi cố ý của anh ta. Danial biết rõ những con mèo đang sinh sản không kiểm soát, nhưng không làm gì để cải thiện điều kiện sống cho chúng.Thẩm phán đồng ý với bên công tố rằng rủi ro sức khỏe từ những con mèo bị bỏ mặc trong căn hộ có thể đã lây sang những người sống gần đó và hành động của Danial đáng bị phạt tù.',
                  ),
                ),
              );
            },
            child: const NewsItem(
              imagePath: 'assets/images/New/meobotu.png',
              description: 'Ngồi tù vì bỏ mặc 43 con mèo người đàn ông nhận cái kết đắng', 
              fulltext: '',
            ),
          ),
          const SizedBox(height: 16.0),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Newsdetail(
                    imagePath: 'assets/images/New/banmeo.png',
                    description: 'Đề xuất không được bán mèo con trước 8 tuần tuổi: Bác sĩ thú y nói gì?',
                    details: 'Tránh gây phiền toái cho người khác khi nuôi mèo.Ngoài việc phải đăng ký nuôi với UBND cấp xã, khuyến khích các hộ nuôi gắn microchip, kê khai định kỳ 2 lần/năm, kê khai trong vòng 3 ngày sau khi nuôi… Quy định tạm thời về quản lý nuôi chó, mèo trên địa bàn TP.HCM do Sở NN-PTNT gửi UBND TP.HCM xin ý kiến xây dựng quy định, dự kiến trình trong quý 4/2024 còn có những đề xuất riêng cho các hộ nuôi mèo như: mèo được nuôi giữ trong nhà, đảm bảo an toàn cho mèo ngăn ngừa việc gây phiền toái đến người khác.Mèo nuôi phải kiểm soát việc sinh sản không theo ý muốn. Đối với mèo con thì không tách rời mẹ trước 7 ngày tuổi và không được bán cho trước 8 tuần tuổi. Người nuôi không được cho ăn chay hoàn toàn, không nên cho mèo ăn thịt tươi. Mèo 6 tuần đến 6 tháng phải ăn tối thiểu 2 lần/ngày, không nên cho mèo ăn thức ăn của chó và thiếu dinh dưỡng, không khử trùng có chứa Phenol xung quanh mèo."Mình thừa nhận bản thân nuôi mèo là thú cưng, xem như bạn bè nên việc chăm sóc kỹ càng, gần như giống với những đề xuất mới nhất về quy định nuôi mèo. Ở quê mẹ mình nuôi giống mèo ta không được chăm sóc kỹ càng như vậy. Việc ăn uống cũng đơn giản chỉ có ít cơm và cá, thịt… và được nuôi thả thoải mái trong nhà, sân vườn…", chị cho biết.',
                  ),
                ),
              );
            },
            child: const NewsItem(
              imagePath: 'assets/images/New/banmeo.png',
              description: 'Đề xuất không được bán mèo con trước 8 tuần tuổi: Bác sĩ thú y nói gì?', fulltext: '',
            ),
          ),
          const SizedBox(height: 16.0),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Newsdetail(
                    imagePath: 'assets/images/New/hanhhameo.png',
                    description: 'Một sinh viên năng khiếu đậu thủ khoa, nhưng vẫn bị một trường đại học danh giá tại Trung Quốc từ chối tiếp nhận do từng đối xử thô bạo với mèo.',
                    details: 'Thí sinh họ Hứa gần đây đã đạt điểm cao nhất trong kỳ thi tuyển sinh để theo thành chuyên ngành vật lý hạt nhân tại Trường Vật lý thuộc Đại học Nam Kinh (tỉnh Giang Tô, Trung Quốc).Tuy nhiên, kết quả thi tuyển do nhà trường đưa ra hồi cuối tháng 3 cho thấy thí sinh này không qua được bài kiểm tra thứ 2, theo tờ Xiaoxiang Morning Herald mới đây đưa tin.Trường Vật lý không giải thích lý do thí sinh Hứa thi rớt, nhưng một quan chức cho hay họ đã nhận được nhiều lời khiếu nại về việc thí sinh này bạo hành mèo.Theo hướng dẫn tuyển sinh của trường, "trình độ đạo đức và chính trị" của người nộp đơn sẽ được xem xét và có thể không chấp nhận những người không đáp ứng được tiêu chí đó.\"Nhà trường rất chú ý đến các vụ ngược đãi mèo. Hành vi của anh ta có thể đã ảnh hưởng đến kết quả tuyển sinh", theo quan chức trên.Vào thời điểm đầu tháng 3, Hứa là một sinh viên năm 4 tại Đại học Đông Nam ở Nam Kinh và gây chú ý trên mạng xã hội vì đăng nhiều đoạn phim quay lại cảnh mình hành hạ và giết những con mèo tại nơi ở.Trong một đoạn phim, sinh viên này ném con mèo vào xô và nhiều lần giẫm lên đầu con vật. Sau khi hành vi thô bạo lan truyền trên mạng, cảnh sát Nam Kinh bắt đầu điều tra và nhắc nhở Hứa cùng cha mẹ, nhưng không xử phạt."\Hứa đã thừa nhận sai lầm của mình. Anh ta viết thư xin lỗi, hứa sẽ không tái phạm",theo thông cáo của cảnh sáchTheo tờ South China Morning Post, sau khi bị Đại học Nam Kinh từ chối, sinh viên này nộp đơn vào một trường hàng đầu khác là Đại học Lan Châu ở tây bắc Trung Quốc và được phỏng vấn trực tiếp.Tuy nhiên, sinh viên này từ chối trả lời câu hỏi của trang tin Red Star News. "Nếu nói nhiều, tôi sẽ có thể gây ra làn sóng giận dữ khác trên mạng. Thật không phù hợp nếu tôi trả lời những vấn đề đó vào lúc này", theo anh Hứa.Câu chuyện của sinh viên Hứa gây làn sóng lên án trên mạng xã hội. Một cư dân mạng nói rằng mọi mạng sống đều bình đẳng nên "nếu một người lạm dụng mèo có thể bị tha thứ, một kẻ giết người cũng có thể được tha".Tuy nhiên, một người khác lại cho rằng "không dễ đào tạo một nhà nghiên cứu khoa học. Một con mèo không quan trọng bằng nhân tài".',
                  ),
                ),
              );
            },
            child: const NewsItem(
              imagePath: 'assets/images/New/hanhhameo.png',
              description: 'Vì hành hạ mèo, dù đậu thủ khoa vẫn bị trường đại học từ chối', fulltext: '',
            ),
          ),
          const SizedBox(height: 16.0),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Newsdetail(
                    imagePath: 'assets/images/New/coffemeo.png',
                    description: 'CATFE Coffee',
                    details: 'CATFE Coffee là một trong những quán cà phê mèo nổi tiếng nhất ở TP.HCM. Quán này có nhiều loài mèo khác nhau, từ những chú mèo lông ngắn đến những chú mèo lông dài quý phái. Du khách có thể thư giãn trong không gian ấm cúng và chơi đùa với những chú mèo thân thiện. CATFE Coffee cũng cung cấp nhiều loại đồ uống và đồ ăn nhẹ, làm cho trải nghiệm của bạn trở nên đa dạng và thú vị hơn.',
                  ),
                ),
              );
            },
            child: const NewsItem(
              imagePath: 'assets/images/New/coffemeo.png',
              description: 'Điểm danh những quán cà phê thú cưng siêu dễ thương ở TP.HCM', fulltext: '',
            ),
          ),
        ],
      ),
    );
  }
}
