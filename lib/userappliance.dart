import 'package:flutter/material.dart';
import 'package:spot/chatbot.dart';
import 'package:spot/re.dart';
import 'package:spot/wash.dart';
import 'user.dart';
import 're.dart';
import 'code.dart';
import 'saved.dart';
import 'settings.dart';
import 'camera.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: const TextTheme(
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
        splashFactory: NoSplash.splashFactory, // Ripple 효과 제거
        highlightColor: Colors.transparent,   // 탭 강조 효과 제거
      ),
      home: const UserAppliance(),
    );
  }
}

class UserAppliance extends StatefulWidget {
  const UserAppliance({super.key});

  @override
  State<UserAppliance> createState() => _UserApplianceState();
}

class _UserApplianceState extends State<UserAppliance> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 60, 30, 80),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                        const User(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return child;
                        },
                      ),
                    );
                  },
                  child: const Icon(Icons.arrow_back_ios),
                ),
                const SizedBox(width: 80),
                const Text(
                  '권동현의 가전',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                    const Re(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: const AlwaysStoppedAnimation(1),
                        child: child,
                      );
                    },
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(top: 50),
                alignment: Alignment.center,
                child: Image.asset('assets/images/refr.png'),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                    const Wash(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: const AlwaysStoppedAnimation(1),
                        child: child,
                      );
                    },
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(top: 26),
                alignment: Alignment.center,
                child: Image.asset('assets/images/wash.png'),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                    const Code(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: const AlwaysStoppedAnimation(1),
                        child: child,
                      );
                    },
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(top: 26),
                alignment: Alignment.center,
                child: Image.asset('assets/images/zero.png'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 120, // 네비게이션 바의 전체 높이 증가
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 80, // 높이 설정
                decoration: const BoxDecoration(
                  color: Color(0xFFFF5353), // 배경색
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30), // 왼쪽 상단 모서리 둥글게
                    topRight: Radius.circular(30), // 오른쪽 상단 모서리 둥글게
                  ),
                ),
                child: BottomNavigationBar(
                  enableFeedback: false,
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: const Color(0xFFFFFFFF),
                  unselectedItemColor: const Color(0xFFFFFFFF),
                  currentIndex: selected,
                  onTap: (index) {
                    if (index == 0) {
                      // 홈 아이콘을 클릭하면 User.dart로 이동
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) =>
                          const User(),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: const AlwaysStoppedAnimation(1),
                              child: child,
                            );
                          },
                        ),
                      );
                    } else if (index == 1) {
                      // 저장목록 -> saved
                      Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) =>
                            const Saved(),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              return FadeTransition(
                                opacity: const AlwaysStoppedAnimation(1),
                                child: child,
                              );
                            },
                          )
                      );
                    } else if (index != 2) {
                      setState(() {
                        selected = index;
                      });
                    }
                  },
                  backgroundColor: Colors.transparent, // 투명 배경으로 설정
                  elevation: 0, // 그림자 제거
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home_outlined, size: 40),
                      activeIcon: Icon(Icons.home, size: 40),
                      label: '홈',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.star_outline_rounded, size: 40),
                      activeIcon: Icon(Icons.star_rounded, size: 40),
                      label: '저장 목록',
                    ),
                  ],
                ),
              ),
            ),

            Positioned(
              left: 0,
              right: 0,
              bottom: 40, // 버튼 위치 조정
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Camera(returnTo: 'user'),
                    ),
                  );
                },
                child: Center(
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFF5353),
                          shape: BoxShape.circle
                        ),
                        child: Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),

                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}