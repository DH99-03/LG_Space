import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'detection.dart';
import 'userappliance.dart';

void main() {
  runApp(const User());
}

class User extends StatelessWidget {
  const User({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(
          bodyLarge: TextStyle(
            fontFamily: 'Pretendard',
            fontSize: size.width * 0.05, // 반응형 폰트 크기
          ),
          bodyMedium: TextStyle(
            fontFamily: 'Pretendard',
            fontSize: size.width * 0.04, // 반응형 폰트 크기
          ),
          bodySmall: TextStyle(
            fontFamily: 'Pretendard',
            fontSize: size.width * 0.03, // 반응형 폰트 크기
          ),
        ),
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.fromLTRB(
            size.width * 0.08, // 왼쪽 여백
            size.height * 0.08, // 상단 여백
            size.width * 0.08, // 오른쪽 여백
            size.height * 0.08, // 하단 여백
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 텍스트 영역
              Text.rich(
                TextSpan(
                  text: '안녕하세요',
                  style: TextStyle(fontSize: size.width * 0.07, height: 1.8), // 반응형 텍스트 크기
                  children: <InlineSpan>[
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: size.width * 0.01),
                        child: Image.asset(
                          'assets/images/user/hand.png',
                          fit: BoxFit.contain,
                          width: size.width * 0.07, // 반응형 이미지 크기
                        ),
                      ),
                    ),
                    TextSpan(
                      text: ' 권동현',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    TextSpan(text: '님\n '),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: size.width * 0),
                        child: Image.asset(
                          'assets/images/user/3DOT.png',
                          fit: BoxFit.contain,
                          width: size.width * 0.15, // 반응형 이미지 크기
                        ),
                      ),
                    ),
                    TextSpan(text: '   오늘은 어떤 '),
                    TextSpan(
                      text: '점',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFEF4D4D),
                      ),
                    ),
                    TextSpan(text: '이\n'),
                    TextSpan(text: '궁금', style: TextStyle(fontWeight: FontWeight.w500)),
                    TextSpan(text: '하신가요?'),
                  ],
                ),
              ),
              // Stack으로 이미지와 버튼 구성
              Expanded(
                child: Stack(
                  children: [
                    // 이미지 영역
                    Positioned.fill(
                      child: Column(
                        children: [
                          Transform.translate(
                            offset: Offset(0, size.height * 0.015), // Y축으로 이동
                            child: Image.asset(
                              'assets/images/new.png',
                              fit: BoxFit.contain,
                              height: size.height * 0.5, // 이미지 크기 설정
                              width: double.infinity,
                            ),
                          ),
                          SizedBox(height: size.height * 0.03,),


                          // new와 동일한 너비의 컨테이너
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => UserAppliance()), // 이동할 페이지 설정
                              );
                            },
                            child: Container(
                              width: double.infinity,
                              height: size.height * 0.09,
                              decoration: BoxDecoration(
                                color: Colors.white, // 배경색
                                borderRadius: BorderRadius.circular(size.width * 0.03), // 모서리 둥글게
                                border: Border.all(
                                  color: Color(0xFFFF5353),
                                  width: 1.5,
                                ),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: size.width * 0.04), // 좌우 여백 추가
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween, // 텍스트와 이미지 양쪽으로 정렬
                                children: [
                                  // 왼쪽 텍스트
                                  Text(
                                    ' 등록된 가전이 궁금해!',
                                    style: TextStyle(
                                      fontSize: size.width * 0.04,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  // 오른쪽 이미지
                                  Image.asset(
                                    'assets/images/copy.png', // 이미지 경로
                                    width: size.width * 0.15, // 이미지 너비
                                    height: size.height * 0.2, // 이미지 높이
                                    fit: BoxFit.contain,
                                  ),
                                ],
                              ),
                            ),
                          )

                        ],
                      ),
                    ),
                    // 버튼 영역
                    Align(
                      alignment: Alignment(0, 0.465), // 버튼 위치
                      child: Container(
                        width: size.width * 0.75, // 버튼 너비 설정
                        height: size.height * 0.07, // 버튼 높이 설정
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) =>
                                    ImagePredictionPage(autoCapture: true), // autoCapture를 true로 설정
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
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(size.width * 0.08),
                            ),
                            elevation: 0,
                            splashFactory: NoSplash.splashFactory,
                          ).copyWith(
                            overlayColor: MaterialStateProperty.all(Colors.transparent),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '이건 뭘까? 궁금해!',
                                style: TextStyle(
                                  fontSize: size.width * 0.04,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Spacer(),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: size.width * 0.05,
                                color: Color(0xFFFF5353),
                              ),
                            ],
                          ),
                        ),

                      ),
                    )
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
