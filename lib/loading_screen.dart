import 'package:flutter/material.dart';
import 'result.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoadingScreen extends StatefulWidget {
  final File image;

  LoadingScreen({required this.image});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double _progress = 0.0; // 로딩 바 초기값
  String? _detectedLabel; // 서버에서 반환된 라벨값 저장

  @override
  void initState() {
    super.initState();
    _startAnalysis();
  }

  Future<void> _startAnalysis() async {
    // 점진적으로 로딩 바 증가
    for (int i = 1; i <= 100; i++) {
      await Future.delayed(const Duration(milliseconds: 60), () {
        setState(() {
          _progress = i / 100; // 1%씩 증가
        });
      });
    }

    // 서버로 객체 탐지 요청
    await _predictImage(widget.image);

    // 로딩이 끝나면 결과 화면으로 이동
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(detectedLabel: _detectedLabel ?? "결과를 찾을 수 없습니다."),
      ),
    );
  }

  Future<void> _predictImage(File image) async {
    List<int> imageBytes = await image.readAsBytes();
    String base64Image = base64Encode(imageBytes);

    String url = "http://43.203.198.223:8000/predict";

    Map<String, String> data = {"image": base64Image};

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        List<dynamic> predictions = jsonResponse['predictions'];

        if (predictions.isNotEmpty) {
          var highConfidencePredictions = predictions.where((p) => p['confidence'] >= 65).toList();

          if (highConfidencePredictions.isNotEmpty) {
            highConfidencePredictions.sort((a, b) => b['confidence'].compareTo(a['confidence']));
            setState(() {
              _detectedLabel = highConfidencePredictions[0]['label'];
            });
          } else {
            setState(() {
              _detectedLabel = "No high confidence prediction";
            });
          }
        } else {
          setState(() {
            _detectedLabel = "No predictions";
          });
        }
      } else {
        print('Failed to get prediction: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "가전을 찾고 있어요!\n잠시만 기다려주세요",
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Image.asset(
              'assets/images/finding.png', // 로딩 중 이미지
              height: 100,
            ),
            const SizedBox(height: 20),
            // 로딩 바를 가운데 정렬
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: LinearProgressIndicator(
                value: _progress, // 점진적으로 증가하는 값
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
                backgroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
