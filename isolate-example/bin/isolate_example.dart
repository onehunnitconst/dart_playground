import 'dart:core';
import 'dart:isolate';

import 'package:isolate_example/article_fetcher.dart';
import 'package:isolate_example/article_file.dart';
import 'package:isolate_example/constants.dart';

final fetcher =
    ArticleFetcher('https://$apiKey.mockapi.io/api/v1');

void main(List<String> arguments) async {
  Stream<Future<String> Function()> runStream = getRunStream(10);

  mainRun(1).then((readData) {
    print(readData);
  });

  runStream.forEach((isoRun) async {
    final readData = await Isolate.run(() => isoRun());
    print(readData);
  });
}

Future<String> mainRun(int userId) async {
  final file = ArticleFile('dest/user_$userId.json');

  final jsonData = await fetcher.findUser(userId);

  await file.write(jsonData);

  return await file.read();
}

Future<String> isolateRun(int articleId) async {
  final file = ArticleFile('dest/article_$articleId.json');

  final jsonData = await fetcher.findArticle(articleId);

  await file.write(jsonData);

  return await file.read();
}

Stream<Future<String> Function()> getRunStream(int length) async* {
  for (int i = 0; i < length; i++) {
    yield () => isolateRun(i + 1);
  }
}
