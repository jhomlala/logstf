import 'log_searched.dart';
import 'logs_search_parameters.dart';

class LogsSearchResponse {
  bool success;
  int results;
  int total;
  LogsSearchParameters parameters;
  List<LogSearched> logs;

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
    logs: new List<LogSearched>.from(json["logs"].map((x) => LogSearched.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "results": results,
    "total": total,
    "parameters": parameters.toJson(),
    "logs": new List<dynamic>.from(logs.map((x) => x.toJson())),
  };
}