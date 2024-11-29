import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:spot/chatbot.dart';


import 'user.dart';

import 'code.dart';
import 'saved.dart';
import 'settings.dart';
import 'detection.dart';
import 'package:http/http.dart' as http;

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
      //home: const UserAppliance(userId: 1),  // 예시로 userId를 넘겨줌
    );
  }
}

class UserAppliance extends StatefulWidget {
  final int userId;
  final String userName;
  const UserAppliance({Key? key, required this.userId, required this.userName}) : super(key: key);

  @override
  State<UserAppliance> createState() => _UserApplianceState();
}

class _UserApplianceState extends State<UserAppliance> {
  int selected = 0;
  List<dynamic> appliances = []; // 가전목록 데이터를 저장할 리스트
  bool isLoading = true; // 로딩 상태 관리

  @override
  void initState() {
    super.initState();
    fetchAppliances(); // 데이터를 가져오는 함수 호출
  }

  // 데이터를 가져오는 함수
  Future<void> fetchAppliances() async {
    const String url = 'http://192.168.219.201:8000/get_models'; // FastAPI 서버 URL
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({"user_id": widget.userId}), // user_id 전달
      );


      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(utf8.decode(response.bodyBytes));
        setState(() {
          appliances = responseData['models']; // 모델 리스트 저장
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load appliances: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching appliances: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 60, 30, 80),
        child: Column(
          children: [
            // 상단 사용자 이름 표시 및 뒤로가기 버튼
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.arrow_back_ios),
                ),
                const SizedBox(width: 80),
                Text(
                  '${widget.userName}의 가전',
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(height: 30),
            // 가전 목록 표시
            ...appliances.map((appliance) {
              IconData iconData;
              switch (appliance['model_category']) {
                case 1: // 냉장고 카테고리
                  iconData = Icons.kitchen_outlined;
                  break;
                case 2: // 세탁기 카테고리
                  iconData = Icons.local_laundry_service_outlined;
                  break;
                default:
                  iconData = Icons.devices_other;
              }
              return GestureDetector(
                onTap: () {
                  // 다른 화면으로 이동하는 코드 작성
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Code(
                        modelName: appliance['model_name'], // model_name 전달
                        modelCategory: appliance['model_category'], // model_category 전달
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10), // 양쪽 padding 조정
                  width: double.infinity, // 부모 컨테이너의 크기를 화면 전체로 확장
                  height: 90, // 높이를 약간 늘림
                  decoration: BoxDecoration(
                    color: const Color(0xFFFE6464),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFFFE6464),
                      width: 1.0,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center, // 중앙 정렬
                    children: [
                      Icon(
                        iconData,
                        color: Colors.white,
                        size: 30,
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Text(
                          appliance['model_name'],
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          maxLines: 2, // 최대 2줄로 제한
                          overflow: TextOverflow.ellipsis, // 글자가 길면 생략 표시
                          softWrap: true, // 자동 줄바꿈 허용
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
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
                onTap: () {Navigator.push(
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
                child: Center(
                  child: Container(
                    width: 75,
                    height: 75,
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
                          Icons.center_focus_strong,
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
