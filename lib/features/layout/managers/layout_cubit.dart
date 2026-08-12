import 'layout_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(LayoutInitial());
  static LayoutCubit get(BuildContext context) => BlocProvider.of(context);

  int currentIndex = 0;
  var pageController = PageController(initialPage: 0);

  void changeBottomNavBarIndex(int index) {
    currentIndex = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    emit(ChangeBottomNavBarIndex());
  }
}
