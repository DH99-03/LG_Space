import 'package:flutter/material.dart';
import 'userappliance.dart';
import 'chatbot.dart'; // chatbot.dart 임포트
import 'saved.dart';
import 'settings.dart';
import 'user.dart';
import 'package:flutter/gestures.dart';

void main() {
  runApp(const Wash());
}

class Wash extends StatefulWidget {
  const Wash({super.key});

  @override
  State<Wash> createState() => _WashState();
}

class _WashState extends State<Wash> {
  int selected = 0; // 현재 선택된 인덱스

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
        backgroundColor: const Color(0xFFFFFFFF),
        body: Stack(
          children: [
            Column(
              children: [
                // 헤더
                Container(
                  padding: const EdgeInsets.fromLTRB(30, 60, 30, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // 뒤로가기 버튼 클릭 시 UserAppliance로 이동
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) =>
                              const UserAppliance(),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                return FadeTransition(
                                  opacity: const AlwaysStoppedAnimation(1),
                                  child: child,
                                );
                              },
                            ),
                          );
                        },
                        child: const Icon(Icons.arrow_back_ios),
                      ),
                      const SizedBox(width: 80), // 아이콘과 제목 사이의 간격
                      const Text(
                        'LG 트롬 오브제컬렉...',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),

                // 스크롤 가능한 영역
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 100), // 바텀 여백 추가
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 이미지
                        Container(
                          margin: const EdgeInsets.only(top: 40),
                          child: Image.asset('assets/images/re/re-detail.png'),
                        ),
                        const SizedBox(height: 30),
                        // 자주 묻는 FAQ
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                // 빨간 원 3개
                                CircleAvatar(
                                  radius: 3,
                                  backgroundColor: const Color(0xFFFF5353),
                                ),
                                const SizedBox(width: 5),
                                CircleAvatar(
                                  radius: 3,
                                  backgroundColor: const Color(0xFFFF5353),
                                ),
                                const SizedBox(width: 5),
                                CircleAvatar(
                                  radius: 3,
                                  backgroundColor: const Color(0xFFFF5353),
                                ),
                                const SizedBox(width: 9),
                                // '스팟에게 가장' 텍스트
                                const Text(
                                  '스팟에게 가장',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 30,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            // '자주 묻는 점이에요' 텍스트
                            const Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: '자주 묻는',
                                    style: TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  TextSpan(
                                    text: ' 점',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFFFF5353),
                                    ),
                                  ),
                                  TextSpan(
                                    text: '이에요',
                                    style: TextStyle(fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              style: TextStyle(fontSize: 30),
                            ),
                          ],
                        ),
                        const SizedBox(height: 27),
                        // '기능이 궁금해요' 버튼들
                        ...List.generate(
                          6,
                              (index) => Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(20, 25, 0, 25),
                              width: 353,
                              height: 80,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.all(Radius.circular(20)),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                              ),
                              child: const Text(
                                '이 기능이 궁금해요!',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Text.rich(
                            TextSpan(
                                children: [
                                  TextSpan(
                                      text: '그 밖에 다른 점이 궁금하다면\n',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400
                                      )
                                  ),
                                  TextSpan(
                                    text: '스포티',
                                    style: TextStyle(
                                        fontSize: 18,
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.w500
                                    ),
                                    recognizer: TapGestureRecognizer() // 터치 감지기 추가
                                      ..onTap = () {
                                        // '스포티'를 누르면 chatbot.dart로 넘어감
                                        Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (context, animation, secondaryAnimation) => ChatBot(),
                                            transitionDuration: Duration.zero, // 애니메이션 시간을 0으로 설정
                                            reverseTransitionDuration: Duration.zero, // 뒤로 가는 애니메이션도 없앰
                                          ),
                                        );
                                      },
                                  ),
                                  TextSpan(
                                      text: '에게 물어보세요!',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400
                                      )
                                  ),
                                ]
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 50,)
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Bottom Navigation Bar
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 100,
                decoration: const BoxDecoration(
                  color: Color(0xFFFF5353),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
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
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) =>
                          const User(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: const AlwaysStoppedAnimation(1),
                              child: child,
                            );
                          },
                        ),
                      );
                    } else if (index == 1) {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) =>
                          const Saved(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: const AlwaysStoppedAnimation(1),
                              child: child,
                            );
                          },
                        ),
                      );
                    } else if (index != 2) {
                      setState(() {
                        selected = index;
                      });
                    }
                  },
                  backgroundColor: Colors.transparent,
                  elevation: 0,
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

            // 가운데 아이콘
            Positioned(
              bottom: 60,
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  // 가운데 아이콘 클릭 이벤트
                },
                child: Container(
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 4),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFF5353),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.center_focus_strong,
                        color: Colors.white,
                        size: 30,
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
