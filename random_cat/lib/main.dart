import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // main() 함수에서 async를 쓰려면 필요
  // 복사에서 사용
  WidgetsFlutterBinding.ensureInitialized();

  // shared_preferences 인스턴스 생성
  // 파일로 보고 파일 형태로 읽고 쓴다
  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
      providers: [
        // 생성자 호출 하는 방법 CATSERVICE
        ChangeNotifierProvider(create: (context) => CatService(prefs)),
      ],
      child: const MyApp(),
    ),
  );
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

/// 고양이 서비스
class CatService extends ChangeNotifier {
  // 고양이 사진 담을 변수
  List<String> catImages = [];

  // 좋아요 사진
  List<String> favoriteImages = [];

  // SharedPreferences 인스턴스
  // 담아두는 변수
  SharedPreferences prefs;

  CatService(this.prefs) {
    getRandomCatImage();

    // 페이버리로 저장된 페이버릿이미지를 가져온다
    // 저장된 값이 없는경우 NULL로 반환하므로
    //이때는 빈 배열을 넣어준다 그부분이 ?? [] 이부분이다
    favoriteImages = prefs.getStringList("favorit") ?? [];
  }

  void getRandomCatImage() async {
    Response result = await Dio().get(
        "https://api.thecatapi.com/v1/images/search?limit=10&mime_types=jpg");
    print(result.data);
    for (var i = 0; i < result.data.length; i++) {
      var map = result.data[i];
      print(map);
      print(map["url"]);
      catImages.add(map["url"]);
    }
    notifyListeners(); // 새로고침
  }

  void toggleFavoriteImage(String catImage) {
    if (favoriteImages.contains(catImage)) {
      favoriteImages.remove(catImage); // 이미 좋아요한 경우 삭제
    } else {
      favoriteImages.add(catImage);
    }
    //페이버릿 이미지를 페이버리라는 이름으로 저장 한다
    prefs.setStringList("favorites", favoriteImages);

    notifyListeners(); // 새로고침
  }
}

/// 홈 페이지
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CatService>(
      builder: (context, catService, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("랜덤 고양이"),
            backgroundColor: Colors.amber,
            actions: [
              // 좋아요 페이지로 이동
              IconButton(
                icon: Icon(Icons.favorite),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FavoritePage()),
                  );
                },
              )
            ],
          ),
          // 고양이 사진 목록
          // r그리드
          body: GridView.count(
            mainAxisSpacing: 8,
            // 8정도로 뛰어놨다
            crossAxisSpacing: 8,
            padding: EdgeInsets.all(8),
            crossAxisCount: 2,
            //  배열을 몇개 만들꺼냐
            children: List.generate(
              catService.catImages.length,
              //  익명함수로 갯수만큼 위에 써여져있는것 만큼 나온다
              (index) {
                String catImage = catService.catImages[index];
                return GestureDetector(
                  onTap: () {
                    //좋아요 하는거
                    catService.toggleFavoriteImage(catImage);
                  },
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.network(
                          catImage,
                          // 알아서 사진을 짤라서 잘만들어준다
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        right: 8,
                        bottom: 8,
                        child: Icon(
                          Icons.favorite,
                          color: catService.favoriteImages.contains(catImage)
                              ? Colors.amber
                              : Colors.transparent,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

/// 좋아요 페이지
class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CatService>(
      builder: (context, catService, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("좋아요"),
            backgroundColor: Colors.amber,
          ),
          body: GridView.count(
            mainAxisSpacing: 8,
            // 8정도로 뛰어놨다
            crossAxisSpacing: 8,
            padding: EdgeInsets.all(8),
            crossAxisCount: 2,
            //  배열을 몇개 만들꺼냐
            children: List.generate(
              catService.favoriteImages.length,
              //  익명함수로 갯수만큼 위에 써여져있는것 만큼 나온다
              (index) {
                String catImage = catService.favoriteImages[index];
                return GestureDetector(
                  onTap: () {
                    //좋아요 하는거
                    catService.toggleFavoriteImage(catImage);
                  },
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.network(
                          catImage,
                          // 알아서 사진을 짤라서 잘만들어준다
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        right: 8,
                        bottom: 8,
                        child: Icon(
                          Icons.favorite,
                          color: catService.favoriteImages.contains(catImage)
                              ? Colors.amber
                              : Colors.transparent,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
