import 'dart:convert';
import 'dart:io';

class ArticleFile {
  final File _file;

  ArticleFile(String path) : _file = File(path);

  Future<File> write(Object? object) {
    return _file.writeAsString(jsonEncode(object));
  }

  Future<String> read() async {
    return _file.readAsString();
  }
}
