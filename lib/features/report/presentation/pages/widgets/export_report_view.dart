import 'package:flutter/material.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:surrah/core/utils/theme.dart';
import 'package:surrah/core/widgets/custom_text.dart';
import 'package:surrah/features/categories/data/models/category_model.dart';
import 'package:surrah/features/report/presentation/pages/widgets/expense_breakdown_view.dart';
import 'package:surrah/features/report/presentation/pages/widgets/expense_chart_view.dart';
import 'package:surrah/features/transactions/data/model/transaction_model.dart';
import 'package:surrah/generated/l10n.dart';

import '../../../../../core/services/report_pdf_service.dart';
import '../../../data/model/income_entry.dart';

class ExportReportView extends StatefulWidget {
  final DateTime month;
  final double salary;
  final double totalExpenses;
  final double remaining;
  final List<TransactionModel> transactions;
  final List<CategoryModel> categories;
  final List<WeeklyExpense> weeklyExpenses;
  final List<CategoryExpense> categoryExpenses;
  final List<CategoryExpense> incomeBreakdown;
  final List<IncomeEntry> incomeEntries;

  const ExportReportView({
    super.key,
    required this.month,
    required this.salary,
    required this.totalExpenses,
    required this.remaining,
    required this.transactions,
    required this.categories,
    required this.weeklyExpenses,
    required this.categoryExpenses,
    required this.incomeBreakdown,
    required this.incomeEntries,
  });

  @override
  State<ExportReportView> createState() => _ExportReportViewState();
}

class _ExportReportViewState extends State<ExportReportView> {
  bool _isGenerating = false;

  Future<void> _handleDownload() async {
    setState(() => _isGenerating = true);

    try {
      await ReportPdfService.shareReportPdf(
        month: widget.month,
        salary: widget.salary,
        totalExpenses: widget.totalExpenses,
        remaining: widget.remaining,
        transactions: widget.transactions,
        categories: widget.categories,
        weeklyExpenses: widget.weeklyExpenses,
        categoryExpenses: widget.categoryExpenses,
        incomeBreakdown: widget.incomeBreakdown,
        incomeEntries: widget.incomeEntries,
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context).pdfGenerationFailed(e.toString())),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isGenerating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: _isGenerating ? null : _handleDownload,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.secondary,
          foregroundColor: AppTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: _isGenerating
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(IconBroken.Arrow___Down, size: 18),
                  const SizedBox(width: 8),
                  CustomText(
                    text: s.downloadReportPdf,
                    size: 15,
                    type: Type.overMedium,
                    color: AppTheme.primary,
                  ),
                ],
              ),
      ),
    );
  }
}