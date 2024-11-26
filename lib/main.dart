import 'package:flutter/material.dart';
import 'onboarding.dart'; // onboarding.dart 파일을 import 합니다.
import 'user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // 디버그 배너 없애기
      home: SplashScreen(), // SplashScreen 위젯을 home으로 설정
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 1.0; // 초기 opacity 값 1로 설정

  @override
  void initState() {
    super.initState();
    // 앱이 시작하면 3초 후에 onboarding.dart로 페이지 전환
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _opacity = 0.0; // opacity를 0으로 설정해 페이드 아웃
      });
      Future.delayed(Duration(milliseconds: 500), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OnBoarding()), // OnBoarding 페이지로 이동
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // 화면 크기 가져오기
    final double imageWidth = size.width * 0.7; // 상단과 하단 이미지의 동일한 너비
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnimatedOpacity(
        opacity: _opacity, // opacity 값에 따라 화면이 점차 사라짐
        duration: Duration(milliseconds: 500), // 애니메이션 지속 시간
        child: Stack(
          children: [
            // 상단 이미지
            Positioned(
              top: 80, // 화면 위에서 80px 여백
              right: 0, // 오른쪽 정렬
              child: Image.asset(
                'assets/images/top.png',
                width: imageWidth, // 상단 이미지 크기 설정
                fit: BoxFit.contain, // 이미지 비율 유지하며 크기 조정
              ),
            ),
            // 로고 이미지
            Center(
              child: Image.asset(
                'assets/images/logo.png',
                width: size.width * 0.55, // 로고 이미지 크기 설정
                fit: BoxFit.contain, // 이미지 비율 유지하며 크기 조정
              ),
            ),
            // 하단 이미지
            Positioned(
              bottom: 80, // 화면 아래에서 80px 여백
              left: 0, // 왼쪽 정렬
              child: Image.asset(
                'assets/images/bottom.png',
                width: imageWidth, // 하단 이미지 크기 설정
                fit: BoxFit.contain, // 이미지 비율 유지하며 크기 조정
              ),
            ),
          ],
        ),
      ),
    );
  }
}
