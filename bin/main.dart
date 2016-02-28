// Copyright (c) 2015, Agustin Berbegall. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:dson/dson.dart' as dson;

import '../lib/src/dto/share.dart' as dto;
import '../lib/src/marketData.dart' as marketStockShares;
import '../lib/src/repository.dart' as repository;

main() async {
  print('Loading data...');

  var listOfShares = new List<String>();
  listOfShares.addAll(['INDEXBME:IB', 'BME:GAM', 'BME:GRF', 'BME:SCYR']);

  // get share data and store it
  try {
    var list = (await marketStockShares.getShareDataList(listOfShares));
    await for (dto.share share in list) {
      storeShare(share);
    }
  } catch (exception) {
    print("Error when trying to data, error description: $exception");
  }
  print("All data loaded!");
}

void storeShare(dto.share share) {
  var redisServer = "localhost:6379/2";
  var redis = new repository.RedisRepository(redisServer);
  var shareJson = dson.toJson(share);
  redis.setValue(share.name, shareJson).then((_) => redis.getValue(share.name));
}