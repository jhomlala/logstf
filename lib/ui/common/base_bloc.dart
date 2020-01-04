import 'dart:async';

abstract class BaseBloc {
  final List<StreamSubscription> subscriptions = List();

  void addSubscription(StreamSubscription streamSubscription){
    subscriptions.add(streamSubscription);
  }

  void dispose(){
    subscriptions.forEach((subscription) => subscription.cancel());
    subscriptions.clear();
  }
}
