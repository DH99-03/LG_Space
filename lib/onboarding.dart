import 'package:flutter/material.dart';
import 'login.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const OnBoarding());
}

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

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
      home: const OnBoardingScreen(),
    );
  }
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  final List<String> texts = [
    '가전 기능을 찾으려 검색할 때,\n원하는 정보가 한 번에 나타나지 않아\n불편하셨죠?',
    '이제 궁금한 가전을\n사진으로 찍어보세요!',
    '사진 한 번으로 제품을 인식해서\n기능부터 사용 팁까지 필요한 정보를\n바로 알려드려요.',
    '스포티에게 물어보면 더 자세한\n대답도 해드릴게요😉',
  ];
  final List<String> images = [
    'assets/images/phone1.png',
    'assets/images/phone2.png',
    'assets/images/ex3.png',
    'assets/images/ex4.png',
  ];

  final List<String> subImages = [
    'assets/images/1.png',
    'assets/images/2.png',
    'assets/images/3.png',
    'assets/images/4.png',
  ];

  int currentPage = 0;

  void goToLogin(BuildContext context) {
    Navigator.pushReplacement(
      context,
      CupertinoPageRoute(builder: (context) => Login()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.fromLTRB(
          size.width * 0.08,
          size.height * 0.05,
          size.width * 0.08,
          size.height * 0.05,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        currentPage = index;
                      });
                    },
                    itemCount: texts.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            height: size.height * 0.15,
                            margin: EdgeInsets.only(top: size.height * 0.05),
                            alignment: Alignment.center,
                            child: Text(
                              texts[index],
                              style: TextStyle(
                                fontSize: size.width * 0.04,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                          decoration: BoxDecoration(
                          color: Colors.white,
                          ),// 흰색 배경
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: size.height * 0.0),
                          child: Image.asset(
                            images[index],
                            width: size.width * 0.7,
                          ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: currentPage == texts.length - 1
                      ? () => goToLogin(context)
                      : null, // 다른 페이지에서는 비활성화
                  child: Text(
                    '시작하기',
                    style: TextStyle(
                      fontSize: size.width * 0.045,
                      color: currentPage == texts.length - 1 ? Colors.white : Color(0xFF878787),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, size.height * 0.07),
                    backgroundColor: currentPage == texts.length - 1 ? Color(0xFFFF5353) : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(size.width * 0.1),
                    ),
                    elevation: 0,
                  ),
                ),
              ],
            ),
            Positioned(
              top: size.height * 0.75,
              child: Image.asset(
                subImages[currentPage],
                width: size.width * 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
