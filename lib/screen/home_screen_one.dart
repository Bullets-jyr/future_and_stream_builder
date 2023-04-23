import 'dart:math';

import 'package:flutter/material.dart';

class HomeScreenOne extends StatefulWidget {
  const HomeScreenOne({Key? key}) : super(key: key);

  @override
  State<HomeScreenOne> createState() => _HomeScreenOneState();
}

class _HomeScreenOneState extends State<HomeScreenOne> {
  // setState함수를 호출해서 build함수를 아에 다시 불려버리면, FutureBuilder가 또 실행이 됩니다.
  // 그런데 snapshot.data가 null로 돌아가지 않습니다... => 캐싱
  // FutureBuilder가 우리가 비록 setState함수를 호출해서 build함수를 다시 실행했지만,
  // FutureBuilder가 기존의 데이터 값을 기억을 합니다. (아에 재실행을 하면 data는 null 입니다.)
  // 한번 빌드가 된 이후에 setState함수를 호출한다면, 기존 데이터는 유지가 됩니다.
  // 기존 데이터가 유지된 생태에서 FutureBuilder가 다시 실행되고, 변경된 값이 반영됩니다.
  // FutureBuilder는 캐싱기능이 자동으로 되도록 원래 기능에 적용되어 있습니다.
  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: 16.0,
    );
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: getNumber(),
          // ConnectionState가 바뀔 때마다 builder가 새로 불립니다.
          builder: (context, snapshot) {
            // 앱이 느려보일 가능성이 있습니다.
            // if (snapshot.connectionState == ConnectionState.waiting) {
            //   return Center(
            //     child: CircularProgressIndicator(),
            //   );
            // }

            // 한번도 데이터 요청을 하지 않은 경우 입니다.
            // if (!snapshot.hasData) {
            //   return Center(
            //     // 전체 영역에 CircularProgressIndicator를 보여주는 코드
            //     child: CircularProgressIndicator(),
            //   );
            // }

            // 아래 3가지 경우에 대비해서 위젯들을 마음대로 랜더링 해줄 수 있습니다.
            if (snapshot.hasData) {
              // 데이터가 있을 때, 위젯 랜더링
            }

            if (snapshot.hasError) {
              // 에러가 났을 때, 위젯 랜더링
            }

            // 위 케이스 둘다 아닐 경우?
            // 그때는 로딩중일 때! 위젯 랜더링

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'FutureBuilder',
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
                // 에러값도 캐싱됩니다...
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

  Future<int> getNumber() async {
    await Future.delayed(Duration(seconds: 3));

    final random = Random();

    // 실제로 데이터를 정상적으로 받았을 경우, error는 null로 돌아갑니다.
    // throw Exception('에러가 발생했습니다.');

    return random.nextInt(100);
  }
}
