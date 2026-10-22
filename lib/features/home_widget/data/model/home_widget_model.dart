import 'package:hive/hive.dart';

part 'home_widget_model.g.dart';

@HiveType(typeId: 5)
class HomeWidgetModel {
  @HiveField(0)
  final bool showBalance;
  @HiveField(1)
  final double balance;
  @HiveField(2)
  final bool enableCard;
  @HiveField(3)
  final bool showIncomeButton;
  @HiveField(4)
  final bool showExpenseButton;
  @HiveField(5)
  final bool showAddCategoryButton;

  HomeWidgetModel({
    this.balance = 0.0,
    required this.showBalance,
    required this.enableCard,
    required this.showIncomeButton,
    required this.showExpenseButton,
    required this.showAddCategoryButton,
  });

  // Static
  static HomeWidgetModel defaultModel() {
    return HomeWidgetModel(
      balance: 0.0,
      showBalance: true,
      showIncomeButton: true,
      enableCard: false,
      showExpenseButton: true,
      showAddCategoryButton: true,
    );
  }

  // Copy with
  HomeWidgetModel copyWith({
    bool? showBalance,
    double? balance,
    bool? enableCard,
    bool? showIncomeButton,
    bool? showExpenseButton,
    bool? showAddCategoryButton,
  }) {
    return HomeWidgetModel(
      showBalance: showBalance ?? this.showBalance,
      balance: balance ?? this.balance,
      enableCard: enableCard ?? this.enableCard,
      showIncomeButton: showIncomeButton ?? this.showIncomeButton,
      showExpenseButton: showExpenseButton ?? this.showExpenseButton,
      showAddCategoryButton:
          showAddCategoryButton ?? this.showAddCategoryButton,
    );
  }
}
