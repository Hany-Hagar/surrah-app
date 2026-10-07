// // ignore_for_file: deprecated_member_use, unused_local_variable

// import 'dart:typed_data';

// import 'package:flutter/material.dart' show Color;
// import 'package:flutter/services.dart' show rootBundle;
// import 'package:intl/intl.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';

// import '../../core/utils/theme.dart';
// import '../../features/categories/data/models/category_model.dart';
// import '../../features/report/presentation/manager/report_cubit.dart';
// import '../../features/report/presentation/pages/widgets/expense_breakdown_view.dart';
// import '../../features/report/presentation/pages/widgets/expense_chart_view.dart';
// import '../../features/report/data/model/income_entry.dart';
// import '../../features/transactions/data/model/transaction_model.dart';

// class ReportPdfService {
//   ReportPdfService._();

//   // ---------- Palette (pulled from AppTheme) ----------

//   static final _navy = _toPdfColor(AppTheme.primary);
//   static final _gold = _toPdfColor(AppTheme.secondary);
//   static final _grey = _toPdfColor(AppTheme.inactiveGrey);
//   static const _greyLight = PdfColor.fromInt(0xFFF3F4F6);
//   static const _greyBorder = PdfColor.fromInt(0xFFE5E7EB);
//   static const _success = PdfColor.fromInt(0xFF2E8B57);
//   static const _white = PdfColors.white;

//   static PdfColor _toPdfColor(Color color) {
//     return PdfColor.fromInt(color.value);
//   }

//   // ---------- Spacing scale ----------

//   static const double _sSm = 8;
//   static const double _sMd = 14;
//   static const double _sLg = 20;
//   static const double _sXl = 24;

//   // ---------- Text & dot helpers ----------

//   static pw.Text _pdfText(
//     String text, {
//     required double size,
//     PdfColor? color,
//     pw.FontWeight? fontWeight,
//     double? letterSpacing,
//     pw.TextAlign? textAlign,
//   }) {
//     return pw.Text(
//       text,
//       textAlign: textAlign,
//       style: pw.TextStyle(
//         fontSize: size,
//         color: color ?? _navy,
//         fontWeight: fontWeight ?? pw.FontWeight.normal,
//         letterSpacing: letterSpacing,
//       ),
//     );
//   }

//   static pw.Widget _dot(PdfColor color, {double size = 8}) {
//     return pw.Container(
//       width: size,
//       height: size,
//       decoration: pw.BoxDecoration(color: color, shape: pw.BoxShape.circle),
//     );
//   }

//   static String _trendTitle(ReportPeriod period) {
//     switch (period) {
//       case ReportPeriod.day:
//         return 'مصروفات أيام الأسبوع';
//       case ReportPeriod.week:
//         return 'مصروفات أسابيع الشهر';
//       case ReportPeriod.month:
//         return 'مصروفات شهور السنة';
//       case ReportPeriod.year:
//         return 'مصروفات آخر 5 سنوات';
//     }
//   }

//   static String _shortAmount(double value) {
//     if (value >= 1000) {
//       final k = value / 1000;
//       return '${k.toStringAsFixed(k == k.roundToDouble() ? 0 : 1)}k';
//     }
//     return value.toStringAsFixed(0);
//   }

//   static Future<Uint8List> buildReportPdf({
//     required DateTime month,
//     required ReportPeriod selectedPeriod,
//     required double salary,
//     required double totalExpenses,
//     required double remaining,
//     required List<TransactionModel> transactions,
//     required List<TransactionModel> allTransactions,
//     required List<CategoryModel> categories,
//     required List<WeeklyExpense> weeklyExpenses,
//     required List<CategoryExpense> categoryExpenses,
//     required List<CategoryExpense> incomeBreakdown,
//     required List<IncomeEntry> incomeEntries,
//   }) async {
//     final regularFont = pw.Font.ttf(
//       await rootBundle.load('assets/fonts/cairo/Cairo-Regular.ttf'),
//     );
//     final boldFont = pw.Font.ttf(
//       await rootBundle.load('assets/fonts/cairo/Cairo-Bold.ttf'),
//     );

