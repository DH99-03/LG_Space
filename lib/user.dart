import 'package:flutter/material.dart';
import 'package:spot/camera.dart';
import 'userappliance.dart';
import 'finished.dart';

void main() {
  runApp(const User());
}

class User extends StatelessWidget {
  const User({super.key});

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
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.fromLTRB(30, 80, 30, 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  text: '안녕하세요!🖐️ ',
                  style: TextStyle(fontSize: 30, height: 1.8),
                  children: <InlineSpan>[
                    TextSpan(
                      text: '권동현',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    TextSpan(text: '님\n '),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.0),
                        child: Image.asset(
                          'assets/images/dot.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    TextSpan(text: '   오늘은 어떤 '),
                    TextSpan(
                      text: '점',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFFF5353),
                      ),
                    ),
                    TextSpan(text: '이\n'),
                    TextSpan(text: '궁금', style: TextStyle(fontWeight: FontWeight.w500)),
                    TextSpan(text: '하신가요?'),
                  ],
                ),
              ),
              SizedBox(height: 80),
              SizedBox(
                width: double.infinity,
                child: Stack(
                  children: [
                    Positioned(
                      child: Image.asset('assets/images/new.png'),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 20,
                      child: Container(
                        width: 320,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) => Camera(returnTo: 'user'), // returnTo 파라미터 추가
                                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                  // Slide from right to left transition
                                  const begin = Offset(1.0, 0.0);
                                  const end = Offset.zero;

                                  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: Curves.easeInOut));
                                  var offsetAnimation = animation.drive(tween);

                                  return SlideTransition(
                                    position: offsetAnimation,
                                    child: child,
                                  );
                                },
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                          ),
                          child: SizedBox(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 17),
              SizedBox(
                width: double.infinity,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      child: Image.asset('assets/images/existing.png'),
                    ),
                    Positioned(
                      child: Container(
                        width: 350,
                        height: 88,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) => UserAppliance(),
                                // 애니메이션을 제거하고 화면만 전환
                                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                  return child;  // 단순히 화면만 전환 (애니메이션 없음)
                                },
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: SizedBox(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
