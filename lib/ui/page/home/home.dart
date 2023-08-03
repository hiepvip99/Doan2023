import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:web_app/ui/page/home/admin/home_admin_view.dart';

import '../login/login.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  // final Box _boxLogin = Hive.box("login");

  @override
  Widget build(BuildContext context) {
    return HomeAdmin();
    // return Scaffold();
  }
}
