import '../di/server_locator.dart';
import 'package:flutter/material.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../features/settings/presentation/manager/settings_cubit.dart';

class CustomBack extends StatelessWidget {
  const CustomBack({super.key});

  @override
  Widget build(BuildContext context) {
    var isRtl = getIt<SettingsCubit>().state.lang == 'ar';
    var icon = isRtl ? IconBroken.Arrow___Right_2 : IconBroken.Arrow___Left_2;
    return FloatingActionButton.small(
      onPressed: () => Navigator.pop(context),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      child: Icon(icon, size: 28.sp),
    );
  }
}
