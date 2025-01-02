class Member {
  // 멤버변수
  final int? mno;
  final String userid;
  final String passwd;
  final String email;
  final String name;
  final String? regdate;

  // 생성자로 객체 생성시 필수 항목 : 아이디/비번/이메일/이름
  Member({this.mno,
    required this.userid, required this.passwd,
    required this.email, required this.name,
    this.regdate});

  @override
  String toString() {
    return 'Member{mno: $mno, userid: $userid, passwd: $passwd, email: $email, name: $name, regdate: $regdate}';
  }

  // Member객체를 Map으로 변환하는 메서드 (DB저장용)
  Map<String, dynamic> toMap() {
    return {
      'userid': userid,
      'passwd': passwd,
      'email': email,
      'name': name,
    };
  }

  // Map을 Member 객체로 변환 (DB 조회용)
  factory Member.fromMap(Map<String, dynamic> map) {
    return Member(
        mno: map['mno'],
        userid: map['userid'],
        passwd: map['passwd'],
        email: map['email'],
        name: map['name'],
        regdate: map['regdate']
    );
  }

}