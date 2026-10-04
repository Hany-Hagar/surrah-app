import '../../report/presentation/manager/report_cubit.dart';
import 'layout_states.dart';
import 'package:flutter/material.dart';
import '../../../core/di/server_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../categories/presentation/manager/categories_cubit.dart';
import '../../transactions/presentation/manager/transactions_cubit.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(LayoutInitial());
  static LayoutCubit get(BuildContext context) => BlocProvider.of(context);

  int currentIndex = 0;
  var pageController = PageController(initialPage: 0);

  void changeBottomNavBarIndex(int index) {
    if (index == currentIndex) return;
    currentIndex = index;
    if (index == 1) getIt<CategoriesCubit>().initialView();
    if (index == 2) getIt<TransactionsCubit>().initialView();
    if (index == 3) getIt<ReportCubit>().refresh(); 
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    emit(ChangeBottomNavBarIndex());
  }

  void updateCurrentIndex(int index) {
    if (index == currentIndex) return;
    currentIndex = index;
    if (index == 3) getIt<ReportCubit>().refresh();
    emit(ChangeBottomNavBarIndex());
  }
}
