import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class InvoiceProvider {
  Future<void> downloadInvoice(String url) async {
    try {
      final http.Response response = await http.get(Uri.parse(url));

      // 2. Get the directory to save the file (in app's document directory)
      final Directory directory = await getApplicationDocumentsDirectory();
      final String filePath = '${directory.path}/invoice';

      // 3. Write the file to the path
      final File file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
    } catch (e) {
      throw Exception(e);
    }
  }
}
