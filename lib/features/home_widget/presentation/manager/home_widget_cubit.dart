import 'home_widget_states.dart';
import 'package:flutter/material.dart';
import '../../data/repo/home_widget_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/model/home_widget_model.dart';

class HomeWidgetCubit extends Cubit<HomeWidgetStates> {
  final HomeWidgetRepo homeWidgetRepo;
  HomeWidgetCubit({required this.homeWidgetRepo})
    : super(HomeWidgetInitialState());

  static HomeWidgetCubit get(BuildContext context) => BlocProvider.of(context);

  // Data
  HomeWidgetModel homeWidgetData = HomeWidgetModel.defaultModel();

  // Methods
  void fetchData() {
    emit(GetDataLoading());
    final result = homeWidgetRepo.getHomeWidgetData();
    homeWidgetData = result;
    emit(GetDataSuccess());
  }

  void updateData() async {
    emit(UpdateDataLoading());
    final result = await homeWidgetRepo.saveHomeWidgetData(homeWidgetData);
    result.fold((failure) => emit(UpdateDataFailure(failure.message)), (data) {
      emit(UpdateDataSuccess());
    });
  }

  void toggleEnableWidget() {
    homeWidgetData = homeWidgetData.copyWith(
      enableCard: !homeWidgetData.enableCard,
    );
    updateData();
  }

  void toggleShowBalanceCard() {
    homeWidgetData = homeWidgetData.copyWith(
      showBalance: !homeWidgetData.showBalance,
    );
    updateData();
  }

  void toggleShowIncomeButton() {
    homeWidgetData = homeWidgetData.copyWith(
      showIncomeButton: !homeWidgetData.showIncomeButton,
    );
    updateData();
  }

  void toggleShowExpenseButton() {
    homeWidgetData = homeWidgetData.copyWith(
      showExpenseButton: !homeWidgetData.showExpenseButton,
    );
    updateData();
  }

  void toggleShowAddCategoryButton() {
    homeWidgetData = homeWidgetData.copyWith(
      showAddCategoryButton: !homeWidgetData.showAddCategoryButton,
    );
    updateData();
  }
}
