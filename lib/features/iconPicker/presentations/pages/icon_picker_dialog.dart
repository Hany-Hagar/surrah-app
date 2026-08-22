import 'package:flutter/material.dart';
import '../manger/icon_picker_cubit.dart';
import '../manger/icon_picker_states.dart';
import '../../data/models/icon_model.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/services/dialog_service.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import '../../../../core/extensions/color_extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

abstract class IconPicker {
  static Future<({IconModel icon, Color color})> show(
    BuildContext context,
  ) async {
    var result = await DialogService.showCustomDialog(
      context: context,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      body: const IconPickerDialog(),
    );
    return (
      icon: result?["icon"] as IconModel,
      color: result?["color"] as Color,
    );
  }
}

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
              const _Title(),
              CustomTextFormField(
                hintText: 'Search',
                suffixIcon: Icons.clear,
                prefixIcon: IconBroken.Search,
                backgroundColor: Colors.transparent,
                onChanged: (value) => cubit.searchIcon(value ?? ''),
              ),
              _List(icons: cubit.searchedIcons),
              _Color(color: cubit.selectedColor),
            ],
          );
        },
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    var cubit = IconPickerCubit.get(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(text: '🎯 Icon Picker', size: 20.sp, type: Type.header),
        GestureDetector(
          onTap: () => colorPickerDialog(context, cubit.selectedColor)?.call(),
          child: Icon(
            Icons.color_lens_outlined,
            size: 24.sp,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
      ],
    );
  }
}

class _List extends StatelessWidget {
  final List<IconModel> icons;
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
        Icon(IconBroken.Search, size: 50.sp, color: Colors.grey),
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
  final IconModel icon;
  const _Icon({required this.icon});

  @override
  Widget build(BuildContext context) {
    var cubit = IconPickerCubit.get(context);
    var color = cubit.selectedColor;
    return IconButton(
      onPressed: () =>
          Navigator.of(context).pop({"icon": icon, "color": color}),
      icon: FaIcon(icon.icon, size: 24.sp, color: color),
    );
  }
}

class _Color extends StatelessWidget {
  final Color color;
  const _Color({required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => colorPickerDialog(context, color)?.call(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: Theme.of(context).dividerColor,
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Row(
          spacing: 8.w,
          children: [
            CircleAvatar(backgroundColor: color, radius: 10.r),
            Expanded(
              child: CustomText(
                text: color.colorName,
                size: 16.sp,
                height: 1.2,
                type: Type.header,
                opacity: FontOpacity.medium,
              ),
            ),
            CustomText(
              text: color.hexCode,
              size: 14.sp,
              type: Type.header,
              opacity: FontOpacity.medium,
            ),
          ],
        ),
      ),
    );
  }
}

Function()? colorPickerDialog(BuildContext context, Color color) {
  return () {
    ColorPicker(
      color: color,
      borderRadius: 4.r,
      onColorChanged: (Color color) {
        IconPickerCubit.get(context).selectColor(color);
        Navigator.of(context).pop();
      },
      heading: CustomText(text: 'Pick a color', size: 18.sp, type: Type.header),
      subheading: CustomText(
        text: 'Select color shade',
        size: 16.sp,
        type: Type.header,
      ),
    ).showPickerDialog(
      context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
    );
  };
}
