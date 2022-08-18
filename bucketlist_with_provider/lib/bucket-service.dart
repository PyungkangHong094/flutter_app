import 'package:flutter/material.dart';

import 'main.dart';

/*
ChangeNotifier를 상속받아야 
notifyListeners();를 호출하여 
데이터를 사용하는 화면을 갱신할 수 있습니다
*/

/// Bucket 담당
class BucketService extends ChangeNotifier {
  List<Bucket> bucketList = [
    Bucket('잠자기', false), // 더미(dummy) 데이터
  ];

  /// bucket 추가
  void createBucket(String job) {
    bucketList.add(Bucket(job, false));
    //changenotifer 에 소속되어있는거다
    // 컨슈머의 버켓서비스의 빌더 함수만 호출
    notifyListeners();
  }

  /// bucket 수정
  void updateBucket(Bucket bucket, int index) {
    bucketList[index] = bucket;
    notifyListeners();
  }

  /// bucket 삭제
  void deleteBucket(int index) {
    bucketList.removeAt(index);
    notifyListeners();
  }
}
