import 'package:budget_app/reflector.dart';
import 'package:flutter/foundation.dart';

@reflector
abstract class Model {
  Map<String, dynamic> toMap();
  //Model fromJson(Map<String, dynamic> map);
  Model(String s);
}
