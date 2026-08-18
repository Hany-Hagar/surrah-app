import 'package:flutter/material.dart';
import '../manger/icon_picker_cubit.dart';
import '../manger/icon_picker_states.dart';
import 'package:icon_broken/icon_broken.dart';
import '../../data/models/app_icon_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IconPickerDialog extends StatelessWidget {
  const IconPickerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => IconPickerCubit(),
      child: BlocBuilder<IconPickerCubit, IconPickerStates>(
        builder: (context, state) {
          var cubit = IconPickerCubit.get(context);
          return Column(
            spacing: 10.h,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextFormField(
                hintText: 'Search',
                suffixIcon: Icons.clear,
                prefixIcon: IconBroken.Search,
                backgroundColor: Colors.transparent,
                onChanged: (value) => cubit.searchIcon(value ?? ''),
              ),
              _List(icons: cubit.searchedIcons),
            ],
          );
        },
      ),
    );
  }
}

class _List extends StatelessWidget {
  final List<AppIcon> icons;
  const _List({required this.icons});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.6,
      child: icons.isEmpty
          ? const _EmptySearch()
          : GridView.builder(
              padding: EdgeInsets.zero,
              itemCount: icons.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
              ),
              itemBuilder: (context, index) => _Icon(icon: icons[index]),
            ),
    );
  }
}

class _EmptySearch extends StatelessWidget {
  const _EmptySearch();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          IconBroken.Search,
          size: 50.sp,
          color: Colors.grey,
        ),
        SizedBox(height: 20.h),
        CustomText(
          text: 'No icons found',
          size: 16.sp,
          opacity: FontOpacity.high,
        ),
      ],
    );
  }
}

class _Icon extends StatelessWidget {
  final AppIcon icon;
  const _Icon({required this.icon});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.of(context).pop(icon),
      icon: FaIcon(icon.icon, size: 24.sp),
    );
  }
}
