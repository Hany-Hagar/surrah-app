

abstract class ReportStates {}

class ReportInitial extends ReportStates {}

// Fetching report States

class FetchReportLoading extends ReportStates {}

class FetchReportSuccess extends ReportStates {}

class FetchReportFailure extends ReportStates {
  final String errorMessage;
  FetchReportFailure({required this.errorMessage});
}
