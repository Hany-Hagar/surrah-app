import 'package:flutter/material.dart';
import '../widgets/categories_body.dart';
import '../../../../../generated/l10n.dart';
import '../../manager/categories_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surrah/core/di/server_locator.dart';
import '../../../../../core/widgets/custom_app_bar.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    var s = S.of(context);
    return BlocProvider.value(
      value: getIt<CategoriesCubit>()..getCategories(),
      child: Scaffold(
        appBar: CustomAppBar(
          title: s.categoriesTitle,
          subtitle: s.categoriesSubtitle,
        ),
        body: const CategoriesBody(),
      ),
    );
  }
}


