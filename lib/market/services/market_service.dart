import 'dart:async';
import 'dart:convert';
import 'package:platform_image_issue/models/asset.dart';

import 'package:http/http.dart';
import 'package:retry/retry.dart';

abstract class IMarketService {
  Future<List<Asset>> getAssets(
    int offset,
    String currencyName, {
    required List<String> ids,
    int perPage = 200,
    showSparkline = true,
  });
}

class MarketService implements IMarketService {
  @override
  Future<List<Asset>> getAssets(
    int offset,
    String currencyName, {
    required List<String> ids,
    perPage = 200,
    showSparkline = true,
  }) async {
    ids = ids.isEmpty ? [] : ids;

    final params = {
      'ids': ids.join(','),
      'vs_currency': currencyName,
      'order': 'market_cap_desc',
      'per_page': perPage.toString(),
      'page': (offset / perPage + 1).toString(),
      'sparkline': showSparkline.toString(),
      'price_change_percentage': '24h,7d,30d,1y'
    };

    final response = await retry(
      () => Client()
          .get(Uri.https(
            'api.coingecko.com',
            '/api/v3/coins/markets',
            params,
          ))
          .timeout(const Duration(seconds: 15)),
      retryIf: (e) => e is TimeoutException,
    );

    if (response.statusCode == 200) {
      var bodyResponse = json.decode(response.body);
      Iterable data = bodyResponse;

      return List<Asset>.from(
        data.map((model) => Asset.fromJson(model)),
      );
    } else {
      return [];
    }
  }
}
