import 'package:cgv_clone/string/TabType.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class TabEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class TabStarted extends TabEvent {
  final TabType tabType;
  TabStarted({@required this.tabType});
}

class TabExited extends TabEvent {
  final TabType tabType;
  TabExited({@required this.tabType});
}