//     final doc = pw.Document(
//       theme: pw.ThemeData.withFont(base: regularFont, bold: boldFont),
//     );

//     final monthLabel = DateFormat('MMMM yyyy').format(month);

//     final dayTrend = _trendForPeriod(allTransactions, month, ReportPeriod.day);
//     final weekTrend = _trendForPeriod(allTransactions, month, ReportPeriod.week);
//     final monthTrend = _trendForPeriod(allTransactions, month, ReportPeriod.month);
//     final yearTrend = _trendForPeriod(allTransactions, month, ReportPeriod.year);

//     final allIncomeEntries = allTransactions
//         .where((t) => t.isIncome)
//         .map((t) {
//           final category = categories.firstWhere(
//             (c) => c.id == t.categoryId,
//             orElse: () => CategoryModel(
//               id: t.categoryId,
//               name: 'Other',
//               color: 0xFF8C96A8,
//               iconId: 'other',
//               isIncome: true,
//             ),
//           );
//           return IncomeEntry(transaction: t, category: category);
//         })
//         .toList();

//     doc.addPage(
//       pw.MultiPage(
//         pageFormat: PdfPageFormat.a4,
//         margin: const pw.EdgeInsets.fromLTRB(28, 22, 28, 20),
//         textDirection: pw.TextDirection.rtl,
//         header: (context) => _buildTopBar(),
//         footer: (context) => _buildFooter(context),
//         build: (context) => [
//           _buildTitleBlock(monthLabel),
//           pw.SizedBox(height: _sLg),

//           _buildSummary(salary, totalExpenses, remaining),
//           pw.SizedBox(height: _sXl),
//           if (dayTrend.any((e) => e.amount > 0))
//             _buildCard(
//               title: _trendTitle(ReportPeriod.day),
//               child: _buildTrendChart(dayTrend),
//             ),
//           pw.SizedBox(height: _sMd),

//           if (weekTrend.any((e) => e.amount > 0))
//             _buildCard(
//               title: _trendTitle(ReportPeriod.week),
//               child: _buildTrendChart(weekTrend),
//             ),
//           pw.SizedBox(height: _sXl),

//           if (monthTrend.any((e) => e.amount > 0))
//             _buildCard(
//               title: _trendTitle(ReportPeriod.month),
//               child: _buildTrendChart(monthTrend),
//             ),
//           pw.SizedBox(height: _sXl),

//           if (yearTrend.any((e) => e.amount > 0))
//             _buildCard(
//               title: _trendTitle(ReportPeriod.year),
//               child: _buildTrendChart(yearTrend),
//             ),

//           if (categoryExpenses.isNotEmpty || incomeBreakdown.isNotEmpty) ...[
//             pw.SizedBox(height: _sMd),
//             pw.Row(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               children: [
//                 if (categoryExpenses.isNotEmpty)
//                   pw.Expanded(
//                     child: _buildCard(
//                       title: 'تفصيل المصروفات',
//                       child: _buildDonutSection(
//                         items: categoryExpenses,
//                         centerValue: totalExpenses,
//                       ),
//                     ),
//                   ),
//                 if (categoryExpenses.isNotEmpty && incomeBreakdown.isNotEmpty)
//                   pw.SizedBox(width: _sMd),
//                 if (incomeBreakdown.isNotEmpty)
//                   pw.Expanded(
//                     child: _buildCard(
//                       title: 'مصادر الدخل',
//                       child: _buildDonutSection(
//                         items: incomeBreakdown,
//                         centerValue: salary,
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//           ],

//           if (allIncomeEntries.isNotEmpty) ...[
//             pw.SizedBox(height: _sXl),
//             _buildPageSectionTitle('تفاصيل الدخل (كل الفترات)'),
//             pw.SizedBox(height: _sSm),
//             _buildIncomeTable(allIncomeEntries, incomeBreakdown),
//           ],

//           if (allTransactions.any((t) => !t.isIncome)) ...[
//             pw.SizedBox(height: _sXl),
//             _buildPageSectionTitle('تفاصيل المصروفات (كل الفترات)'),
//             pw.SizedBox(height: _sSm),
//             _buildExpenseTable(allTransactions, categories, categoryExpenses),
//           ],
//         ],
//       ),
//     );

