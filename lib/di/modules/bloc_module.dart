import 'package:inject/inject.dart';

@module
class BlocModule{
  @provide
  String test(){
    return "";
  }
}