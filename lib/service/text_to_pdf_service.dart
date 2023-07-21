import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:open_file/open_file.dart';

class TextToPdfService {
  static TextToPdfService _instance = TextToPdfService();

  static TextToPdfService getInstance(){
    return _instance;
  }
Future<void> createPdf(String text) async{
    final pdf = pw.Document();
    final emoji = await PdfGoogleFonts.notoColorEmoji();

    pdf.addPage(pw.Page(
    pageFormat: PdfPageFormat.a4,
    build: (pw.Context context) {
      return pw.Center(
        child: pw.Text(
         text,
          style: pw.TextStyle(
            fontFallback: [emoji],
            fontSize: 25,
          ),
        ),
      ); // Center
    }));
    final appDir = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationSupportDirectory();
    
    final localPath = path.join(appDir!.path, "todo-mor.pdf");
    final file = File(localPath);
  
    await file.writeAsBytes(await pdf.save());

    OpenFile.open(file.path);
  }

}