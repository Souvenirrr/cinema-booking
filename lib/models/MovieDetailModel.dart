class MovieDetailModel {
  String status;
  String mgs;
  String movieId;
  String movieTrailerYtbId;
  String movieName;
  String movieDescription;
  String movieCens;
  String movieGenres;
  String movieRelease;
  String movieLenght;
  String movieFormat;
  String moviePoster;

  MovieDetailModel(
      {this.status,
      this.mgs,
      this.movieId,
      this.movieTrailerYtbId,
      this.movieName,
      this.movieDescription,
      this.movieCens,
      this.movieGenres,
      this.movieRelease,
      this.movieLenght,
      this.movieFormat,
      this.moviePoster});

  MovieDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    mgs = json['mgs'];
    movieId = json['movie_id'];
    movieTrailerYtbId = json['movie_trailer_ytb_id'];
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
    data['status'] = this.status;
    data['mgs'] = this.mgs;
    data['movie_id'] = this.movieId;
    data['movie_trailer_ytb_id'] = this.movieTrailerYtbId;
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
