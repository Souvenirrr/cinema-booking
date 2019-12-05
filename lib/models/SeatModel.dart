class SeatModel {
  String status;
  String msg;
  Movie movie;
  Schedule schedule;
  List<SeatRows> seatRows;

  SeatModel({this.status, this.msg, this.movie, this.schedule, this.seatRows});

  SeatModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    movie = json['movie'] != null ? new Movie.fromJson(json['movie']) : null;
    schedule = json['schedule'] != null
        ? new Schedule.fromJson(json['schedule'])
        : null;
    if (json['seat_rows'] != null) {
      seatRows = new List<SeatRows>();
      json['seat_rows'].forEach((v) {
        seatRows.add(new SeatRows.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.movie != null) {
      data['movie'] = this.movie.toJson();
    }
    if (this.schedule != null) {
      data['schedule'] = this.schedule.toJson();
    }
    if (this.seatRows != null) {
      data['seat_rows'] = this.seatRows.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Movie {
  String movieId;
  String movieName;

  Movie({this.movieId, this.movieName});

  Movie.fromJson(Map<String, dynamic> json) {
    movieId = json['movie_id'];
    movieName = json['movie_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['movie_id'] = this.movieId;
    data['movie_name'] = this.movieName;
    return data;
  }
}

class Schedule {
  String scheduleId;
  String scheduleDate;
  String scheduleStart;
  String scheduleEnd;

  Schedule(
      {this.scheduleId,
      this.scheduleDate,
      this.scheduleStart,
      this.scheduleEnd});

  Schedule.fromJson(Map<String, dynamic> json) {
    scheduleId = json['schedule_id'];
    scheduleDate = json['schedule_date'];
    scheduleStart = json['schedule_start'];
    scheduleEnd = json['schedule_end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['schedule_id'] = this.scheduleId;
    data['schedule_date'] = this.scheduleDate;
    data['schedule_start'] = this.scheduleStart;
    data['schedule_end'] = this.scheduleEnd;
    return data;
  }
}

class SeatRows {
  String row;
  List<Seats> seats;

  SeatRows({this.row, this.seats});

  SeatRows.fromJson(Map<String, dynamic> json) {
    row = json['row'];
    if (json['seats'] != null) {
      seats = new List<Seats>();
      json['seats'].forEach((v) {
        seats.add(new Seats.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['row'] = this.row;
    if (this.seats != null) {
      data['seats'] = this.seats.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Seats {
  String seatId;
  int seatType;
  int number;
  bool seatStatus;
  int price;

  Seats({this.seatId, this.seatType, this.number, this.seatStatus, this.price});

  Seats.fromJson(Map<String, dynamic> json) {
    seatId = json['seat_id'];
    seatType = json['seat_type'];
    number = json['number'];
    seatStatus = json['seat_status'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['seat_id'] = this.seatId;
    data['seat_type'] = this.seatType;
    data['number'] = this.number;
    data['seat_status'] = this.seatStatus;
    data['price'] = this.price;
    return data;
  }
}
