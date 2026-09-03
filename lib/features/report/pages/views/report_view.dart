import '../widgets/report_body.dart';
import 'package:flutter/material.dart';
import '../../../../../core/widgets/custom_back.dart';
import 'package:surrah/core/widgets/custom_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReportView extends StatelessWidget {
  const ReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leading: CustomBack(),
        title: "Report",
        subtitle: "Your financial report",
      ),
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(12.w), child: ReportBody())
      ),
    );
  }
}
