// Copyright (c) 2015, Agustin Berbegall. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import '../lib/src/marketData.dart' as marketStockShares;
import '../lib/src/persistence.dart' as persistence;
import '../lib/src/dto/share.dart' as dto;

main() {
  print('Loading data . . .\n');

  var listOfShares = new List<String>();
  listOfShares.addAll(['INDEXBME:IB', 'BME:GAM', 'BME:GRF', 'BME:SCYR']);

  // gets share data and stores it
  marketStockShares
      .getShareDataList(listOfShares)
      .then(storeShareDataList)
      .whenComplete(() {
    print("All data loaded! :)\n");
  }).catchError(onErrorGettingData);
}

void storeShareDataList(List<dto.share> shares) {
  shares.forEach(storeShare);
}

void storeShare(dto.share share) {
  var redisServer = "localhost:6379/2";
  var redis = new persistence.RedisPersistence(redisServer);
  redis
      .setValue(share.name, share.value)
      .then((_) => redis.getValue(share.name));
}

void onErrorGettingData(int error) {
  print("Error when getting data, error code: $error");
}
