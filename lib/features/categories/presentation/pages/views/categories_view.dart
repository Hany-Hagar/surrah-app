import 'package:flutter/material.dart';
import '../../manager/categories_states.dart';
import '../widgets/categories_body.dart';
import '../../../../../generated/l10n.dart';
import '../../manager/categories_cubit.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surrah/core/di/server_locator.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    var s = S.of(context);
    return BlocProvider.value(
      value: getIt<CategoriesCubit>()..getCategories(),
      child: Scaffold(
        appBar: CustomAppBar(
          bottomHeight: 60,
          bottom: const _Search(),
          title: s.categoriesTitle,
          subtitle: s.categoriesSubtitle,
        ),
        body: const CategoriesBody(),
      ),
    );
  }
}

class _Search extends StatelessWidget {
  const _Search();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesStates>(
      builder: (context, state) {
        var cubit = CategoriesCubit.get(context);
        return CustomTextFormField(
          prefixIcon: IconBroken.Search,
          controller: cubit.searchController,
          hintText: S.of(context).searchCategoriesHint,
          suffixIcon: cubit.isSearching ? Icons.clear : null,
          suffixTap: () => cubit.searchCategories(query: null),
          onChanged: (value) => cubit.searchCategories(query: value),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        );
      },
    );
  }
}
