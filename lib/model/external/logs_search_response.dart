import '../internal/log_short.dart';
import 'logs_search_parameters.dart';

class LogsSearchResponse {
  bool success;
  int results;
  int total;
  LogsSearchParameters parameters;
  List<LogShort> logs;

  LogsSearchResponse({
    this.success,
    this.results,
    this.total,
    this.parameters,
    this.logs,
  });

  factory LogsSearchResponse.fromJson(Map<String, dynamic> json) => new LogsSearchResponse(
    success: json["success"],
    results: json["results"],
    total: json["total"],
    parameters: LogsSearchParameters.fromJson(json["parameters"]),
    logs: new List<LogShort>.from(json["logs"].map((x) => LogShort.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "results": results,
    "total": total,
    "parameters": parameters.toJson(),
    "logs": new List<dynamic>.from(logs.map((x) => x.toJson())),
  };
}