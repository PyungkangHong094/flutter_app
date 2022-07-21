import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // 화면이 보이는 영역
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            '히라야 로그인해라',
            style: TextStyle(fontSize: 28),
          ),
          // 상단
          centerTitle: true,
        ),
        // singlechildscroll은 입력창을 넣고 가려질때 자동으로 보여지게하는거
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: Image.network(
                      "http://158.247.223.218/media/article/%EC%BA%A1%EC%B2%98_Mp55AzH.PNG",
                      width: 250),
                ),
                TextField(
                  decoration: InputDecoration(labelText: '이메일'),
                ),
                TextField(
                  // 비밀번호 안보이게하는법
                  obscureText: true,
                  decoration: InputDecoration(labelText: '비밀번호'),
                ),
                Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 16),
                    child:
                        ElevatedButton(onPressed: () {}, child: Text('로그인'))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
