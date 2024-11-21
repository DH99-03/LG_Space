import 'package:flutter/material.dart';
import 'user.dart';
import 'camera.dart';

void main() {
  runApp(const Login());
}

class Login extends StatelessWidget {
  const Login({super.key});

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
              margin: EdgeInsets.only(bottom: 35),
              child: Image.asset('assets/images/logo_app.png'),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 16),
              child: Text(
                '만나서 반가워요.\n스팟입니다.',
                style: TextStyle(fontSize: 30),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 330),
              child: Text(
                '회원 서비스 이용을 위해 LG ThinQ를 연동해주세요.',
                style: TextStyle(fontSize: 16, color: Color(0xFF585858)),
              ),
            ),
            // 'ThinQ 연동하기' 버튼
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => User()),  // 애니메이션 없이 화면 전환
                );
              },
              child: Text(
                'LG ThinQ 연동하기',
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 55),
                backgroundColor: Color(0xFFFF5353),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                elevation: 0,
              ),
            ),
            SizedBox(height: 30,),
            // '연동없이 이용하기' 버튼
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) => Camera(returnTo: 'login'),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      const begin = Offset(1.0, 0.0); // 오른쪽에서 왼쪽으로 슬라이드
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
                style: TextStyle(fontSize: 22, color: Color(0xFFFF5353)),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 55),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                  side: BorderSide(
                    color: Color(0xFFFF5353),
                    width: 1,
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
