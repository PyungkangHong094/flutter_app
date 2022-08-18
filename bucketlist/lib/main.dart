import 'package:flutter/cupertino.dart';
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
      //홈페이지 위젯에 있음
      home: HomePage(),
    );
  }
}

// 버킷 클래스
class Bucket {
  String job; // 할일
  bool isDone; // 완료 한거

  Bucket(this.job, this.isDone); // 생성자
}

/// 홈 페이지
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

// 빌드함수
class _HomePageState extends State<HomePage> {
  List<Bucket> bucketList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("버킷 리스트"),
      ),
      // 비어 있나요 ? 물어보는거
      body: bucketList.isEmpty
          ? Center(child: Text("버킷리스트를 작성해주세요"))
          // 배열로 보여주는거 Listview.builder 를 쓴거임
          : ListView.builder(
              itemCount: bucketList.length, // bucketList 개수 만큼 보여주기
              itemBuilder: (context, index) {
                // 인덱스는 0~까지 계속 보여줌
                Bucket bucket = bucketList[index]; // index에 해당하는 bucket 가져오기
                return ListTile(
                  // 리딩 타이틀 서브타이틀 트레이링이 들어가있음
                  // 버킷 리스트 할 일
                  title: Text(
                    bucket.job,
                    style: TextStyle(
                      fontSize: 24,
                      color: bucket.isDone ? Colors.red : Colors.black,
                      decoration: bucket.isDone
                          ? TextDecoration.lineThrough //선을  중간 긋는거
                          : TextDecoration.none,
                    ),
                  ),
                  // 삭제 아이콘 버튼
                  trailing: IconButton(
                    icon: Icon(CupertinoIcons.delete),
                    onPressed: () {
                      // 삭제 버튼 클릭시
                      showDeleteDialog(context, index);
                    },
                  ),
                  onTap: () {
                    // 아이템 클릭시
                    setState(() {
                      bucket.isDone = !bucket.isDone; //false 가 true로
                    });
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          // + 버튼 클릭시 버킷 생성 페이지로 이동
          String? job = await Navigator.push(
            // 푸시하는경우 팝을
            context,
            MaterialPageRoute(builder: (_) => CreatePage()), //페이지 이동
          );
          if (job != null) {
            //쓴 텍스트가 무언가있다면 버킷리스트에 추가하기
            setState(() {
              Bucket newBucket = Bucket(job, false);
              bucketList.add(newBucket);
            });
          }
        },
      ),
    );
  }

  void showDeleteDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          //팝업창
          title: Text("Are you sure?"),

          actions: [
            // 취소 버튼
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("취소"),
            ),

            // 확인 버튼
            TextButton(
              onPressed: () {
                setState(() {
                  bucketList.removeAt(index);
                });
                Navigator.pop(context);
              },
              child: Text(
                "확인",
                style: TextStyle(color: Colors.pink),
              ),
            ),
          ],
        );
      },
    );
  }
}

/// 버킷 생성 페이지
class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  // 텍스트필드의 값을 가져오고 가져오고
  TextEditingController textController = TextEditingController();
  // 경고 메세지 ?표시는 비어있을 수 있다
  String? error;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("버킷리스트 작성"),
        // 뒤로가기 버튼
        leading: IconButton(
          icon: Icon(CupertinoIcons.chevron_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 텍스트 입력창
            TextField(
              controller: textController, //에딩팅 하는걸 연결해줌 97번째
              autofocus: true,
              decoration: InputDecoration(
                hintText: "하고 싶은 일을 입력하세요",
                errorText: error, // 문자열을 적으면 에러가 나온다 빈문자열로
              ),
            ),
            SizedBox(height: 32),
            // 추가하기 버튼
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                child: Text(
                  "추가하기",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                onPressed: () {
                  // 추가하기 버튼 클릭시
                  String job = textController.text;
                  if (job.isEmpty) {
                    setState(() {
                      // 내가 화면을 보여주고 싶은거
                      error = "you need to fill out the form";
                    });
                  } else {
                    setState(() {
                      error = null;
                    });
                    Navigator.pop(context, job); //클릭시 데이터를 넘긴다
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
