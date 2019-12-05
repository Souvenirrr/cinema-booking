class Endpoint {
  static final String movies_list_showing =
      'https://api.myjson.com/bins/10m4hu';
  static final String movies_list_coming = 'https://api.myjson.com/bins/10m4hu';
  static final String movies_list_special =
      'https://api.myjson.com/bins/10m4hu';
  static final String slides = 'https://api.myjson.com/bins/1dshnm';
  static movie_detail(String movieID) => 'https://api.myjson.com/bins/1c4hxm';
  static ytb_img_thumb(String videoID) =>
      'https://img.youtube.com/vi/$videoID/maxresdefault.jpg';
  static schedules_by_movie(String movieID, DateTime dateTime) =>
      'https://api.myjson.com/bins/17r9o6';
  static seats_state(String scheduleID) => 'https://api.myjson.com/bins/c4rmy';
  static String account = 'https://api.myjson.com/bins/bsc3u';
  static String payment(
          String scheduleID, List<String> seatIDs, double point) =>
      'https://api.myjson.com/bins/xt6jm';
}
