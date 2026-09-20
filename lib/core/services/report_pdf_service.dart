// ignore_for_file: unused_local_variable

import 'dart:typed_data';

import 'package:flutter/material.dart' show Color;
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:surrah/features/report/data/model/income_entry.dart';

import '../../core/utils/theme.dart';
import '../../features/categories/data/models/category_model.dart';
import '../../features/report/presentation/pages/widgets/expense_breakdown_view.dart';
import '../../features/report/presentation/pages/widgets/expense_chart_view.dart';
import '../../features/transactions/data/model/transaction_model.dart';

class ReportPdfService {
  ReportPdfService._();

  static final _navy = _toPdfColor(AppTheme.primary);
  static final _gold = _toPdfColor(AppTheme.secondary);
  static final _grey = _toPdfColor(AppTheme.inactiveGrey);
  static const _greyLight = PdfColors.grey200;
  static const _greyBorder = PdfColors.grey300;
  static const _barGrey = PdfColor.fromInt(0xFFD9DEE6);

  static PdfColor _toPdfColor(Color color) {
    return PdfColor.fromInt(color.value);
  }

  static Future<Uint8List> buildReportPdf({
    required DateTime month,
    required double salary,
    required double totalExpenses,
    required double remaining,
    required List<TransactionModel> transactions,
    required List<CategoryModel> categories,
    required List<WeeklyExpense> weeklyExpenses,
    required List<CategoryExpense> categoryExpenses,
    required List<CategoryExpense> incomeBreakdown,
    required List<IncomeEntry> incomeEntries,
  }) async {
    final regularFont = pw.Font.ttf(
      await rootBundle.load('assets/fonts/cairo/Cairo-Regular.ttf'),
    );
    final boldFont = pw.Font.ttf(
      await rootBundle.load('assets/fonts/cairo/Cairo-Bold.ttf'),
    );

    final doc = pw.Document(
      theme: pw.ThemeData.withFont(base: regularFont, bold: boldFont),
    );

    final monthLabel = DateFormat('MMMM yyyy').format(month);

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.fromLTRB(28, 24, 28, 20),
        textDirection: pw.TextDirection.rtl,
        header: (context) => _buildTopBar(),
        footer: (context) => _buildFooter(context),
        build: (context) => [
          _buildTitleBlock(monthLabel),
          pw.SizedBox(height: 14),

          _buildSummary(salary, totalExpenses, remaining),
          pw.SizedBox(height: 14),

          if (weeklyExpenses.isNotEmpty) ...[
            _buildCard(
              title: 'المصروفات الأسبوعية',
              child: _buildWeeklyChart(weeklyExpenses),
            ),
            pw.SizedBox(height: 14),
          ],

          if (categoryExpenses.isNotEmpty) ...[
            _buildCard(
              title: 'تفصيل المصروفات',
              child: _buildExpenseBreakdown(categoryExpenses, totalExpenses),
            ),
            pw.SizedBox(height: 14),
          ],

          if (incomeEntries.isNotEmpty) ...[
            _buildPageSectionTitle('تفاصيل الدخل'),
            pw.SizedBox(height: 8),
            _buildIncomeTable(incomeEntries, incomeBreakdown),
            pw.SizedBox(height: 14),
          ],

          if (transactions.any((t) => !t.isIncome)) ...[
            _buildPageSectionTitle('تفاصيل المصروفات'),
            pw.SizedBox(height: 8),
            _buildExpenseTable(transactions, categories, categoryExpenses),
          ],
        ],
      ),
    );

    return doc.save();
  }

  static Future<void> shareReportPdf({
    required DateTime month,
    required double salary,
    required double totalExpenses,
    required double remaining,
    required List<TransactionModel> transactions,
    required List<CategoryModel> categories,
    required List<WeeklyExpense> weeklyExpenses,
    required List<CategoryExpense> categoryExpenses,
    required List<CategoryExpense> incomeBreakdown,
    required List<IncomeEntry> incomeEntries,
  }) async {
    final bytes = await buildReportPdf(
      month: month,
      salary: salary,
      totalExpenses: totalExpenses,
      remaining: remaining,
      transactions: transactions,
      categories: categories,
      weeklyExpenses: weeklyExpenses,
      categoryExpenses: categoryExpenses,
      incomeBreakdown: incomeBreakdown,
      incomeEntries: incomeEntries,
    );

    final monthLabel = DateFormat('yyyy-MM').format(month);

    await Printing.sharePdf(
      bytes: bytes,
      filename: 'expense_report_$monthLabel.pdf',
    );
  }

  // ---------- Top bar ----------

  static pw.Widget _buildTopBar() {
    return pw.Column(
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('أموالك ـ في أمان', style: pw.TextStyle(fontSize: 9, color: _grey)),
            pw.Row(
              children: [
                pw.Text(
                  'Surrah',
                  style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold, color: _navy),
                ),
                pw.SizedBox(width: 6),
                pw.Container(
                  width: 18,
                  height: 18,
                  decoration: pw.BoxDecoration(color: _gold, shape: pw.BoxShape.circle),
                ),
              ],
            ),
          ],
        ),
        pw.SizedBox(height: 8),
        pw.Divider(color: _greyBorder, height: 1),
        pw.SizedBox(height: 12),
      ],
    );
  }

  static pw.Widget _buildTitleBlock(String monthLabel) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Monthly Expense Report',
          style: pw.TextStyle(fontSize: 19, fontWeight: pw.FontWeight.bold, color: _navy),
        ),
        pw.SizedBox(height: 2),
        pw.Text(monthLabel, style: pw.TextStyle(fontSize: 11, color: _grey)),
      ],
    );
  }

  static pw.Widget _buildFooter(pw.Context context) {
    return pw.Column(
      children: [
        pw.Divider(color: _greyBorder, height: 1),
        pw.SizedBox(height: 4),
        pw.Align(
          alignment: pw.Alignment.centerLeft,
          child: pw.Text(
            'صفحة ${context.pageNumber} من ${context.pagesCount}',
            style: pw.TextStyle(fontSize: 8, color: _grey),
          ),
        ),
      ],
    );
  }

  // ---------- Card wrapper ----------

  static pw.Widget _buildCard({required String title, required pw.Widget child}) {
    return pw.Container(
      width: double.infinity,
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        color: PdfColors.white,
        border: pw.Border.all(color: _greyBorder, width: 0.7),
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(title, style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold, color: _navy)),
          pw.SizedBox(height: 10),
          child,
        ],
      ),
    );
  }

  static pw.Widget _buildPageSectionTitle(String title) {
    return pw.Text(
      title,
      style: pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold, color: _navy),
    );
  }

  // ---------- Summary tiles ----------

  static pw.Widget _buildSummary(double salary, double totalExpenses, double remaining) {
    return pw.Row(
      children: [
        _summaryTile('الراتب', 'إجمالي الدخل لهذا الشهر', salary, _navy),
        pw.SizedBox(width: 10),
        _summaryTile('إجمالي المصروفات', 'إجمالي ما تم إنفاقه هذا الشهر', totalExpenses, _gold),
        pw.SizedBox(width: 10),
        _summaryTile('المتبقي', 'الراتب بعد المصروفات', remaining, _navy),
      ],
    );
  }

  static pw.Widget _summaryTile(String label, String hint, double value, PdfColor badgeColor) {
    return pw.Expanded(
      child: pw.Container(
        padding: const pw.EdgeInsets.all(10),
        decoration: pw.BoxDecoration(
          color: PdfColors.white,
          border: pw.Border.all(color: _greyBorder, width: 0.7),
          borderRadius: pw.BorderRadius.circular(8),
        ),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Expanded(
                  child: pw.Text(
                    label,
                    style: pw.TextStyle(fontSize: 9.5, fontWeight: pw.FontWeight.bold, color: _navy),
                  ),
                ),
                pw.Container(
                  width: 16,
                  height: 16,
                  decoration: pw.BoxDecoration(color: badgeColor, shape: pw.BoxShape.circle),
                ),
              ],
            ),
            pw.SizedBox(height: 2),
            pw.Text(hint, style: pw.TextStyle(fontSize: 6.5, color: _grey)),
            pw.SizedBox(height: 8),
            pw.Text(
              '\$${value.toStringAsFixed(0)}',
              style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold, color: _navy),
            ),
          ],
        ),
      ),
    );
  }

  // ---------- Weekly bar chart ----------

  static pw.Widget _buildWeeklyChart(List<WeeklyExpense> weeks) {
    final maxAmount = weeks.map((w) => w.amount).reduce((a, b) => a > b ? a : b);
    const chartHeight = 80.0;

    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
      children: weeks.map((w) {
        final isMax = w.amount == maxAmount && maxAmount > 0;
        final barHeight = maxAmount == 0 ? 0.0 : (w.amount / maxAmount) * chartHeight;

        return pw.Column(
          mainAxisAlignment: pw.MainAxisAlignment.end,
          children: [
            pw.Text(
              '\$${w.amount.toStringAsFixed(0)}',
              style: pw.TextStyle(
                fontSize: 8,
                fontWeight: isMax ? pw.FontWeight.bold : pw.FontWeight.normal,
                color: isMax ? _navy : _grey,
              ),
            ),
            pw.SizedBox(height: 4),
            pw.Container(
              width: 30,
              height: barHeight,
              decoration: pw.BoxDecoration(
                color: isMax ? _gold : _barGrey,
                borderRadius: const pw.BorderRadius.vertical(top: pw.Radius.circular(4)),
              ),
            ),
            pw.SizedBox(height: 6),
            pw.Text(w.label, style: pw.TextStyle(fontSize: 8, color: _grey)),
          ],
        );
      }).toList(),
    );
  }

  // ---------- Expense breakdown (donut + legend) ----------

  static pw.Widget _buildExpenseBreakdown(List<CategoryExpense> items, double totalExpenses) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      children: [
        pw.Stack(
          alignment: pw.Alignment.center,
          children: [
            pw.SizedBox(
              width: 110,
              height: 110,
              child: pw.Chart(
                grid: pw.PieGrid(),
                datasets: items.map((c) {
                  return pw.PieDataSet(value: c.amount, color: PdfColor.fromInt(c.category.color));
                }).toList(),
              ),
            ),
            pw.Container(
              width: 52,
              height: 52,
              alignment: pw.Alignment.center,
              decoration: const pw.BoxDecoration(color: PdfColors.white, shape: pw.BoxShape.circle),
              child: pw.Text(
                '\$${totalExpenses.toStringAsFixed(0)}',
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold, color: _navy),
              ),
            ),
          ],
        ),
        pw.SizedBox(width: 18),
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: items.map((c) {
              return pw.Padding(
                padding: const pw.EdgeInsets.symmetric(vertical: 3),
                child: pw.Row(
                  children: [
                    pw.Container(
                      width: 7,
                      height: 7,
                      decoration: pw.BoxDecoration(color: PdfColor.fromInt(c.category.color), shape: pw.BoxShape.circle),
                    ),
                    pw.SizedBox(width: 6),
                    pw.Expanded(child: pw.Text(c.category.name, style: pw.TextStyle(fontSize: 9))),
                    pw.SizedBox(width: 40, child: pw.Text('\$${c.amount.toStringAsFixed(0)}', style: pw.TextStyle(fontSize: 9))),
                    pw.SizedBox(
                      width: 28,
                      child: pw.Text(
                        '${c.percentage.toStringAsFixed(0)}%',
                        style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold, color: _navy),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  // ---------- ONE combined table for income: Date | Amount | Percentage | Source ----------

  static pw.Widget _buildIncomeTable(
    List<IncomeEntry> entries,
    List<CategoryExpense> breakdown,
  ) {
    final percentageByCategory = <String, double>{
      for (final b in breakdown) b.category.id: b.percentage,
    };

    final headers = ['التاريخ', 'المبلغ', 'النسبة', 'المصدر'];

    final rows = entries.map((e) {
      final percentage = percentageByCategory[e.category.id] ?? 0;
      return [
        DateFormat('yyyy-MM-dd').format(e.transaction.createdAt),
        '+\$${e.transaction.amount.toStringAsFixed(0)}',
        '${percentage.toStringAsFixed(0)}%',
        e.category.name,
      ];
    }).toList();

    return pw.TableHelper.fromTextArray(
      headers: headers,
      data: rows,
      tableDirection: pw.TextDirection.rtl,
      headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 9.5, color: _navy),
      cellStyle: pw.TextStyle(fontSize: 9),
      headerDecoration: pw.BoxDecoration(color: _greyLight),
      cellPadding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      border: pw.TableBorder(horizontalInside: pw.BorderSide(color: _greyBorder, width: 0.5)),
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerLeft,
        2: pw.Alignment.centerLeft,
        3: pw.Alignment.centerRight,
      },
      columnWidths: {
        0: const pw.FlexColumnWidth(2),
        1: const pw.FlexColumnWidth(2),
        2: const pw.FlexColumnWidth(1.5),
        3: const pw.FlexColumnWidth(2.5),
      },
    );
  }

  // ---------- ONE combined table for expenses: Date | Amount | Percentage | Category ----------

  static pw.Widget _buildExpenseTable(
    List<TransactionModel> transactions,
    List<CategoryModel> categories,
    List<CategoryExpense> breakdown,
  ) {
    final percentageByCategory = <String, double>{
      for (final b in breakdown) b.category.id: b.percentage,
    };

    final expenseTransactions = transactions.where((t) => !t.isIncome).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    final headers = ['التاريخ', 'المبلغ', 'النسبة', 'الفئة'];

    final rows = expenseTransactions.map((t) {
      final category = categories.firstWhere(
        (c) => c.id == t.categoryId,
        orElse: () => CategoryModel(
          id: t.categoryId,
          name: 'Other',
          color: 0xFF8C96A8,
          iconId: 'other',
          isIncome: false,
        ),
      );

      final percentage = percentageByCategory[category.id] ?? 0;

      return [
        DateFormat('yyyy-MM-dd').format(t.createdAt),
        '-\$${t.amount.toStringAsFixed(0)}',
        '${percentage.toStringAsFixed(0)}%',
        category.name,
      ];
    }).toList();

    return pw.TableHelper.fromTextArray(
      headers: headers,
      data: rows,
      tableDirection: pw.TextDirection.rtl,
      headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 9.5, color: _navy),
      cellStyle: pw.TextStyle(fontSize: 9),
      headerDecoration: pw.BoxDecoration(color: _greyLight),
      cellPadding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      border: pw.TableBorder(horizontalInside: pw.BorderSide(color: _greyBorder, width: 0.5)),
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerLeft,
        2: pw.Alignment.centerLeft,
        3: pw.Alignment.centerRight,
      },
      columnWidths: {
        0: const pw.FlexColumnWidth(2),
        1: const pw.FlexColumnWidth(2),
        2: const pw.FlexColumnWidth(1.5),
        3: const pw.FlexColumnWidth(2.5),
      },
    );
  }
}