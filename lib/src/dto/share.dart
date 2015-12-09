library dto;

import 'package:dson/dson.dart';

class share extends Object{
  @Property("t")
  String name;

  @Property("l")
  String value;

  @Property("ltt")
  String timeOfTrade;

  @Property("c")
  String change;

  @Property("cp")
  String percentageChange;
}
