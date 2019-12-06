class ScheduleModel {
  String status;
  String msg;
  String movieId;
  String movieName;
  String date;
  List<Addresses> addresses;

  ScheduleModel(
      {this.status,
      this.msg,
      this.movieId,
      this.movieName,
      this.date,
      this.addresses});

  ScheduleModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    movieId = json['movie_id'];
    movieName = json['movie_name'];
    date = json['date'];
    if (json['addresses'] != null) {
      addresses = new List<Addresses>();
      json['addresses'].forEach((v) {
        addresses.add(new Addresses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    data['movie_id'] = this.movieId;
    data['movie_name'] = this.movieName;
    data['date'] = this.date;
    if (this.addresses != null) {
      data['addresses'] = this.addresses.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Addresses {
  String addressId;
  String addressName;
  List<Formats> formats;

  Addresses({this.addressId, this.addressName, this.formats});

  Addresses.fromJson(Map<String, dynamic> json) {
    addressId = json['address_id'];
    addressName = json['address_name'];
    if (json['formats'] != null) {
      formats = new List<Formats>();
      json['formats'].forEach((v) {
        formats.add(new Formats.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address_id'] = this.addressId;
    data['address_name'] = this.addressName;
    if (this.formats != null) {
      data['formats'] = this.formats.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Formats {
  String format;
  List<Times> times;

  Formats({this.format, this.times});

  Formats.fromJson(Map<String, dynamic> json) {
    format = json['format'];
    if (json['times'] != null) {
      times = new List<Times>();
      json['times'].forEach((v) {
        times.add(new Times.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['format'] = this.format;
    if (this.times != null) {
      data['times'] = this.times.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Times {
  String scheduleID;
  String start;
  String end;

  Times({this.scheduleID, this.start, this.end});

  Times.fromJson(Map<String, dynamic> json) {
    scheduleID = json['schedule_id'];
    start = json['start'];
    end = json['end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['schedule_id'] = this.scheduleID;
    data['start'] = this.start;
    data['end'] = this.end;
    return data;
  }
}
