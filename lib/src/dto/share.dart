library dto;

import 'package:dson/dson.dart';

@serializable
class share extends Object{
  @SerializedName("t")
  String name;

  @SerializedName("l")
  String value;

  @SerializedName("ltt")
  String timeOfTrade;

  @SerializedName("c")
  String change;

  @SerializedName("cp")
  String percentageChange;
}
