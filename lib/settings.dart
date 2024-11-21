import 'package:flutter/material.dart';
import 'user.dart';
import 'camera.dart';

void main() {
  runApp(const Settings());
}

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 80, 30, 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text('여긴 환경설정.... 에는 뭘 넣어야 함... 띠발..'),
            ),

          ],
        ),
      ),
    );

  }
}
