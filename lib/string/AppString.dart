import 'package:intl/intl.dart';

class AppString {
  static final String thanhtoan = 'Thanh toán';
  static final String point = 'Point';
  static final String ghe = 'ghế';
  static final String vnd = 'VND';
  static final String sodu = 'Số dư';
  static final String manhinh = 'Màn hình';
  static final String chongoi = 'Chỗ ngồi';
  static final String saitaikhoan = 'Tài khoản không tồn tại';
  static final String loiluutoken = 'Không thể lưu token';
  static final String loiconnect = 'Lỗi kết nối';
  static final String phone = 'Số điện thoại';
  static final String email = 'Email';
  static final String male = 'Nam';
  static final String female = 'Nữ';
  static final String movieDetail = 'Chi tiết phim';
  static final String userInfo = 'Thông tin cá nhân';
  static final String logout = 'Đăng xuất';
  static final String khongdusodu = 'Không đủ số dư để thanh toán';
  static final String xacnhanthanhtoan = 'Xác nhận thanh toán';
  static final String someWrong = 'Có lỗi xảy ra';

  static String muave(
    String tien,
    int soluong,
  ) =>
      'Bạn sẽ thanh toán $tien ' +
      AppString.vnd +
      ' cho $soluong vé xem phim tại VGV';
  static final String huy = 'Huỷ';
  static final String thanhtoanthanhcong = 'Thanh toán thành công';
  static final String vuilongdoi = 'Đợi xíu';
  static final String hintUsername = 'Tên đăng nhập';
  static final String hintPassword = 'Mật khẩu';
  static final String rePassword = 'Nhập lại mật khẩu';
  static final String hintForgotPassword = 'Quên mật khẩu';
  static final String loginStringValue = 'Đăng nhập';
  static final String registerStringValue = 'Đăng ký';
  static final String hintDate = 'DD/MM/YYYY';
  static final String cmt = 'Số CMT';
  static final String bookButtonValue = 'Đặt vé';
  static final String showing = 'Đang chiếu';
  static final String comming = 'Sắp chiếu';
  static final String special = 'Đặc biệt';

  static final formatCurrency = new NumberFormat('#,##0', 'en_US');
}
