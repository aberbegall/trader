// Copyright (c) 2015, Agustin Berbegall. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:dson/dson.dart' as dson;

import '../lib/src/dto/share.dart' as dto;
import '../lib/src/marketData.dart' as marketStockShares;
import '../lib/src/repository.dart' as repository;

main() async {
  print('Loading data...');

  var shares = new List<String>();
  shares.addAll(['INDEXBME:IB', 'BME:GAM', 'BME:GRF', 'BME:SCYR']);

  // get share data and store it
  try {
    var listOfShares = (await marketStockShares.getShareDataList(shares));
    await for (dto.share shareObject in listOfShares) {
      storeShare(shareObject);
    }
  } catch (exception) {
    print("Error when processing the list of shares");
  }
  print("All data loaded!");
}

Future storeShare(dto.share share) async {
  var redisServer = "localhost:6379/2";
  var redis = new repository.RedisRepository(redisServer);
  var shareJson = dson.toJson(share);

  (await redis.setValue(share.name, shareJson));
  (await redis.getValue(share.name));
}