import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

import 'helper/database_helper.dart';
import 'model/member.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Window, Linux 앱 실행시
  // databaseFactory = databaseFactoryFfi;
  // sqfliteFfiInit();

  // web 앱 실행시
  // dart run sqflite_common_ffi_web:setup  (터미널)
  databaseFactory = databaseFactoryFfiWeb;

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

  // 변수 정의
  final Database_Helper _dbHelper = Database_Helper.instance;
  final TextEditingController _useridController = TextEditingController();
  final TextEditingController _passwdController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

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
              TextField(controller: _useridController, decoration: const InputDecoration(hintText: '아이디 입력'),),
              TextField(controller: _passwdController, decoration: const InputDecoration(hintText: '비밀번호 입력'),),
              TextField(controller: _emailController, decoration: const InputDecoration(hintText: '이메일 입력'),),
              TextField(controller: _nameController, decoration: const InputDecoration(hintText: '이름 입력'),),
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
    // 입력한 회원 정보 가져오기
    String userid = _useridController.text.trim();
    String passwd = _passwdController.text.trim();
    String email = _emailController.text.trim();
    String name = _nameController.text.trim();

    // 입력 내용 확인
    if (userid.isEmpty || passwd.isEmpty || email.isEmpty || name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('모든 필드를 입력하세요!!'))
      );
    }

    // 저장할 회원 객체 생성
    final member = Member(
      userid: userid, passwd: passwd, email: email, name: name
    );

    // 회원 정보 저장 처리
    final result = await _dbHelper.insertMember(member);
    if (result > 0) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('회원가입이 완료되었습니다!!'))
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('회원가입 실패!!'))
      );
    }

    // 입력필드 초기화
    _useridController.clear();
    _passwdController.clear();
    _emailController.clear();
    _nameController.clear();
  } // insertMember

  // 회원조회 처리
  Future<void> _listUsers() async {
    List<Map<String, dynamic>> users = await _dbHelper.getListUsers();

    // 조회결과를 대화상자에 리스트형태로 출력
    // ListView: 플러터에서 목록을 표시할때 사용하는 위젯
    // shrinkWrap : 내용에 맞게 ListView 크기 자동 조절
    // itemCount : ListView에 나타낼 항목 수
    // itemBuilder : ListView에 나타낼 각 항목을 어떻게 표시할지 정의
    // ListTile : ListView에 나타낼 각 항목을 의미, 제목과 부제목으로 구성
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('회원 목록'),
        content: Container(width: double.maxFinite,
          child: ListView.builder(shrinkWrap: true, itemCount: users.length,
              itemBuilder: (context, idx) {
                final user = users[idx];
                return ListTile(title: Text('${user['userid']}'),
                  subtitle: Text('${user['email']} ${user['regdate']}'),);
              }
          )),
        actions: [
          // pop : 현재 화면에 나타난 위젯을 제거pop
          TextButton(onPressed: () => Navigator.pop(context),
            child: Text('닫기')),
        ],
      ) // AlertDialog
    ); // showDialog
  } // listUsers

} // _MainActivityState
