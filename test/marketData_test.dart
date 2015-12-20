@TestOn("vm")

library test;

import 'package:trader/src/marketData.dart';
import 'package:test/test.dart';

// test the getShareData for a specific shared id.

main(){
  test("getShareData Async returns a list of stock shares", (){
    var listOfShares = new List<String>();
    listOfShares.addAll(['INDEXBME:IB', 'BME:GAM', 'BME:GRF', 'BME:SCYR']);

    getShareDataList(listOfShares).then((value) => expect(value, isNotNull));
  });
}