//     return doc.save();
//   }

//   static Future<void> shareReportPdf({
//     required DateTime month,
//     required ReportPeriod selectedPeriod,
//     required double salary,
//     required double totalExpenses,
//     required double remaining,
//     required List<TransactionModel> transactions,
//     required List<TransactionModel> allTransactions,
//     required List<CategoryModel> categories,
//     required List<WeeklyExpense> weeklyExpenses,
//     required List<CategoryExpense> categoryExpenses,
//     required List<CategoryExpense> incomeBreakdown,
//     required List<IncomeEntry> incomeEntries,
//   }) async {
//     final bytes = await buildReportPdf(
//       month: month,
//       selectedPeriod: selectedPeriod,
//       salary: salary,
//       totalExpenses: totalExpenses,
//       remaining: remaining,
//       transactions: transactions,
//       allTransactions: allTransactions,
//       categories: categories,
//       weeklyExpenses: weeklyExpenses,
//       categoryExpenses: categoryExpenses,
//       incomeBreakdown: incomeBreakdown,
//       incomeEntries: incomeEntries,
//     );

//     final monthLabel = DateFormat('yyyy-MM').format(month);

//     await Printing.sharePdf(
//       bytes: bytes,
//       filename: 'expense_report_$monthLabel.pdf',
//     );
//   }

//   // ---------- Top bar ----------

//   static pw.Widget _buildTopBar() {
//     return pw.Column(
//       children: [
//         pw.Row(
//           mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//           children: [
//             _pdfText('أموالك ـ في أمان', size: 9, color: _grey),
//             pw.Row(
//               children: [
//                 _pdfText('Surrah', size: 14, fontWeight: pw.FontWeight.bold),
//                 pw.SizedBox(width: 6),
//                 _dot(_gold, size: 18),
//               ],
//             ),
//           ],
//         ),
//         pw.SizedBox(height: _sSm),
//         pw.Divider(color: _greyBorder, height: 1, thickness: 1),
//         pw.SizedBox(height: _sMd),
//       ],
//     );
//   }

//   static pw.Widget _buildTitleBlock(String monthLabel) {
//     return pw.Column(
//       crossAxisAlignment: pw.CrossAxisAlignment.start,
//       children: [
//         _pdfText('التقرير المالي الشامل', size: 20, fontWeight: pw.FontWeight.bold),
//         pw.SizedBox(height: 3),
//         _pdfText(monthLabel, size: 11, color: _grey),
//       ],
//     );
//   }

//   static pw.Widget _buildFooter(pw.Context context) {
//     return pw.Column(
//       children: [
//         pw.Divider(color: _greyBorder, height: 1, thickness: 1),
//         pw.SizedBox(height: 6),
//         pw.Row(
//           mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//           children: [
//             _pdfText('Surrah', size: 8, color: _grey),
//             _pdfText('صفحة ${context.pageNumber} من ${context.pagesCount}', size: 8, color: _grey),
//           ],
//         ),
//       ],
//     );
//   }

//   // ---------- Card wrapper ----------

//   static pw.Widget _buildCard({required String title, required pw.Widget child}) {
//     return pw.Container(
//       width: double.infinity,
//       padding: const pw.EdgeInsets.all(14),
//       decoration: pw.BoxDecoration(
//         color: _white,
//         border: pw.Border.all(color: _greyBorder, width: 0.8),
//         borderRadius: pw.BorderRadius.circular(10),
//       ),
//       child: pw.Column(
//         mainAxisSize: pw.MainAxisSize.min,
//         crossAxisAlignment: pw.CrossAxisAlignment.start,
//         children: [
//           _pdfText(title, size: 14.5, fontWeight: pw.FontWeight.bold),
//           pw.SizedBox(height: 12),
//           child,
//         ],
//       ),
//     );
//   }

