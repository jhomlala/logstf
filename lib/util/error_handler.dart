import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logstf/util/application_localization.dart';

class ErrorHandler{
  static handleError(Object error, BuildContext context){
    var applicationLocalization = ApplicationLocalization.of(context);
    if (error is DioError){
      return applicationLocalization.getText("logs_failed_to_load_logs");
    } else {
      return applicationLocalization.getText("unknown_error");
    }
  }
}