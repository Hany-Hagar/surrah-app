import 'package:flutter/material.dart';
import '../../data/database/icons.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IconPickerDialog extends StatelessWidget {
  const IconPickerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10.h,
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomTextFormField(
          hintText: 'Search',
          suffixIcon: Icons.clear,
          prefixIcon: IconBroken.Search,
          backgroundColor: Colors.transparent ,
          onChanged: (value) {
            // Implement search functionality here
          },
        ),
        _List(),
      ],
    );
  }
}

class _List extends StatelessWidget {
  const _List();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.7,
      child: GridView.builder(
        padding: EdgeInsets.zero,
        itemCount: iconsData.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
        ),
        itemBuilder: (context, index) => _Icon(icon: iconsData[index].icon),
      ),
    );
  }
}

class _Icon extends StatelessWidget {
  final FaIconData icon;
  const _Icon({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Center(child: FaIcon(icon, size: 24.sp));
  }
}
