import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black54,
                ),
              ),
              const Expanded(
                  child: Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Text('full name', overflow: TextOverflow.ellipsis),
              )),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.mode_edit_outline_sharp))
            ],
          ),
          SizedBox(
            height: 16,
          ),
          const ItemProfile(showBottomDivider: true, title: 'Đơn mua'),
          const ItemProfile(showBottomDivider: true, title: 'Địa chỉ của tôi'),
          const ItemProfile(showBottomDivider: true, title: 'Đánh giá của tôi'),
          const ItemProfile(showBottomDivider: true, title: 'Mã giảm giá'),
          const ItemProfile(showBottomDivider: true, title: 'Về chúng tôi'),
          // TextButton(onPressed: () {}, child: const Text('chỉnh sửa'))
        ],
      ),
    );
  }
}

class ItemProfile extends StatelessWidget {
  const ItemProfile(
      {super.key, required this.showBottomDivider, required this.title});

  final bool showBottomDivider;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   border: Border(
      //       bottom: showBottomDivider
      //           ? BorderSide(width: 1, color: Colors.grey.shade200)
      //           : BorderSide.none),
      // ),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(title), const Icon(Icons.keyboard_arrow_right)],
            ),
            Divider(
              thickness: 1,
            )
          ],
        ),
      ),
    );
  }
}
