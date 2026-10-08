import 'package:pdf/pdf.dart';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../data/model/report_model.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flex_color_picker/flex_color_picker.dart';
import '../../../data/model/report_transaction_model.dart';
import '../../../../../core/extensions/number_formatting_extension.dart';

class ReportPdfPages {
  final ReportModel report;
  final String Function(double) formatMoney;
  final pw.Font regularFont;
  final pw.Font boldFont;

  ReportPdfPages._({
    required this.report,
    required this.formatMoney,
    required this.regularFont,
    required this.boldFont,
  });

  static Future<ReportPdfPages> create({
    required ReportModel report,
    required String Function(double) formatMoney,
  }) async {
    final regular = pw.Font.ttf(
      await rootBundle.load('assets/fonts/cairo/Cairo-Regular.ttf'),
    );
    final bold = pw.Font.ttf(
      await rootBundle.load('assets/fonts/cairo/Cairo-Bold.ttf'),
    );
    return ReportPdfPages._(
      report: report,
      formatMoney: formatMoney,
      regularFont: regular,
      boldFont: bold,
    );
  }

  pw.Document get pdf {
    return pw.Document(
      title: 'Financial Report',
      theme: pw.ThemeData.withFont(base: regularFont, bold: boldFont),
    )..addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(28),
        build: (_) => [
          _BalanceCard(
            data: report,
            formatMoney: formatMoney,
            expenseColor: PdfColors.red600,
            incomeColor: PdfColors.green600,
          ),
          _AnalysisCard(
            formatMoney: formatMoney,
            title: 'Spending Analysis',
            total: report.totalExpense,
            items: report.groupedExpenses,
          ),
          pw.SizedBox(height: 16),
          _AnalysisCard(
            formatMoney: formatMoney,
            title: 'Income Analysis',
            total: report.totalIncome,
            items: report.groupedIncomes,
          ),
        ],
      ),
    );
  }
}

class _Card extends pw.StatelessWidget {
  final pw.Widget body;
  final PdfColor? color;
  _Card({this.color, required this.body});

  @override
  pw.Widget build(pw.Context context) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(16),
      decoration: pw.BoxDecoration(
        borderRadius: pw.BorderRadius.circular(12),
        color: color ?? PdfColor.fromHex(Colors.white.hex),
        border: pw.Border.all(color: PdfColors.grey300, width: 1),
      ),
      child: body,
    );
  }
}

class _BalanceCard extends pw.StatelessWidget {
  final ReportModel data;
  final PdfColor incomeColor;
  final PdfColor expenseColor;
  final String Function(double) formatMoney;
  _BalanceCard({
    required this.data,
    required this.incomeColor,
    required this.formatMoney,
    required this.expenseColor,
  });

  @override
  pw.Widget build(pw.Context context) {
    var net = formatMoney(data.totalIncome - data.totalExpense);
    return _Card(
      color: PdfColor.fromInt(0xFF111B3A),
      body: pw.Column(
        mainAxisSize: pw.MainAxisSize.min,
        mainAxisAlignment: pw.MainAxisAlignment.start,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          _Text(
            text: 'NETBALANCE',
            size: 12,
            height: 0.8,
            isBold: true,
            color: PdfColors.grey400,
          ),
          _Text(
            size: 30,
            text: net,
            height: 0.5,
            isBold: true,
            color: PdfColors.white,
          ),
          _BalanceItems(
            data: data,
            formatMoney: formatMoney,
            incomeColor: incomeColor,
            expenseColor: expenseColor,
          ),
        ],
      ),
    );
  }
}

class _BalanceItems extends pw.StatelessWidget {
  final ReportModel data;
  final PdfColor incomeColor;
  final PdfColor expenseColor;
  final String Function(double) formatMoney;
  _BalanceItems({
    required this.data,
    required this.incomeColor,
    required this.expenseColor,
    required this.formatMoney,
  });

  @override
  pw.Widget build(pw.Context context) {
    return pw.Row(
      children: [
        _BalanceItem(
          title: 'Income',
          color: incomeColor,
          value: formatMoney(data.totalIncome),
        ),
        _BalanceDivider(),
        _BalanceItem(
          title: 'Expense',
          color: expenseColor,
          value: formatMoney(data.totalExpense),
        ),
        _BalanceDivider(),
        _BalanceItem(
          title: 'Saved',
          color: PdfColors.white,
          value: (data.totalIncome - data.totalExpense).getPercentage(
            total: data.totalIncome,
          ),
        ),
      ],
    );
  }
}

