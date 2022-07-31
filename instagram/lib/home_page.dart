import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 피트 영역을 가져온것
import 'feed.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      "https://cdn2.thecatapi.com/images/bi.jpg",
      "https://cdn2.thecatapi.com/images/63g.jpg",
      "https://cdn2.thecatapi.com/images/a3h.jpg",
      "https://cdn2.thecatapi.com/images/a9m.jpg",
      "https://cdn2.thecatapi.com/images/aph.jpg",
      "https://cdn2.thecatapi.com/images/1rd.jpg",
      "https://cdn2.thecatapi.com/images/805.gif",
    ];

    return Scaffold(
        appBar: AppBar(
          // 왼쪽 상단은 leading
          leading: IconButton(
            icon: Icon(CupertinoIcons.camera, color: Colors.black),
            onPressed: () {},
          ),
          // 우측 상단은 Action
          actions: [
            IconButton(
              icon: Icon(CupertinoIcons.paperplane, color: Colors.black),
              onPressed: () {},
            )
          ],
          // 이미지 로고 넣는곳
          title: Image.asset(
            'assets/logo.png',
            height: 32,
          ),
          // 앱위에있는걸 가운데로 정렬
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        // ListView를 이용하면 적은 코드로 itemCount 만큼 화면을 그릴 수 있습니다
        body: ListView.builder(
          // 전체 아이템 개수 , 이미지.갯수
          itemCount: images.length,
          // index는 0 부터 99까지 증가
          itemBuilder: ((context, index) {
            String image = images[index];
            return Feed(
              imageUrl: image,
            ); // 10번 실행
          }),
        ));
  }
}
