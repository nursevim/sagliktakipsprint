import 'package:saglik_takip/auth.dart';
import 'package:saglik_takip/views/health_tracking_screen.dart';
import 'package:saglik_takip/views/login_register_page.dart';
import 'package:flutter/material.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Auth().authStateChanges,
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return SaglikTakipEkrani();
          } else {
            return const LoginPage();
          }
        }
    );
  }
}
