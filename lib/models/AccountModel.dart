class AccountModel {
  String username;
  String phone;
  String cmt;
  String email;
  String sex;
  String birthday;
  int point;
  int valueOf1Point;
  String money;

  AccountModel(
      {this.username,
      this.phone,
      this.cmt,
      this.email,
      this.sex,
      this.birthday,
      this.point,
      this.valueOf1Point,
      this.money});

  AccountModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    phone = json['phone'];
    cmt = json['cmt'];
    email = json['email'];
    sex = json['sex'];
    birthday = json['birthday'];
    point = json['point'];
    valueOf1Point = json['valueOf1Point'];
    money = json['money'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['phone'] = this.phone;
    data['cmt'] = this.cmt;
    data['email'] = this.email;
    data['sex'] = this.sex;
    data['birthday'] = this.birthday;
    data['point'] = this.point;
    data['valueOf1Point'] = this.valueOf1Point;
    data['money'] = this.money;
    return data;
  }
}
