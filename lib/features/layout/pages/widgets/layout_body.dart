import 'package:flutter/material.dart';
import '../../managers/layout_cubit.dart';
import '../../managers/layout_states.dart';
import '../../../home/views/home_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../categories/presentation/pages/views/categories_view.dart';
import '../../../transactions/presentation/pages/views/transactions_view.dart';

class LayoutBody extends StatelessWidget {
  const LayoutBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutCubit, LayoutStates>(
      builder: (context, state) {
        var cubit = LayoutCubit.get(context);
        return PageView(
          controller: cubit.pageController,
          onPageChanged: (value) => cubit.updateCurrentIndex(value),
          children: [
            HomeView(),
            CategoriesView(),
            TransactionsView(),
          ],
        );
      },
    );
  }
}
