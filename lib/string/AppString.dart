import 'package:intl/intl.dart';

class AppString {
  static final String pay = 'Thanh toán';
  static final String point = 'Point';
  static final String movieChair = 'ghế';
  static final String vnd = 'VND';
  static final String walletMoney = 'Số dư';
  static final String bigScreen = 'Màn hình';
  static final String cost = 'Chỗ ngồi';
  static final String accountNotExist = 'Tài khoản không tồn tại';
  static final String saveTokenError = 'Không thể lưu token';
  static final String connectError = 'Lỗi kết nối';
  static final String phone = 'Số điện thoại';
  static final String email = 'Email';
  static final String male = 'Nam';
  static final String female = 'Nữ';
  static final String movieDetail = 'Chi tiết phim';
  static final String userInfo = 'Thông tin cá nhân';
  static final String logout = 'Đăng xuất';
  static final String notEnoughMoney = 'Không đủ số dư để thanh toán';
  static final String payConfirm = 'Xác nhận thanh toán';
  static final String someWrong = 'Có lỗi xảy ra';
  static final String pleaseFitForm = 'Vui lòng điền đầy đủ';
  static final String passwordIsNotMatch = 'Mật khẩu không khớp';

  static String dialogTicket(
    String payMoney,
    int ticketLength,
  ) =>
      'Bạn sẽ thanh toán $payMoney ' +
      AppString.vnd +
      ' cho $ticketLength vé xem phim tại VGV';
  static final String cancel = 'Huỷ';
  static final String paySuccess = 'Thanh toán thành công';
  static final String pleaseWait = 'Đợi xíu';
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
