import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Feed extends StatefulWidget {
  const Feed({
    Key? key,
    // imageUrl 을 바로 11번째를 넣어주는거다
    // this는 현재 지금 인스턴스를 이미지 유아엘에다 넣는다  (자기자신)
    required this.imageUrl,
  }) : super(key: key);

  final String imageUrl;

  @override
  State<Feed> createState() => _FeedState();
}

// 언더바는 외부 다른곳에서 못불어옴 지금 파일에서만 부를수있다
class _FeedState extends State<Feed> {
  // 좋아요 여부 첫 값은 False
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 이미지 네트워크로 해놓음
        Image.network(
          widget.imageUrl,
          height: 400,
          width: double.infinity,
          // 알아서 적적하게 넣어라 폭을 알아서
          fit: BoxFit.cover,
        ),
        //수직은
        Row(
          children: [
            IconButton(
              icon: Icon(
                CupertinoIcons.heart,
                // if : 조건 ? 반환값1 : 반환값2
                color: isFavorite ? Colors.pink : Colors.black,
              ),
              onPressed: () {
                // setState은 화면을 갱신해라
                setState(() {
                  //상태를 바꾸는 코드
                  isFavorite = !isFavorite;
                });
              },
            ),
            IconButton(
              icon: Icon(CupertinoIcons.chat_bubble, color: Colors.black),
              onPressed: () {},
            ),
            //끝으로 보내는건
            // 공백을 만들어주는 것
            Spacer(),
            IconButton(
              icon: Icon(CupertinoIcons.bookmark, color: Colors.black),
              onPressed: () {},
            ),
          ],
        ),

        // 좋아요
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "2 likes",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // 설명
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "My cat is docile even when bathed. I put a duck on his head in the wick and he's staring at me. Isn't it so cute??",
          ),
        ),

        // 날짜
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "FEBURARY 6",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
