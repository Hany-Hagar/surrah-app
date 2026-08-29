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