import 'package:flutter/material.dart';


void main() {
  runApp(const ChatBot());
}

class ChatBot extends StatefulWidget {
  const ChatBot({super.key});

  @override
  _ChatBotState createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  final TextEditingController _controller = TextEditingController();
  bool _isMessageVisible = false;
  List<String> messages = []; // 메시지 리스트

  @override
  void initState() {
    super.initState();

    // 페이지가 로드된 후 0.3초 뒤에 메시지를 표시
    Future.delayed(const Duration(milliseconds: 250), () {
      if (!_isMessageVisible) {
        setState(() {
          _isMessageVisible = true;
        });
      }
    });
  }

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
        backgroundColor: const Color(0xFFFAFAFA),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 60, 30, 80),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context); // 이전 페이지로 돌아가기
                        },
                        child: const Icon(Icons.arrow_back_ios),
                      ),
                      Expanded(
                        child: Center(
                          child: const Text(
                            '스포티',
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // 자동으로 첫 번째 메시지를 표시
            if (_isMessageVisible)
              Positioned(
                left: 30, // 왼쪽으로 30만큼 떨어진 위치
                top: 140,
                child: Container(
                  width: 290,
                  height: 90,
                  padding: EdgeInsets.fromLTRB(11, 15, 11, 15),
                  decoration: BoxDecoration(
                    color: Color(0xFFFF5353), // 배경색 지정
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    '안녕하세요! 저는 상담을 도와줄 스포티에요!\n무엇을 도와드릴까요? 가전에 대해 궁금한 점을 마음껏 물어보세요!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1.4,
                    ),
                  ),
                ),
              ),
            // 사용자 메시지 표시
            Positioned(
              top: 250,
              left: 30,
              right: 30,
              child: SingleChildScrollView( // 스크롤 가능한 영역으로 설정
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end, // 오른쪽 정렬 유지
                  children: messages.asMap().map((index, message) {
                    return MapEntry(
                      index,
                      Container(
                        width: 250, // 너비 250으로 고정
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.fromLTRB(11, 15, 11, 15),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Color(0xFFFF5353)
                            )
                        ),
                        child: Text(
                          message,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: 1.4,
                          ),
                        ),
                      ),
                    );
                  }).values.toList(),
                ),
              ),
            ),
            Positioned(
              bottom: 40,
              left: 20,
              right: 20,
              child: Container(
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: '궁금한 점을 물어보세요 :)',
                          hintStyle: TextStyle(color: Color(0xFFB9B9B9), fontSize: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Color(0xFFF3F3F3),
                          contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.send, color: Colors.grey),
                            onPressed: () {
                              String message = _controller.text;
                              if (message.isNotEmpty) {
                                setState(() {
                                  messages.add(message); // 사용자가 입력한 메시지 추가
                                });
                                _controller.clear();
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
