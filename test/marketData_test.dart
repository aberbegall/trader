@TestOn("vm")
library test;

import 'package:test/test.dart';

import '../lib/src/marketData.dart';

main() {
  test("getShareData return a share instance", () {
    // prepare mock data
    var shareGamesa = 'BME:GAM';

    // execute
    var result = getShareData(shareGamesa);

    // evaluate
    expect(result, isNotNull);
  });

  test("getShareDataList returns a list of stock shares", () {
    // prepare mock data
    var listOfShares = new List<String>();
    listOfShares.addAll(['INDEXBME:IB', 'BME:GAM', 'BME:GRF', 'BME:SCYR']);

    // execute
    var result = getShareDataList(listOfShares);

    // evaluate
    expect(result, isNotNull);
  });
}
