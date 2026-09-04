sealed class ReportStates {}

final class ReportInitial extends ReportStates {}

class ReportLoading extends ReportStates {}

class ReportSuccess extends ReportStates {}

class ChangeCategoryType extends ReportStates {}

class FilterTransactionsLoading extends ReportStates {}

class FilterTransactionsSuccess extends ReportStates {}

class FilterTransactionsFailure extends ReportStates {
  final String message;
  FilterTransactionsFailure({required this.message});
}
