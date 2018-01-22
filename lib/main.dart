import 'dart:convert';
import 'dart:io';

import 'package:xml/xml.dart' as xml;

main() async {
  var icd10s = [];

  await new File('icd10cm_tabular_2018.xml').readAsString().then((String contents) {
    var doc = xml.parse(contents);

    for (var diagnosisSection in doc.findAllElements('diag')) {
      for (var diagnosis in diagnosisSection.findAllElements('diag')) {
        icd10s.add({
          'code': diagnosis.findElements('name').elementAt(0).text,
          'desc': diagnosis.findElements('desc').elementAt(0).text,
          'terms': diagnosis.findAllElements('note').map((n) => n.text).toList(),
        });
      }
    }
  });

  await new File('icd10cm_tabular_2018.json').writeAsString(JSON.encode(icd10s));
}