//   static pw.Widget _buildPageSectionTitle(String title) {
//     return pw.Row(
//       children: [
//         pw.Container(width: 3, height: 14, color: _gold),
//         pw.SizedBox(width: 8),
//         _pdfText(title, size: 13.5, fontWeight: pw.FontWeight.bold),
//       ],
//     );
//   }

//   // ---------- Summary tiles ----------

//   static pw.Widget _buildSummary(double salary, double totalExpenses, double remaining) {
//     return pw.Row(
//       children: [
//         _summaryTile('الراتب والدخل', 'إجمالي الدخل لهذا الشهر', salary, _navy),
//         pw.SizedBox(width: 10),
//         _summaryTile('إجمالي المصروفات', 'إجمالي ما تم إنفاقه هذا الشهر', totalExpenses, _gold),
//         pw.SizedBox(width: 10),
//         _summaryTile('المتبقي', 'الدخل بعد خصم المصروفات', remaining, _success),
//       ],
//     );
//   }

//   static pw.Widget _summaryTile(String label, String hint, double value, PdfColor badgeColor) {
//     return pw.Expanded(
//       child: pw.Container(
//         padding: const pw.EdgeInsets.all(12),
//         decoration: pw.BoxDecoration(
//           color: _white,
//           border: pw.Border.all(color: _greyBorder, width: 0.8),
//           borderRadius: pw.BorderRadius.circular(10),
//         ),
//         child: pw.Column(
//           mainAxisSize: pw.MainAxisSize.min,
//           crossAxisAlignment: pw.CrossAxisAlignment.start,
//           children: [
//             pw.Row(
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Expanded(child: _pdfText(label, size: 9.5, fontWeight: pw.FontWeight.bold)),
//                 _dot(badgeColor),
//               ],
//             ),
//             pw.SizedBox(height: 3),
//             _pdfText(hint, size: 6.5, color: _grey),
//             pw.SizedBox(height: 10),
//             _pdfText('\$${value.toStringAsFixed(0)}', size: 16, fontWeight: pw.FontWeight.bold),
//           ],
//         ),
//       ),
//     );
//   }

//   // ---------- Trend chart (count-agnostic via Expanded columns) ----------

//   static pw.Widget _buildTrendChart(List<WeeklyExpense> points) {
//     final maxAmount = points.map((p) => p.amount).reduce((a, b) => a > b ? a : b);
//     const chartHeight = 90.0;

//     return pw.Row(
//       crossAxisAlignment: pw.CrossAxisAlignment.end,
//       children: points.map((p) {
//         final barHeight = maxAmount == 0 ? 2.0 : (p.amount / maxAmount) * chartHeight;

//         return pw.Expanded(
//           child: pw.Column(
//             mainAxisSize: pw.MainAxisSize.min,
//             mainAxisAlignment: pw.MainAxisAlignment.end,
//             children: [
//               if (p.amount > 0)
//                 _pdfText('\$${_shortAmount(p.amount)}', size: 7, fontWeight: pw.FontWeight.bold),
//               pw.SizedBox(height: 3),
//               pw.Center(
//                 child: pw.Container(
//                   width: 18,
//                   height: barHeight < 2 ? 2 : barHeight,
//                   decoration: pw.BoxDecoration(
//                     color: _gold,
//                     borderRadius: const pw.BorderRadius.vertical(top: pw.Radius.circular(3)),
//                   ),
//                 ),
//               ),
//               pw.SizedBox(height: 6),
//               _pdfText(
//                 p.label,
//                 size: 8.5,
//                 fontWeight: pw.FontWeight.bold,
//                 textAlign: pw.TextAlign.center,
//               ),
//               if (p.subLabel.isNotEmpty) ...[
//                 pw.SizedBox(height: 1),
//                 _pdfText(
//                   p.subLabel,
//                   size: 6.5,
//                   color: _grey,
//                   textAlign: pw.TextAlign.center,
//                 ),
//               ],
//             ],
//           ),
//         );
//       }).toList(),
//     );
//   }

//   // ---------- Shared donut section ----------