class _BalanceItem extends pw.StatelessWidget {
  final String title;
  final String value;
  final PdfColor color;
  _BalanceItem({
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  pw.Widget build(pw.Context context) {
    return pw.SizedBox(
      width: 100,
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          _Text(text: title, size: 10, height: 0.8, color: PdfColors.grey300),
          _Text(text: value, size: 16, isBold: true, color: color),
        ],
      ),
    );
  }
}

class _BalanceDivider extends pw.StatelessWidget {
  @override
  pw.Widget build(pw.Context context) {
    return pw.Container(
      width: 1,
      height: 30,
      color: PdfColors.grey600,
      margin: const pw.EdgeInsets.only(right: 10),
    );
  }
}

class _AnalysisCard extends pw.StatelessWidget {
  final String title;
  final double total;
  final List<ReportTransactionModel> items;
  final String Function(double) formatMoney;
  _AnalysisCard({
    required this.title,
    required this.total,
    required this.items,
    required this.formatMoney,
  });

  @override
  pw.Widget build(pw.Context context) {
    var greyColor = PdfColors.grey600;
    return _Card(
      body: pw.Column(
        children: [
          _AnalysisTitle(
            title: title,
            subTitle: formatMoney(total),
            greyColor: greyColor,
            formatMoney: formatMoney,
          ),
          pw.SizedBox(height: 8),
          _AnalysisBar(total: total, items: items),
          pw.SizedBox(height: 10),
          pw.Column(
            mainAxisSize: pw.MainAxisSize.min,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              ...items.map(
                (item) => _AnalysisItem(
                  item: item,
                  total: total,
                  greyColor: greyColor,
                  formatMoney: formatMoney,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AnalysisTitle extends pw.StatelessWidget {
  final String title;
  final String subTitle;
  final PdfColor greyColor;
  final String Function(double) formatMoney;

  _AnalysisTitle({
    required this.title,
    required this.subTitle,
    required this.greyColor,
    required this.formatMoney,
  });

  @override
  pw.Widget build(pw.Context context) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        _Text(text: title, size: 14, isBold: true),
        _Text(text: subTitle, size: 13, isBold: true, color: greyColor),
      ],
    );
  }
}

class _AnalysisBar extends pw.StatelessWidget {
  final double total;
  final List<ReportTransactionModel> items;
  _AnalysisBar({required this.total, required this.items});

  @override
  pw.Widget build(pw.Context context) {
    return pw.ClipRRect(
      horizontalRadius: 8,
      verticalRadius: 8,
      child: pw.SizedBox(
        height: 12,
        child: pw.Row(
          children: [
            for (var i = 0; i < items.length; i++) ...[
              pw.Expanded(
                flex: (items[i].amount / total * 1000).round() + 15,
                child: pw.Container(color: PdfColor.fromInt(items[i].color)),
              ),
              if (i != items.length - 1)
                pw.Container(width: 2, color: PdfColors.white),
            ],
          ],
        ),
      ),
    );
  }
}

class _AnalysisItem extends pw.StatelessWidget {
  final double total;
  final ReportTransactionModel item;
  final String Function(double) formatMoney;
  final PdfColor greyColor;
  _AnalysisItem({
    required this.item,
    required this.total,
    required this.greyColor,
    required this.formatMoney,
  });

  @override
  pw.Widget build(pw.Context context) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 2),
      child: pw.Row(
        children: [
          pw.SizedBox(
            width: 80,
            child: _Text(
              size: 12,
              isBold: true,
              align: pw.TextAlign.left,
              text: formatMoney(item.amount),
            ),
          ),
          _Text(
            size: 10,
            isBold: true,
            color: greyColor,
            align: pw.TextAlign.start,
            text: item.amount.getPercentage(total: total),
          ),
          pw.Spacer(),
          _Text(
            size: 11,
            text: item.title,
            textDirection: pw.TextDirection.rtl,
          ),
          pw.SizedBox(width: 8),
          pw.Container(
            width: 14,
            height: 14,
            decoration: pw.BoxDecoration(
              color: PdfColor.fromInt(item.color),
              borderRadius: pw.BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }
}

class _Text extends pw.StatelessWidget {
  final String text;
  final double size;
  final bool isBold;
  final double? height;
  final PdfColor? color;
  final pw.TextAlign? align;
  final pw.TextDirection? textDirection;

  _Text({
    this.color,
    this.align,
    this.height,
    this.isBold = true,
    required this.text,
    required this.size,
    this.textDirection,
  });

  @override
  pw.Widget build(pw.Context context) {
    return pw.Text(
      text,
      textAlign: align,
      textDirection: textDirection,
      style: pw.TextStyle(
        fontSize: size,
        height: height,
        color: color ?? PdfColor.fromHex(Colors.black.hex),
        fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
      ),
    );
  }
}
