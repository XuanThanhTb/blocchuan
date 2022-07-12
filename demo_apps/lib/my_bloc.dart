import 'dart:async';

class MyBloc {
  int counter = 0;

  //dạng này là dạng single-subcription stream/lắng nghe 1 chỗ đc thôi/
  // StreamController _streamController = StreamController<int>;
  // Stream get counterStream => _streamController.stream
  //dạng này là dạng broadcast stream, lắng nghe nhiều chỗ.
  StreamController _streamController = StreamController<int>.broadcast();
  Stream get counterStream =>
      _streamController.stream.transform(_counterTransformer);

  var _counterTransformer =
      StreamTransformer<int, int>.fromHandlers(handleData: (data, sink) {
    data += 10;
    sink.add(data);
  });
  void increment() {
    counter += 1;
    _streamController.sink.add(counter);
  }

  void dispose() {
    _streamController.close();
  }
}
