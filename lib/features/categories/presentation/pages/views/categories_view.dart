import 'package:flutter/material.dart';
import '../widgets/categories_body.dart';
import '../widgets/categories_filter.dart';
import '../../../../../generated/l10n.dart';
import '../../manager/categories_cubit.dart';
import '../../manager/categories_states.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surrah/core/di/server_locator.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/services/snack_bar_service.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<CategoriesCubit>()..getCategories(),
      child: BlocListener<CategoriesCubit, CategoriesStates>(
        listener: (context, state) {
          if (state is AddCategorySuccess) {
            Navigator.pop(context);
            SnackBarService.success(
              context: context,
              message: S.of(context).addNewCategorySuccess,
            );
          }
          if (state is AddCategoryFailure) {
            SnackBarService.failure(
              context: context,
              message: state.errorMessage,
            );
          }
        },
        child: _Body(),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    var s = S.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        bottomHeight: 60,
        bottom: const _Search(),
        title: s.categoriesTitle,
        subtitle: s.categoriesSubtitle,
        trailingIcon: IconBroken.Filter,
        onTrailingPressed: () => showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
          ),
          builder: (context) => const CategoriesFilter(),
        ),
      ),
      body: const CategoriesBody(),
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