//   static pw.Widget _buildDonutSection({
//     required List<CategoryExpense> items,
//     required double centerValue,
//   }) {
//     return pw.Column(
//       mainAxisSize: pw.MainAxisSize.min,
//       crossAxisAlignment: pw.CrossAxisAlignment.center,
//       children: [
//         pw.Stack(
//           alignment: pw.Alignment.center,
//           children: [
//             pw.SizedBox(
//               width: 100,
//               height: 100,
//               child: pw.Chart(
//                 grid: pw.PieGrid(),
//                 datasets: items.map((c) {
//                   return pw.PieDataSet(value: c.amount, color: PdfColor.fromInt(c.category.color));
//                 }).toList(),
//               ),
//             ),
//             pw.Container(
//               width: 48,
//               height: 48,
//               alignment: pw.Alignment.center,
//               padding: const pw.EdgeInsets.all(2),
//               decoration: const pw.BoxDecoration(color: _white, shape: pw.BoxShape.circle),
//               child: _pdfText(
//                 '\$${centerValue.toStringAsFixed(0)}',
//                 size: 8,
//                 fontWeight: pw.FontWeight.bold,
//                 textAlign: pw.TextAlign.center,
//               ),
//             ),
//           ],
//         ),
//         pw.SizedBox(height: 12),
//         pw.Column(
//           mainAxisSize: pw.MainAxisSize.min,
//           children: items.map((c) => _donutLegendRow(c)).toList(),
//         ),
//       ],
//     );
//   }

//   static pw.Widget _donutLegendRow(CategoryExpense c) {
//     return pw.Padding(
//       padding: const pw.EdgeInsets.symmetric(vertical: 3),
//       child: pw.Row(
//         children: [
//           _dot(PdfColor.fromInt(c.category.color), size: 7),
//           pw.SizedBox(width: 6),
//           pw.Expanded(child: _pdfText(c.category.name, size: 9, fontWeight: pw.FontWeight.normal)),
//           _pdfText('\$${c.amount.toStringAsFixed(0)}', size: 9, fontWeight: pw.FontWeight.normal),
//           pw.SizedBox(width: 8),
//           pw.SizedBox(
//             width: 30,
//             child: _pdfText(
//               '${c.percentage.toStringAsFixed(0)}%',
//               size: 9,
//               fontWeight: pw.FontWeight.bold,
//               textAlign: pw.TextAlign.right,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ---------- Shared table style ----------

//   static pw.Widget _buildTable({
//     required List<String> headers,
//     required List<List<String>> rows,
//   }) {
//     return pw.TableHelper.fromTextArray(
//       headers: headers,
//       data: rows,
//       tableDirection: pw.TextDirection.rtl,
//       headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 9.5, color: _navy),
//       cellStyle: pw.TextStyle(fontSize: 9, color: _navy),
//       headerDecoration: const pw.BoxDecoration(color: _greyLight),
//       cellPadding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 7),
//       border: pw.TableBorder(
//         horizontalInside: pw.BorderSide(color: _greyBorder, width: 0.6),
//         top: pw.BorderSide(color: _greyBorder, width: 0.8),
//         bottom: pw.BorderSide(color: _greyBorder, width: 0.8),
//       ),
//       cellAlignments: {
//         0: pw.Alignment.centerLeft,
//         1: pw.Alignment.centerLeft,
//         2: pw.Alignment.centerLeft,
//         3: pw.Alignment.centerRight,
//       },
//       columnWidths: {
//         0: const pw.FlexColumnWidth(2),
//         1: const pw.FlexColumnWidth(2),
//         2: const pw.FlexColumnWidth(1.5),
//         3: const pw.FlexColumnWidth(2.5),
//       },
//     );
//   }

//   static pw.Widget _buildIncomeTable(
//     List<IncomeEntry> entries,
//     List<CategoryExpense> breakdown,
//   ) {
//     final percentageByCategory = <String, double>{
//       for (final b in breakdown) b.category.id: b.percentage,
//     };

//     final sortedEntries = [...entries]
//       ..sort((a, b) => b.transaction.createdAt.compareTo(a.transaction.createdAt));

