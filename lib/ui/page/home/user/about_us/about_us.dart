import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  static const route = '/AboutUs';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Về chúng tôi'),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                  'Agiay là thương hiệu thời trang chuyên phân phối giày nam, nữ cao cấp đã được khẳng định trong 5 năm vừa qua.\n\nAgiay hướng tới mục tiêu trở thành thương hiệu đồ da hàng đầu Việt Nam, chúng tôi luôn nỗ lực không ngừng để đưa thương hiệu trở nên gần gũi hơn và là thương hiệu cung cấp những sản phẩm giày da, giày thể thao, giày công sở, giày lười mang chất lượng tốt nhất, thỏa mãn nhu cầu mua sắm của quý khách hàng.\n\nVới thiết kế độc đáo, lịch lãm và không kém phần hiện đại, các sản phẩm của Agiay phù hợp với nhiều đối tượng, tôn lên vẻ đẹp cho các quý khách hàng hiện đại. Các sản phẩm đều được kiểm tra kỹ lưỡng trước khi mang bán ra thị trường, mang đến những sản phẩm với chất lượng tốt nhất tới quý khách hàng.\n\nNgoài ra, với hệ thống và đội ngũ nhân viên bán hàng chuyên nghiệp, Agiay mang đến quý khách hàng những dịch vụ tốt nhất cùng chính sách bảo hành, bảo trì trọn đời cho các sản phẩm như lời cam kết về uy tín và chất lượng của chúng tôi đến với khách hàng.'),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Icon(
                    Icons.map_outlined,
                    color: Colors.red,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Text(
                        'Địa chỉ: Thôn Phú Xuyên 4, xã Phú Châu, Huyện Ba Vì, Hà Nội'),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.call,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Text('Tư vấn mua hàng: 098.122.2070'),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.messenger,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Text('Liên hệ ZALO: 098.122.2070'),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.support_agent,
                    // color: Colors.blue,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Text(
                        'Hỗ trợ giờ hành chính: 9h - 17h (Thứ 2 tới Thứ 7)'),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.mail,
                    // color: Colors.blue,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Text('Email: agiay.vn@gmail.com'),
                  ),
                ],
              ),
              // SizedBox(
              //   height: 8,
              // ),
              // Text('Hỗ trợ giờ hành chính: 9h - 17h (Thứ 2 tới Thứ 7)'),
              // SizedBox(
              //   height: 8,
              // ),
              // Text('Email: agiay.vn@gmail.com'),
            ],
          ),
        ),
      ),
    );
  }
}
