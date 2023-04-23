import 'dart:math';

import 'package:flutter/material.dart';

class HomeScreenTwo extends StatefulWidget {
  const HomeScreenTwo({Key? key}) : super(key: key);

  @override
  State<HomeScreenTwo> createState() => _HomeScreenTwoState();
}

class _HomeScreenTwoState extends State<HomeScreenTwo> {
  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: 16.0,
    );
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        // FutureBuilder와 StreamBuilder에는 제네릭을 넣을 수 있습니다.
        // 하지만 넣지 않아도 됩니다. 왜? 함수에서 예측을 하고 있습니다.
        // 직접적으로 명시를 해주고 싶으면? 실제 snapshot.data에 들어가야 되는 타입을 넣어줄 수 있습니다.
        // 위 개념은 FutureBuilder도 동일합니다.
        // StreamBuilder도 data값이 캐싱이됩니다. 따라서 data값이 아에 null로 되돌아 가지 않고,
        // 기존의 마지막에 가지왔던 데이터를 기준으로 기존 데이터 값을 data값에 넣어줍니다.
        // 그 다음에 새로 들어온 값들을 보여줍니다.
        // stream은 닫아줘야하는데 이러한 작업도 통째로 알아서 해줍니다. (stream을 따로 닫아줘야하는 것을 신경 쓸 필요가 없습니다.)
        child: StreamBuilder<int>(
          stream: streamNumbers(),
          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'StreamBuilder',
                  style: textStyle.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  'ConnectionState : ${snapshot.connectionState}',
                  style: textStyle,
                ),
                Row(
                  children: [
                    Text(
                      'Data : ${snapshot.data}',
                      style: textStyle,
                    ),
                    if (snapshot.connectionState == ConnectionState.waiting)
                      CircularProgressIndicator(),
                  ],
                ),
                Text(
                  'Error : ${snapshot.error}',
                  style: textStyle,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {});
                  },
                  child: Text('setState'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // Stream이 끝나지 않았을 때의 상태가 ConnectionState.active 입니다.
  Stream<int> streamNumbers() async* {
    for (int i = 0; i < 10; i++) {
      if (i == 5) {
        // 실제 error을 던지게 되면, 기존에 있던 data가 null로 변경이되고, 에러값이 출력됩니다.
        throw Exception('i = 5');
      }

      await Future.delayed(Duration(seconds: 1));

      yield i;
    }
  }
}
