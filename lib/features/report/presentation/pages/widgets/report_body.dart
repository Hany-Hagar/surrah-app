import 'report_overview_body.dart';
import 'package:flutter/material.dart';
import '../../manager/report_cubit.dart';
import '../../../models/report_model.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../core/widgets/balance_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReportBody extends StatelessWidget {
  const ReportBody({super.key});

  @override
  Widget build(BuildContext context) {
    var reportData = ReportCubit.get(context).reportModel;
    return DefaultTabController(
      length: 2,
      child: Column(
        spacing: 12.w,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Balance(reportData: reportData),
          _Tabs(),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                ReportOverviewBody(data: reportData),
                Placeholder(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Balance extends StatelessWidget {
  final ReportModel reportData;
  const _Balance({required this.reportData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: BalanceCard(
        showButton: false,
        title: "صافي الرصيد",
        currentBalance: reportData.balance,
        transactions: reportData.transactions,
      ),
    );
  }
}

class _Tabs extends StatelessWidget {
  const _Tabs();
  static const _titles = ["نظرة عامة", "التفاصيل"];
  @override
  Widget build(BuildContext context) {
    final controller = DefaultTabController.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: TabBar(
        dividerHeight: 0,
        isScrollable: true,
        controller: controller,
        padding: EdgeInsets.zero,
        tabAlignment: TabAlignment.start,
        indicator: const BoxDecoration(),
        labelPadding: EdgeInsets.symmetric(horizontal: 4.w),
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        tabs: List.generate(
          _titles.length,
          (index) => AnimatedBuilder(
            animation: controller.animation!,
            builder: (context, _) {
              final isSelected = controller.index == index;
              return _Tab(title: _titles[index], isSelected: isSelected);
            },
          ),
        ),
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  final String title;
  final bool isSelected;
  const _Tab({required this.title, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var color = isSelected ? theme.primaryColor : null;
    return Tab(
      height: 36,
      child: AnimatedContainer(
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          color: theme.primaryColor.withAlpha(40),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: color ?? Colors.transparent, width: 1.5.w),
        ),
        child: CustomText(
          text: title,
          size: 14.sp,
          color: color ?? theme.scaffoldBackgroundColor,
          type: isSelected ? Type.header : Type.overMedium,
        ),
      ),
    );
  }
}
