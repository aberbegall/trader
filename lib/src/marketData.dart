// Copyright (c) 2015, Agustin Berbegall. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

/// The marketStock library.
library marketData;

import 'dart:async';
import 'dart:io';

import 'package:dson/dson.dart' as dson;
import 'package:http/http.dart' as http;

import 'dto/share.dart' as dto;

Future<dto.share> getShareData(String shareID) {
  var client = new http.Client();

  return _getShareData(client, shareID)
      .whenComplete(() => client.close());
}

Future<List<dto.share>> getShareDataList(List<String> shareIDs) {
  var client = new http.Client();

  return Future
      .wait(shareIDs.map((shareID) => _getShareData(client, shareID)))
      .whenComplete(() => client.close());
}

Future<dto.share> _getShareData(http.Client client, String shareID) {
  var url = "http://finance.google.com/finance/info?q=";

  if (shareID == null) {
    throw new ArgumentError("must not be null");
  }

  return client
      .get('${url}${shareID}',
          headers: {'User-Agent': 'Dart/1.8.5 (stockShares)'})
      .then((_getShareFromResponse));
}

dto.share _getShareFromResponse(http.Response httpResponse) {
  if (httpResponse.statusCode == HttpStatus.OK) {
    return _getShareFromBody(httpResponse.body);
  } else {
    throw (httpResponse.statusCode);
  }
}

dto.share _getShareFromBody(String responseBody) {
  responseBody = _sanitizeText(responseBody);
  dto.share share = dson.fromJson(responseBody, dto.share);
  return share;
}

String _sanitizeText(String text) {
  return text
      .trim()
      .replaceAll('\n', '')
      .replaceAll('//', '')
      .replaceAll('[', '')
      .replaceAll(']', '');
}
