import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '플러터 회원가입 앱',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: const MainActivity(title: '플러터 회원가입'),
    );
  }
}

class MainActivity extends StatefulWidget {
  const MainActivity({super.key, required this.title});

  final String title;

  @override
  State<MainActivity> createState() => _MainActivityState();
}

class _MainActivityState extends State<MainActivity> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 150,),
              Text('회원가입 앱', style: TextStyle(fontSize: 34), textAlign: TextAlign.center,),
              SizedBox(height: 150,),
              TextField(decoration: const InputDecoration(hintText: '아이디 입력'),),
              TextField(decoration: const InputDecoration(hintText: '비밀번호 입력'),),
              TextField(decoration: const InputDecoration(hintText: '이메일 입력'),),
              TextField(decoration: const InputDecoration(hintText: '이름 입력'),),
              SizedBox(height: 16,),
              ElevatedButton(onPressed: _registerUser, child: Container(
                width: double.infinity, child: Text('회원 가입', textAlign: TextAlign.center,),)),
              SizedBox(height: 16,),
              ElevatedButton(onPressed: _listUsers, child: Container(
                width: double.infinity, child: Text('회원 조회', textAlign: TextAlign.center,),)),
            ],
          ),
        ),
      )
    );
  } // build

  // 회원가입 처리
  Future<void> _registerUser() async {
    // showSnackBar : 간단한 메세지 출력
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('회원가입 기능 구현중...'))
    );
  }

  // 회원조회 처리
  Future<void> _listUsers() async {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('회원조회 기능 구현중...'))
    );
  }

} // _MainActivityState
