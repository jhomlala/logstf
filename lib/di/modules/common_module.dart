import 'package:inject/inject.dart';

@module
class CommonModule {
  @provide
  String test(){
    return "";
  }
}
