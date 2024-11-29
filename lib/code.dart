import 'dart:convert';

import 'package:flutter/material.dart';
import 'userappliance.dart';
import 'chatbot.dart';
import 'saved.dart';
import 'user.dart';
import 'detection.dart';
import 'package:flutter/gestures.dart';

import 'package:http/http.dart' as http;

class Code extends StatefulWidget {
  final String modelName; // 전달받는 모델 이름
  final int modelCategory; // 전달받는 모델 카테고리

  const Code({
    super.key,
    required this.modelName,
    required this.modelCategory,
  });

  @override
  State<Code> createState() => _CodeState();
}

class _CodeState extends State<Code> {
  int selected = 0; // 현재 선택된 인덱스
  List<dynamic> questions = []; // 질문 데이터를 저장할 리스트
  bool isLoading = true; // 로딩 상태 관리

  @override
  void initState() {
    super.initState();
    fetchAppliances(); // 데이터를 가져오는 함수 호출
  }

  // 데이터를 가져오는 함수
  Future<void> fetchAppliances() async {
    const String url = 'http://192.168.219.201:8000/get_ques'; // FastAPI 서버 URL
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({"modelcate": widget.modelCategory}),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(utf8.decode(response.bodyBytes));
        setState(() {
          questions = responseData['questions'] ?? [];
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load questions with status code: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching questions: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      ),
      home: Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        body: Stack(
          children: [
            Column(
              children: [
                // 헤더
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 60, 30, 20),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context); // 뒤로가기
                        },
                        child: const Icon(Icons.arrow_back_ios),
                      ),
                      const SizedBox(width: 8), // 아이콘과 텍스트 간격 추가
                      Expanded(
                        child: Text(
                          widget.modelName, // 전달받은 모델 이름
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1, // 텍스트 한 줄로 제한
                          overflow: TextOverflow.ellipsis, // 넘치는 텍스트는 생략 처리
                        ),
                      ),
                    ],
                  ),
                ),
                // 스크롤 가능한
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 100), // 바텀 여백 추가
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 이미지
                        Container(
                          margin: const EdgeInsets.only(top: 40),
                          child: Image.asset('assets/images/codedetail.png'),
                        ),
                        const SizedBox(height: 30),
                        // 자주 묻는 FAQ
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
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
                          questions.length, // questions 리스트의 길이만큼 생성
                              (index) => Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(20, 25, 0, 25),
                              width: double.infinity,
                              height: 80,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                              ),
                              child: Text(
                                questions[index]['ques_data'], // questions 리스트의 각 요소를 텍스트로 사용
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Text.rich(
                            TextSpan(
                              children: [
                                const TextSpan(
                                  text: '그 밖에 다른 점이 궁금하다면\n',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                TextSpan(
                                  text: '스포티',
                                  style: TextStyle(
                                    fontSize: 18,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Color(0xFFFF5353),
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFFFF5353),
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation, secondaryAnimation) =>
                                              ChatBot(),
                                          transitionDuration: Duration.zero,
                                          reverseTransitionDuration: Duration.zero,
                                        ),
                                      );
                                    },
                                ),
                                const TextSpan(
                                  text: '에게 물어보세요!',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 30),
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
                height: 80,
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
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
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
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
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
              bottom: 40,
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          ImagePredictionPage(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0);
                        const end = Offset.zero;
                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: Curves.easeInOut));
                        var offsetAnimation = animation.drive(tween);

                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
                      },
                    ),
                  );
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
