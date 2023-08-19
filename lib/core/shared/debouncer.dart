import 'dart:async';

class Debouncer {
  final int milliseconds;
  Timer? _timer;
  Debouncer({this.milliseconds = 1000});
  run(void Function() callBack) {
    cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), callBack);
  }

  cancel() {
    _timer?.cancel();
  }
}
