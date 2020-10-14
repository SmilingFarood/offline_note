import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:share_extend/share_extend.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class ExternalHelpers with ChangeNotifier {
  Future<String> shareNote({String id, String title, String content}) async {
    var document = PdfDocument();
    PdfPage page = document.pages.add();
    // PdfFont font = PdfStandardFont(PdfFontFamily.courier, 20);
    // Size titleSize = font.measureString(title);
    // Size contentSize = font.measureString(content);

    // title text
    PdfTextElement(
        text: title,
        font: PdfStandardFont(
          PdfFontFamily.courier,
          30,
          multiStyle: [
            PdfFontStyle.bold,
            PdfFontStyle.underline,
          ],
        )).draw(
      page: page,
      bounds: Rect.fromLTWH(
          0, 0, double.infinity / 2, page.getClientSize().height / 2),
    );

    PdfTextElement(
        text: content,
        font: PdfStandardFont(
          PdfFontFamily.courier,
          15,
          // multiStyle: [
          //   PdfFontStyle.bold,
          //   PdfFontStyle.underline,
          // ],
        )).draw(
      page: page,
      bounds: Rect.fromLTWH(
          0, 35, double.infinity / 2, page.getClientSize().height / 2),
    );

    var bytes = document.save();
    document.dispose();

    Directory directory = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();

    String path = directory.path;

    File file = File('$path/$title.pdf');

    await file.writeAsBytes(bytes, flush: true);
    return '$path/$title.pdf';
    // OpenFile.open('$path/$title.pdf');
  }

  Future<void> shareMyNote({String id, String title, String content}) async {
    String generatedPath =
        await shareNote(id: id, title: title, content: content);

    ShareExtend.share(generatedPath, 'file');
  }

  Future<void> openMyNoteAsPdf(
      {String id, String title, String content}) async {
    String generatedPath =
        await shareNote(id: id, title: title, content: content);
    OpenFile.open(generatedPath);
  }
}
