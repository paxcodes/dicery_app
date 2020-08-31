import 'package:flutter/cupertino.dart';

typedef StreamListener<T> = void Function(AsyncSnapshot<T> snapshot);

class StreamListenableBuilder<T> extends StreamBuilder<T> {
  final StreamListener<T> afterDoneListener;
  final StreamListener<T> afterDisconnectedListener;

  const StreamListenableBuilder({
    Key key,
    T initialData,
    Stream<T> stream,
    @required this.afterDoneListener,
    @required this.afterDisconnectedListener,
    @required AsyncWidgetBuilder<T> builder,
  }) : super(
            key: key,
            initialData: initialData,
            stream: stream,
            builder: builder);

  @override
  AsyncSnapshot<T> afterDisconnected(AsyncSnapshot<T> current) {
    afterDisconnectedListener(current);
    return super.afterDisconnected(current);
  }

  @override
  AsyncSnapshot<T> afterDone(AsyncSnapshot<T> current) {
    var value = super.afterDone(current);
    afterDoneListener(current);
    return value;
  }
}
