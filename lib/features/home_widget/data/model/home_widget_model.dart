class HomeWidgetModel {
  final bool isSecure;
  final double balance;
  final bool enableHomeWidget;
  final bool showIncomeButton;
  final bool showExpenseButton;
  final bool showAddCategoryButton;

  HomeWidgetModel({
    this.balance = 0.0,
    required this.isSecure,
    required this.enableHomeWidget,
    required this.showIncomeButton,
    required this.showExpenseButton,
    required this.showAddCategoryButton,
  });

  HomeWidgetModel copyWith({
    bool? isSecure,
    double? balance,
    bool? enableHomeWidget,
    bool? showIncomeButton,
    bool? showExpenseButton,
    bool? showAddCategoryButton,
  }) {
    return HomeWidgetModel(
      isSecure: isSecure ?? this.isSecure,
      balance: balance ?? this.balance,
      enableHomeWidget: enableHomeWidget ?? this.enableHomeWidget,
      showIncomeButton: showIncomeButton ?? this.showIncomeButton,
      showExpenseButton: showExpenseButton ?? this.showExpenseButton,
      showAddCategoryButton:
          showAddCategoryButton ?? this.showAddCategoryButton,
    );
  }
}
