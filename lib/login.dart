import 'package:flutter/material.dart';
import 'user.dart';
import 'detection.dart';

void main() {
  runApp(const Login());
}

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      body: Container(
        padding: EdgeInsets.fromLTRB(
          size.width * 0.08, // 왼쪽과 오른쪽 여백
          size.height * 0.08,
          size.width * 0.08,
          size.height * 0.08,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
          children: [
            // 로고와 텍스트를 함께 배치
            Row(
              crossAxisAlignment: CrossAxisAlignment.start, // 로고와 텍스트의 시작점 맞추기
              children: [
                Image.asset(
                  'assets/images/O!.png',
                  width: size.width * 0.2, // 로고 크기
                  fit: BoxFit.contain,
                ),
              ],
            ),
            SizedBox(height: size.height * 0.03), // 로고와 텍스트 사이 여백
            // 텍스트 컨테이너
            Text(
              '만나서 반가워요.\n스팟입니다.',
              style: TextStyle(
                fontSize: size.width * 0.07, // 화면 너비의 7%를 폰트 크기로 설정
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: size.height * 0.02), // 텍스트와 설명 텍스트 사이 여백
            Text(
              '회원 서비스 이용을 위해 LG ThinQ를 연동해주세요.',
              style: TextStyle(
                fontSize: size.width * 0.04, // 화면 너비의 4%를 폰트 크기로 설정
                color: Color(0xFF585858),
              ),
            ),
            Spacer(), // 남은 공간을 채우기 위해 Spacer 추가
            // 'ThinQ 연동하기' 버튼
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => User()),
                );
              },
              child: Text(
                'LG ThinQ 연동하기',
                style: TextStyle(
                  fontSize: size.width * 0.05, // 화면 너비의 5%를 폰트 크기로 설정
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, size.height * 0.07), // 반응형 버튼 높이
                backgroundColor: Color(0xFFEF4D4D),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(size.width * 0.1), // 반응형 모서리 둥글기
                ),
                elevation: 0,
              ),
            ),
            SizedBox(height: size.height * 0.03), // 버튼 사이 반응형 간격
            // '연동없이 이용하기' 버튼
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        ImagePredictionPage(autoCapture: true), // autoCapture 전달
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      const begin = Offset(1.0, 0.0);
                      const end = Offset.zero;
                      const curve = Curves.easeInOut;

                      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                      var offsetAnimation = animation.drive(tween);

                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                  ),
                );
              },
              child: Text(
                '연동없이 이용하기',
                style: TextStyle(
                  fontSize: size.width * 0.05,
                  color: Color(0xFFEF4D4D),
                ),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, size.height * 0.07),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(size.width * 0.1),
                  side: BorderSide(
                    color: Color(0xFFEF4D4D),
                    width: size.width * 0.005,
                  ),
                ),
                elevation: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
