

abstract class ReportStates {}

class ReportInitial extends ReportStates {}

// Fetching report States

class FetchReportLoading extends ReportStates {}

class FetchReportSuccess extends ReportStates {}

class FetchReportFailure extends ReportStates {
  final String errorMessage;
  FetchReportFailure({required this.errorMessage});
}

// Downloading report States

class DownloadReportLoading extends ReportStates {}

class DownloadReportSuccess extends ReportStates {}

class DownloadReportFailure extends ReportStates {
  final String errorMessage;
  DownloadReportFailure({required this.errorMessage});
}

// Sharing report States

class ShareReportLoading extends ReportStates {}

class ShareReportSuccess extends ReportStates {}

class ShareReportFailure extends ReportStates {
  final String errorMessage;
  ShareReportFailure({required this.errorMessage});
}
