import 'home_widget_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeWidgetCubit extends Cubit<HomeWidgetStates> {
  HomeWidgetCubit() : super(HomeWidgetInitialState());

  static HomeWidgetCubit get(BuildContext context) => BlocProvider.of(context);

  // Data
  bool enableWidget = false;
  double currentBalance = 0.0;
  bool showBalanceCard = false;
  bool showIncomeButton = false;
  bool showExpenseButton = false;
  bool showAddCategoryButton = false;

  void toggleEnableWidget() {
    enableWidget = !enableWidget;
    emit(UpdateHomeWidgetSetup());
  }

  void toggleShowBalanceCard() {
    showBalanceCard = !showBalanceCard;
    emit(UpdateHomeWidgetSetup());
  }

  void toggleShowIncomeButton() {
    showIncomeButton = !showIncomeButton;
    emit(UpdateHomeWidgetSetup());
  }

  void toggleShowExpenseButton() {
    showExpenseButton = !showExpenseButton;
    emit(UpdateHomeWidgetSetup());
  }

  void toggleShowAddCategoryButton() {
    showAddCategoryButton = !showAddCategoryButton;
    emit(UpdateHomeWidgetSetup());
  }
}
