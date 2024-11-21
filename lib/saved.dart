import 'package:flutter/material.dart';
import 'user.dart';
import 'camera.dart';

void main() {
  runApp(const Saved());
}

class Saved extends StatelessWidget {
  const Saved({super.key});

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
              child: Text('자주 찾는 가전의 기능이나 꿀팁 등 저장 공간 입니댕ㅋㅋ'),
            ),

          ],
        ),
      ),
    );

  }
}
