class MovieModel {
  String status;
  String msg;
  List<Movies> movies;

  MovieModel({this.status, this.msg, this.movies});

  MovieModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['movies'] != null) {
      movies = new List<Movies>();
      json['movies'].forEach((v) {
        movies.add(new Movies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.movies != null) {
      data['movies'] = this.movies.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Movies {
  String movieId;
  String movieName;
  String movieDescription;
  String movieCens;
  String movieGenres;
  String movieRelease;
  String movieLenght;
  String movieFormat;
  String moviePoster;

  Movies(
      {this.movieId,
      this.movieName,
      this.movieDescription,
      this.movieCens,
      this.movieGenres,
      this.movieRelease,
      this.movieLenght,
      this.movieFormat,
      this.moviePoster});

  Movies.fromJson(Map<String, dynamic> json) {
    movieId = json['movie_id'];
    movieName = json['movie_name'];
    movieDescription = json['movie_description'];
    movieCens = json['movie_cens'];
    movieGenres = json['movie_genres'];
    movieRelease = json['movie_release'];
    movieLenght = json['movie_lenght'];
    movieFormat = json['movie_format'];
    moviePoster = json['movie_poster'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['movie_id'] = this.movieId;
    data['movie_name'] = this.movieName;
    data['movie_description'] = this.movieDescription;
    data['movie_cens'] = this.movieCens;
    data['movie_genres'] = this.movieGenres;
    data['movie_release'] = this.movieRelease;
    data['movie_lenght'] = this.movieLenght;
    data['movie_format'] = this.movieFormat;
    data['movie_poster'] = this.moviePoster;
    return data;
  }
}
