import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final String detectedLabel;

  ResultScreen({required this.detectedLabel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: detectedLabel == "결과를 찾을 수 없습니다."
          ? _buildErrorScreen(context)
          : _buildResultScreen(context),
    );
  }

  Widget _buildErrorScreen(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center( // 화면 전체를 가로/세로 중앙에 배치
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // 위아래로 배치
          crossAxisAlignment: CrossAxisAlignment.center, // 모든 요소를 가로 중앙 정렬
          children: [
            // 상단 콘텐츠
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 200), // 상단 여백
                Image.asset(
                  'assets/images/result/BELL.png', // 에러 이미지를 해당 경로에 추가하세요
                  height: 150,
                ),
                const SizedBox(height: 70),
                const Text(
                  "결과를 찾을 수 없습니다.",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Colors.black),
                  textAlign: TextAlign.center, // 텍스트 가로 정렬
                ),
              ],
            ),
            // 하단 버튼
            Padding(
              padding: const EdgeInsets.only(bottom: 50.0), // 하단 여백
              child: Column(
                children: [
                  SizedBox(
                    width: 340, // 버튼 너비
                    height: 55, // 버튼 높이
                    child: ElevatedButton(
                      onPressed: () {
                        print("스포티에게 문의 버튼 클릭됨");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF5353),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        "스포티에게 물어볼게!",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: 340, // 버튼 너비
                    height: 55, // 버튼 높이
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context); // 이전 화면으로 이동
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFFF5353)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        "다시 찾아줘!",
                        style: TextStyle(fontSize: 18,  color: Color(0xFFFF5353)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultScreen(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // 상단과 하단으로 구분
          children: [
            // 상단 콘텐츠
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 80), // 상단 여백
                Image.asset(
                  'assets/images/result/sttar.png',
                  width: 100,
                  height: 100,
                ),
                const SizedBox(height: 30),
                CircleAvatar(
                  radius: 100,
                  backgroundColor: Color(0x80FF5353),
                  backgroundImage: AssetImage('assets/images/appliance/example.png'),
                ),
                const SizedBox(height: 20),
                const Text(
                  "박채연님이 궁금한 가전은",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                const SizedBox(height: 10),
                Text(
                  "'$detectedLabel'",
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color(0xFFFF5353),
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text(
                  "이 제품이 맞나요?",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            // 하단 버튼
            Padding(
              padding: const EdgeInsets.only(bottom: 50.0), // 하단 여백을 동일하게 설정
              child: Column(
                children: [
                  SizedBox(
                    width: 340,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        print("사용자가 확인");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF5353),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        "맞아! 이게 궁금해.",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15), // 버튼 간격
                  SizedBox(
                    width: 340,
                    height: 55,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFFF5353)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        "아니야! 다시 찾아줘.",
                        style: TextStyle(color: Color(0xFFFF5353), fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
