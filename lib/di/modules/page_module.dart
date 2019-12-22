import 'package:inject/inject.dart';

@module
class PageModule{
  @provide
  String test(){
    return "";
  }
}