//     final rows = sortedEntries.map((e) {
//       final percentage = percentageByCategory[e.category.id] ?? 0;
//       return [
//         DateFormat('yyyy-MM-dd').format(e.transaction.createdAt),
//         '+\$${e.transaction.amount.toStringAsFixed(0)}',
//         '${percentage.toStringAsFixed(0)}%',
//         e.category.name,
//       ];
//     }).toList();

//     return _buildTable(
//       headers: const ['التاريخ', 'المبلغ', 'النسبة', 'المصدر'],
//       rows: rows,
//     );
//   }

//   static pw.Widget _buildExpenseTable(
//     List<TransactionModel> transactions,
//     List<CategoryModel> categories,
//     List<CategoryExpense> breakdown,
//   ) {
//     final percentageByCategory = <String, double>{
//       for (final b in breakdown) b.category.id: b.percentage,
//     };

//     final expenseTransactions = transactions.where((t) => !t.isIncome).toList()
//       ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

//     final rows = expenseTransactions.map((t) {
//       final category = categories.firstWhere(
//         (c) => c.id == t.categoryId,
//         orElse: () => CategoryModel(
//           id: t.categoryId,
//           name: 'Other',
//           color: 0xFF8C96A8,
//           iconId: 'other',
//           isIncome: false,
//         ),
//       );

//       final percentage = percentageByCategory[category.id] ?? 0;

//       return [
//         DateFormat('yyyy-MM-dd').format(t.createdAt),
//         '-\$${t.amount.toStringAsFixed(0)}',
//         '${percentage.toStringAsFixed(0)}%',
//         category.name,
//       ];
//     }).toList();

//     return _buildTable(
//       headers: const ['التاريخ', 'المبلغ', 'النسبة', 'الفئة'],
//       rows: rows,
//     );
//   }

//   static List<WeeklyExpense> _trendForPeriod(
//     List<TransactionModel> allTransactions,
//     DateTime anchor,
//     ReportPeriod period,
//   ) {
//     final expenses = allTransactions.where((t) => !t.isIncome).toList();

//     double sumBetween(DateTime start, DateTime end) {
//       var total = 0.0;
//       for (final t in expenses) {
//         if (!t.createdAt.isBefore(start) && t.createdAt.isBefore(end)) {
//           total += t.amount;
//         }
//       }
//       return total;
//     }

//     switch (period) {
//       case ReportPeriod.day:
//         final weekStart = anchor.startOfPeriod(ReportPeriod.week);
//         return List.generate(7, (i) {
//           final start = DateTime(weekStart.year, weekStart.month, weekStart.day + i);
//           final end = DateTime(start.year, start.month, start.day + 1);
//           return WeeklyExpense(
//             label: DateFormat('E').format(start),
//             subLabel: '${start.day}',
//             amount: sumBetween(start, end),
//           );
//         });

//       case ReportPeriod.week:
//         final lastDay = DateTime(anchor.year, anchor.month + 1, 0).day;
//         return List.generate(4, (i) {
//           final startDay = 1 + i * 7;
//           final start = DateTime(anchor.year, anchor.month, startDay);
//           final end = i == 3
//               ? DateTime(anchor.year, anchor.month + 1, 1)
//               : DateTime(anchor.year, anchor.month, startDay + 7);
//           final endDay = i == 3 ? lastDay : startDay + 6;
//           return WeeklyExpense(
//             label: 'W${i + 1}',
//             subLabel: '$startDay-$endDay',
//             amount: sumBetween(start, end),
//           );
//         });

//       case ReportPeriod.month:
//         return List.generate(12, (i) {
//           final start = DateTime(anchor.year, i + 1, 1);
//           final end = DateTime(anchor.year, i + 2, 1);
//           return WeeklyExpense(
//             label: DateFormat('MMM').format(start),
//             amount: sumBetween(start, end),
//           );
//         });

//       case ReportPeriod.year:
//         return List.generate(5, (i) {
//           final year = anchor.year - 4 + i;
//           return WeeklyExpense(
//             label: '$year',
//             amount: sumBetween(DateTime(year, 1, 1), DateTime(year + 1, 1, 1)),
//           );
//         });
//     }
//   }
// }