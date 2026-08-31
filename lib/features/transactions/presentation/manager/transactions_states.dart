abstract class TransactionsStates {}

class TransactionsInitial extends TransactionsStates {}

// Get Transactions
class GetTransactionsLoading extends TransactionsStates {}

class GetTransactionsSuccess extends TransactionsStates {}

class GetTransactionsFailure extends TransactionsStates {
  final String message;
  GetTransactionsFailure({required this.message});
}

// Search Transactions
class SearchTransactionsState extends TransactionsStates {}

// Add Transaction
class AddTransactionInitial extends TransactionsStates {}

class AutoValidateModeChanged extends TransactionsStates {}

class UpdateSelectedCategory extends TransactionsStates {}

class UpdateSelectedDate extends TransactionsStates {}

class AddTransactionLoading extends TransactionsStates {}

class AddTransactionSuccess extends TransactionsStates {}

class AddTransactionFailure extends TransactionsStates {
  final String message;
  AddTransactionFailure({required this.message});
}

// Update Transaction
class UpdateTransactionLoading extends TransactionsStates {}

class UpdateTransactionSuccess extends TransactionsStates {}

class UpdateTransactionFailure extends TransactionsStates {
  final String message;
  UpdateTransactionFailure({required this.message});
}
