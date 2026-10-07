
class ReportTransactionModel {
  final String id;
  final String title;
  final int color;
  final double amount;
  ReportTransactionModel({
    required this.id,
    required this.title,
    required this.color,
    required this.amount,
  });

  // Empty 
  ReportTransactionModel.empty()
      : id = '',
        title = '',
        color = 0,
        amount = 0.0;

  // Copy with
  ReportTransactionModel copyWith({
    String? id,
    String? title,
    int? color,
    double? amount,
  }) {
    return ReportTransactionModel(
      id: id ?? this.id,
      title: title ?? this.title,
      color: color ?? this.color,
      amount: amount ?? this.amount,
    );
  }
}
