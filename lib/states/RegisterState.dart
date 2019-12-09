import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class RegisterState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterFailure extends RegisterState {
  final String msg;

  RegisterFailure({@required this.msg});
}
