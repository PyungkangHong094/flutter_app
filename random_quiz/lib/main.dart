import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

/// 홈 페이지
/* 화면을 갱신하는거는 Statelesswidget 으로 불가능하니 
  당연히 StatefulWidget 바꿔줘야한다*/
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 처음에 아무것도 안보여주는거
  String quiz = "";

  @override
  void initState() {
    super.initState();
    // print("start");
    getQuiz();
  }

  // 퀴즈 가져오기
  void getQuiz() async {
    String trivia = await getNumberTrivia();
    setState(() {
      quiz = trivia;
    });
  }

  /// Numbers API 호출하기
  Future<String> getNumberTrivia() async {
    // get 메소드로 URL 호출
    Response result = await Dio().get('http://numbersapi.com/random/trivia');
    String trivia = result.data; // 응답 결과 가져오기
    print(trivia);
    return trivia;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // SafeArea 위젯은 기기별로 상단과 하단에 영역이 달라
      //아래 이미지와 같이 보이는 문제를 해결해주는 위젯입니다.
      backgroundColor: Color.fromARGB(255, 205, 103, 137),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),

          // 세로방향
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // quiz
              // 부모안에서 최대 크기로 만들어주는
              Expanded(
                child: Center(
                  child: Text(
                    // 퀴즈 변수
                    quiz,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              // New Quiz 버튼
              // expanded 써서 맨밑으로 내려간걸 볼수있다
              SizedBox(
                height: 42,
                child: ElevatedButton(
                  child: Text(
                    "New Quiz",
                    style: TextStyle(
                      color: Colors.pinkAccent,
                      fontSize: 24,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  onPressed: () async {
                    // New Quiz 클릭시 퀴즈 가져오기
                    // quiz = await getNumberTrivia();
                    // String trivia = await getNumberTrivia();
                    // setState(() {
                    //   quiz = trivia;
                    // });
                    getQuiz();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
