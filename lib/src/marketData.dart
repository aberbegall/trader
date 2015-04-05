// Copyright (c) 2015, Agustin Berbegall Beltran. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

/// The marketStock library.
library marketData;

import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:trader/src/dto/Share.dart' as dto;
import 'package:dson/dson.dart' as dson;

Future<List<dto.Share>> getShareDataList(List<String> shareIDs) {
  var client = new http.Client();

  return Future
      .wait(shareIDs.map((shareID) => _getShareData(client, shareID)))
      .whenComplete(() => client.close());
}

Future<dto.Share> _getShareData(http.Client client, String shareID) {
  var url = "http://finance.google.com/finance/info?q=";

  return client
      .get('${url}${shareID}',
          headers: {'User-Agent': 'Dart/1.8.5 (stockShares)'})
      .then((_getShareFromResponse));
}

dto.Share _getShareFromResponse(http.Response httpResponse) {
  if (httpResponse.statusCode == HttpStatus.OK) {
    return _getShareFromBody(httpResponse.body);
  } else {
    throw (httpResponse.statusCode);
  }
}

dto.Share _getShareFromBody(String responseBody) {
  responseBody = _sanitizeText(responseBody);
  dto.Share share = dson.deserialize(responseBody, dto.Share);
  return share;
}

String _sanitizeText(String text) {
  return text
      .trim()
      .replaceAll('\n', '')
      .replaceAll('//', '')
      .replaceAll('[', '')
      .replaceAll(']', '')
      .trim();
}
