import 'dart:async';
import 'dart:math';

StreamController stream = StreamController.broadcast();

main() async {
  var alpha = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'k'];

  stream.stream.listen((data) {
    print('hihi ' + data.toString());
  });

  stream.stream.listen((data) {
    print('haha ' + data.toString());
  });
  stream.add(alpha[Random.secure().nextInt(alpha.length - 1)]);

}
