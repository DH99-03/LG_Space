import 'package:flutter/material.dart';


import 'user.dart';
import 'code.dart';

void main() {
  runApp(const Finished());
}

class Finished extends StatelessWidget {
  const Finished({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          textTheme: TextTheme(
            bodyLarge: TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 20.0,
            ),
            bodyMedium: TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 16.0,
            ),
            bodySmall: TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 12.0,
            ),
          ),
        ),
        home: Scaffold(
          backgroundColor: const Color(0xFFFAFAFA),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(30, 60, 30, 80),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start, // 요소들을 세로로 위쪽에 정렬
              children: [
                SizedBox(height: 80),
                Container(
                  alignment: Alignment.center, // 수평 및 수직 중앙 정렬
                  child: Image.asset('assets/images/finished/star.png'),
                ),
                SizedBox(height: 25,),
                Container(
                  width: 230,
                  height: 230,
                  decoration: BoxDecoration(
                    color: Color(0xFFFF5353),
                    shape: BoxShape.circle
                  ),
                ),
                Container(
                  child: Text('권동현 님이 궁금한 가전은'),
                )
              ],
            ),
          ),
        )

    );
  }
}
