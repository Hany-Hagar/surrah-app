import '../widgets/home_body.dart';
import 'package:flutter/material.dart';
import '../../../../../const/assets.dart';
import '../../../../../generated/l10n.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:surrah/core/utils/nav_to.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../settings/presentation/pages/views/settings_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var s = S.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: s.homeTitle,
        subtitle: s.homeSubtitle,
        leading: const _Leading(),
        trailingIcon: IconBroken.Setting,
        onTrailingPressed: () =>
            NavTo.push(context: context, nextPage: const SettingsView()),
      ),
      body: Padding(padding: EdgeInsets.all(12.w), child: HomeBody()),
    );
  }
}

class _Leading extends StatelessWidget {
  const _Leading();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45.w,
      height: 50.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.r),
        image: const DecorationImage(
          image: AssetImage(Assets.appLogo),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
