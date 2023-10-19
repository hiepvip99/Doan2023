import 'package:flutter/material.dart';
import 'package:web_app/ui/component_common/circle_button.dart';
import 'package:web_app/ui/page/home/admin/components/product_manager/product_manager_view.dart';

import '../../constant.dart';

class EditAvatarScreen extends StatelessWidget {
  const EditAvatarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        // Hình ảnh avatar tròn
        ClipRRect(
          borderRadius: BorderRadius.circular(80),
          child:
              const ImageComponent(imageUrl: '${domain}api/image/banner.png'),
        ),
        // Biểu tượng chụp ảnh ở góc dưới bên phải
        Positioned(
          bottom: 8,
          right: 8,
          child: MyCircleButton(
            padding: const EdgeInsets.all(0),
            child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.circular(50)),
                child: const Icon(Icons.camera_alt)),
            onTap: () {
              // Xử lý sự kiện khi nhấp vào biểu tượng chụp ảnh
              // ...
            },
          ),
        ),
      ],
    );
  }
}
