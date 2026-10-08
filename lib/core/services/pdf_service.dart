import 'dart:typed_data';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfService {
  const PdfService();

  /// Converts the document to PDF bytes.
  static Future<Uint8List> toBytes(pw.Document document) {
    return document.save();
  }

  /// Opens the system share sheet with the PDF attached.
  static Future<void> share(
    pw.Document document, {
    String fileName = 'report.pdf',
  }) async {
    final bytes = await toBytes(document);
    await Printing.sharePdf(bytes: bytes, filename: fileName);
  }

  /// Opens the system print / "Save as PDF" dialog so the user can
  /// save the file to their device.
  static Future<void> download(
    pw.Document document, {
    String fileName = 'report.pdf',
  }) async {
    final bytes = await toBytes(document);
    await Printing.layoutPdf(name: fileName, onLayout: (_) async => bytes);
  }
}