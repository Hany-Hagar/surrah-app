import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import '../../../../../const/assets.dart';
import '../../../../../generated/l10n.dart';
import '../../manager/categories_cubit.dart';
import '../../manager/categories_states.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/enums/category_type.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../core/widgets/custom_toggle.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../iconPicker/data/models/icon_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/extensions/color_extension.dart';
import '../../../../../core/widgets/custom_category_icon.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../../core/extensions/categories_type_extensions.dart';

class AddCategory extends StatelessWidget {
  const AddCategory({super.key});
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    var media = MediaQuery.sizeOf(context);
    return BlocBuilder<CategoriesCubit, CategoriesStates>(
      builder: (context, state) => Form(
        autovalidateMode: CategoriesCubit.get(context).autoValidateMode,
        key: formKey,
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: media.width / 14),
                _Title(),
                SizedBox(height: 10.h),
                _Type(),
                _Body(),
                SizedBox(height: 12.h),
                _Button(
                  formKey: formKey,
                  isLoading: state is AddCategoryLoading,
                ),
              ],
            ),
            _Image(),
          ],
        ),
      ),
    );
  }
}

class _Image extends StatelessWidget {
  const _Image();

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Transform.translate(
      offset: Offset(0, -(media.width / 5)),
      child: Lottie.asset(
        Assets.categoryLogo,
        width: media.width / 3.5,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    var s = S.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: double.infinity),
        CustomText(
          text: s.addCategoryDialogTitle,
          size: 20.sp,
          type: Type.overMedium,
        ),
        CustomText(
          text: s.addCategoryDialogDescription,
          size: 14.sp,
          height: 1.2,
          maxLines: 2,
          type: Type.header,
          textAlign: TextAlign.center,
          opacity: FontOpacity.medium,
        ),
      ],
    );
  }
}

class _Type extends StatelessWidget {
  const _Type();

  @override
  Widget build(BuildContext context) {
    var cubit = CategoriesCubit.get(context);
    return CustomToggle<CategoriesType>(
      height: 60.h,
      selectedItem: cubit.selectedCategoryType,
      items: [CategoriesType.income, CategoriesType.expense],
      itemLabel: (item) => item.toLocalization(context: context),
      onChanged: (value) => cubit.changeSelectedCategoryType(type: value),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    var cubit = CategoriesCubit.get(context);
    return Column(
      spacing: 5.h,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Name(),
        _Data(icon: cubit.selectedIcon, color: cubit.selectedColor),
      ],
    );
  }
}

class _Name extends StatelessWidget {
  const _Name();

  @override
  Widget build(BuildContext context) {
    var s = S.of(context);

    return Column(
      spacing: 4.h,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: s.categoryName, size: 18.sp, type: Type.overMedium),
        CustomTextFormField(
          hintText: s.categoryNameHint,
          prefixIcon: IconBroken.Category,
          keyboardType: TextInputType.name,
          controller: CategoriesCubit.get(context).nameController,
        ),
      ],
    );
  }
}

class _Data extends StatelessWidget {
  final Color color;
  final IconModel icon;
  const _Data({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    var s = S.of(context);

    return Column(
      spacing: 4.h,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: s.categoryIconData,
          size: 18.sp,
          type: Type.overMedium,
        ),
        _DataItem(icon: icon, color: color),
      ],
    );
  }
}

class _DataItem extends StatelessWidget {
  final Color color;
  final IconModel icon;
  const _DataItem({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    var s = S.of(context);
    var theme = Theme.of(context);
    var cubit = CategoriesCubit.get(context);
    var isArabic = Localizations.localeOf(context).languageCode == 'ar';
    return ListTile(
      minTileHeight: 46.h,
      minVerticalPadding: 0,
      horizontalTitleGap: 9.w,
      tileColor: theme.scaffoldBackgroundColor,
      trailing: Icon(Icons.touch_app_rounded, size: 24.sp),
      leading: CustomCategoryIcon(icon: icon, color: color),
      title: CustomText(
        size: 17.sp,
        height: 1.2,
        type: Type.header,
        text: s.categoryIconDataHint,
      ),
      subtitle: CustomText(
        text: "${s.color}: ${color.hexCode}",
        size: isArabic ? 15.sp : 17.sp,
        height: 1.2,
        type: Type.header,
        opacity: FontOpacity.medium,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 7.h),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.black45, width: 1.4),
        borderRadius: BorderRadius.circular(4.r),
      ),
      onTap: () => cubit.changeSelectedIconData(context: context),
    );
  }
}

class _Button extends StatelessWidget {
  final bool isLoading;
  final GlobalKey<FormState> formKey;
  const _Button({required this.isLoading, required this.formKey});

  @override
  Widget build(BuildContext context) {
    var s = S.of(context);
    var cubit = CategoriesCubit.get(context);
    return Row(
      spacing: 12.w,
      children: [
        Expanded(
          flex: 3,
          child: CustomButton(
            height: 50.h,
            text: s.addCategory,
            isLoading: isLoading,
            onPressed: () => cubit.addCategory(formKey: formKey),
          ),
        ),
        Expanded(
          flex: 2,
          child: CustomButton(
            height: 50.h,
            text: s.cancel,
            enableBorderColor: true,
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ],
    );
  }
}
