import 'package:dio/dio.dart';

class ErrorHandler{
  static handleError(Error error){
    if (error is DioError){
      return "Failed to load data from logs.tf";
    } else {
      return "Unknown error";
    }
  }
}