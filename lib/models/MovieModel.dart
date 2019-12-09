class MovieModel {
  String status;
  String msg;
  List<Data> data;

  MovieModel({this.status, this.msg, this.data});

  MovieModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int movieId;
  String movieName;
  String movieDesc;
  String movieTrailer;
  String movieCens;
  String movieGenr;
  String movieRele;
  String movieLeng;
  String movieForm;
  String moviePoster;

  Data(
      {this.movieId,
      this.movieName,
      this.movieDesc,
      this.movieTrailer,
      this.movieCens,
      this.movieGenr,
      this.movieRele,
      this.movieLeng,
      this.movieForm,
      this.moviePoster});

  Data.fromJson(Map<String, dynamic> json) {
    movieId = json['movie_id'];
    movieName = json['movie_name'];
    movieDesc = json['movie_desc'];
    movieTrailer = json['movie_trailer'];
    movieCens = json['movie_cens'];
    movieGenr = json['movie_genr'];
    movieRele = json['movie_rele'];
    movieLeng = json['movie_leng'];
    movieForm = json['movie_form'];
    moviePoster = json['movie_poster'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['movie_id'] = this.movieId;
    data['movie_name'] = this.movieName;
    data['movie_desc'] = this.movieDesc;
    data['movie_trailer'] = this.movieTrailer;
    data['movie_cens'] = this.movieCens;
    data['movie_genr'] = this.movieGenr;
    data['movie_rele'] = this.movieRele;
    data['movie_leng'] = this.movieLeng;
    data['movie_form'] = this.movieForm;
    data['movie_poster'] = this.moviePoster;
    return data;
  }
}
