import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'loading_screen.dart';

class ImagePredictionPage extends StatefulWidget {
  final bool autoCapture;

  ImagePredictionPage({this.autoCapture = false});

  @override
  _ImagePredictionPageState createState() => _ImagePredictionPageState();
}

class _ImagePredictionPageState extends State<ImagePredictionPage> {
  File? _image; // 촬영한 이미지를 저장
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    if (widget.autoCapture) {
      _getImageFromCamera(); // autoCapture가 true인 경우 카메라 실행
    }
  }

  // 카메라 실행 함수
  Future<void> _getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      File selectedImage = File(pickedFile.path);

      setState(() {
        _image = selectedImage;
      });

      // 로딩 화면으로 이동
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoadingScreen(image: selectedImage), // 로딩 화면으로 이동
        ),
      );
    } else {
      print("사진 촬영이 취소되었습니다.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 60, 30, 20),
        child: Column(
          children: [
            // 상단 UI
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context); // 뒤로가기
                  },
                  child: const Icon(Icons.arrow_back_ios),
                ),
                const SizedBox(width: 80),
              ],
            ),
            const SizedBox(height: 50), // 상단과 콘텐츠 사이 간격

            // 촬영된 이미지 미리보기
            if (_image != null)
              Image.file(
                _image!,
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.5,
                fit: BoxFit.cover,
              ),
          ],
        ),
      ),
      // 하단에 사진 촬영 버튼 고정
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(30, 80, 30, 60),
        child: SizedBox(
          width: 340,
          height: 55,
          child: ElevatedButton(
            onPressed: _getImageFromCamera, // 사진 촬영 실행
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFFF5353),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              // side: const BorderSide(
              //   color: Color(0xFFFF5353),
              //   width: 1.5,
              // ),
            ),
            child: const Text(
              "검색하기",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),

        )

      ),

    );
  }
}
