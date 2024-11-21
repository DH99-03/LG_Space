import 'package:flutter/material.dart';
import 'user.dart';

class Camera extends StatelessWidget {
  final String returnTo; // 돌아갈 페이지를 지정하는 변수 추가
  const Camera({super.key, required this.returnTo}); // 생성자에서 returnTo 파라미터 필수로 받기

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.fromLTRB(30, 80, 30, 80),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      // returnTo 값에 따라 다른 페이지로 이동
                      if (returnTo == 'user') {
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => User(),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              const begin = Offset(-1.0, 0.0); // 왼쪽에서 오른쪽으로 슬라이드
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
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            // Container(
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       SizedBox(height: 50,),
            //       Text('궁금한 가전을 프레임에 맞춰주세요.',
            //         style: TextStyle(color: Colors.white, fontSize: 20),),
            //       SizedBox(height: 100,),
            //       Image.asset('assets/images/camera/frame.png'),
            //       SizedBox(height: 100,),
            //       Text('가전 인식이 안된다면?',
            //         style: TextStyle(fontSize: 18, color: Colors.white,
            //             backgroundColor: Color(0xFF737373)),)
            //     ],
            //   ),
            //
            // )
          ],
        ),
      ),
    );
  }
}