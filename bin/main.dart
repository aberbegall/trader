// Copyright (c) 2015, Agustin Berbegall. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:dson/dson.dart' as dson;

import '../lib/src/dto/share.dart' as dto;
import '../lib/src/marketData.dart' as marketStockShares;
import '../lib/src/repository.dart' as repository;

main() {
  print('Loading data...');

  var listOfShares = new List<String>();
  listOfShares.addAll(['INDEXBME:IB', 'BME:GAM', 'BME:GRF', 'BME:SCYR']);

  // get share data and store it
  marketStockShares
      .getShareDataList(listOfShares)
      .then(storeShareDataList)
      .whenComplete(() {
    print("All data loaded!");
    exit(0);
  }).catchError(onErrorGettingData);
}

void storeShareDataList(List<dto.share> shares) {
  shares.forEach(storeShare);
}

void storeShare(dto.share share) {
  var redisServer = "localhost:6379/2";
  var redis = new repository.RedisRepository(redisServer);
  var shareJson = dson.toJson(share);
  redis
      .setValue(share.name, shareJson)
      .then((_) => redis.getValue(share.name));
}

void onErrorGettingData(int error) {
  print("Error when getting data, error code: $error");
}
