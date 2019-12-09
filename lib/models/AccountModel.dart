class AccountModel {
  String status;
  String msg;
  String token;
  Info info;

  AccountModel({this.status, this.msg, this.token, this.info});

  AccountModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    token = json['token'];
    info = json['info'] != null ? new Info.fromJson(json['info']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    data['token'] = this.token;
    if (this.info != null) {
      data['info'] = this.info.toJson();
    }
    return data;
  }
}

class Info {
  String username;
  String phone;
  String cmt;
  String email;
  String sex;
  String birthday;
  int point;
  int valueOf1Point;
  String money;

  Info(
      {this.username,
      this.phone,
      this.cmt,
      this.email,
      this.sex,
      this.birthday,
      this.point,
      this.valueOf1Point,
      this.money});

  Info.fromJson(Map<String, dynamic> json) {
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
