import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Asset extends Equatable {
  final String id;
  final int rank;
  final String symbol;
  final String name;
  final double priceUsd;
  final double marketCapUsd;
  final double changePercent24Hr;
  final double changePercent7Days;
  final double changePercent30Days;
  final double changePercent1Year;
  final double marketCapPercent24h;

  final double supply;
  final double maxSupply;
  final String imageUrl;
  final String imageUrlSmall;
  final List<double> sparkLine7Days;
  final DateTime pricesUpdatedAt;

  const Asset({
    required this.id,
    required this.rank,
    required this.symbol,
    required this.name,
    required this.priceUsd,
    required this.marketCapUsd,
    required this.changePercent24Hr,
    required this.changePercent7Days,
    required this.changePercent30Days,
    required this.changePercent1Year,
    required this.supply,
    required this.maxSupply,
    required this.imageUrl,
    required this.imageUrlSmall,
    required this.sparkLine7Days,
    required this.marketCapPercent24h,
    required this.pricesUpdatedAt,
  });

  bool isEmpty() {
    return id.isEmpty;
  }

  static Asset empty() {
    return Asset(
      id: '',
      rank: 0,
      symbol: '',
      name: '',
      priceUsd: 0,
      marketCapUsd: 0,
      changePercent24Hr: 0,
      changePercent30Days: 0,
      changePercent1Year: 0,
      imageUrl: '',
      imageUrlSmall: '',
      sparkLine7Days: const [],
      marketCapPercent24h: 0,
      changePercent7Days: 0,
      pricesUpdatedAt: DateTime(1900, 1, 1),
      supply: 0,
      maxSupply: 0,
    );
  }

  double getPrice(
      {required double currentCurrencyRate, required double dollarRate}) {
    return (priceUsd / dollarRate * currentCurrencyRate);
  }

  int getPriceDecimalDigets() {
    return priceUsd.abs() < 0.01
        ? 10
        : priceUsd.abs() < 1
            ? 8
            : 2;
  }

  Asset copyWith({
    String? id,
    int? rank,
    String? symbol,
    String? name,
    double? priceUsd,
    double? marketCapUsd,
    double? marketCapPercent24h,
    double? changePercent24Hr,
    double? changePercent7Days,
    double? changePercent30Days,
    double? changePercent1Year,
    String? imageUrl,
    String? imageUrlSmall,
    List<double>? sparkLine7Days,
    DateTime? pricesUpdatedAt,
    double? supply,
    double? maxSupply,
  }) {
    return Asset(
      id: id ?? this.id,
      rank: rank ?? this.rank,
      symbol: symbol ?? this.symbol,
      name: name ?? this.name,
      priceUsd: priceUsd ?? this.priceUsd,
      marketCapUsd: marketCapUsd ?? this.marketCapUsd,
      changePercent24Hr: changePercent24Hr ?? this.changePercent24Hr,
      changePercent30Days: changePercent30Days ?? this.changePercent30Days,
      changePercent1Year: changePercent1Year ?? this.changePercent1Year,
      imageUrl: imageUrl ?? this.imageUrl,
      imageUrlSmall: imageUrlSmall ?? this.imageUrlSmall,
      sparkLine7Days: sparkLine7Days ?? this.sparkLine7Days,
      marketCapPercent24h: marketCapPercent24h ?? this.marketCapPercent24h,
      changePercent7Days: changePercent7Days ?? this.changePercent7Days,
      pricesUpdatedAt: pricesUpdatedAt ?? this.pricesUpdatedAt,
      supply: supply ?? this.supply,
      maxSupply: maxSupply ?? this.maxSupply,
    );
  }

  factory Asset.fromJson(Map<String, dynamic> json) {
    var rankJson = json['market_cap_rank'];
    var rank = int.tryParse(rankJson == null ? '0' : rankJson.toString()) ?? 0;

    var priceJson = json['current_price'];
    var price =
        double.tryParse(priceJson == null ? '0.0' : priceJson.toString()) ??
            0.0;

    var marketCapJson = json['market_cap'];
    var marketCap = double.tryParse(
            marketCapJson == null ? '0.0' : marketCapJson.toString()) ??
        0.0;

    var marketCapChange24hJson = json['market_cap_change_percentage_24h'];
    var marketCapChange24h = double.tryParse(marketCapChange24hJson == null
            ? '0.0'
            : marketCapChange24hJson.toString()) ??
        0.0;

    var changePercent24HrJson = json['price_change_percentage_24h'];
    var changePercent24Hr = double.tryParse(changePercent24HrJson == null
            ? '0.0'
            : changePercent24HrJson.toString()) ??
        0.0;

    var changePercent7DaysJson = json['price_change_percentage_7d_in_currency'];
    var changePercent7Days = double.tryParse(changePercent7DaysJson == null
            ? '0.0'
            : changePercent7DaysJson.toString()) ??
        0.0;

    var changePercent30DaysJson =
        json['price_change_percentage_30d_in_currency'];
    var changePercent30Days = double.tryParse(changePercent30DaysJson == null
            ? '0.0'
            : changePercent30DaysJson.toString()) ??
        0.0;

    var changePercent1YearJson = json['price_change_percentage_1y_in_currency'];
    var changePercent1Year = double.tryParse(changePercent1YearJson == null
            ? '0.0'
            : changePercent1YearJson.toString()) ??
        0.0;

    var supplyJson = json['circulating_supply'];
    var supply =
        double.tryParse(supplyJson == null ? '0.0' : supplyJson.toString()) ??
            0.0;

    var maxSupplyJson = json['max_supply'];
    var maxSupply = double.tryParse(
            maxSupplyJson == null ? '0.0' : maxSupplyJson.toString()) ??
        0.0;
    List<double> recalcSpark7Days = [];
    if (json['sparkline_in_7d'] != null) {
      var sparkPrice = json['sparkline_in_7d'];
      var spark7Days = (sparkPrice['price'] as List<dynamic>).cast<double>();
      var skipAmount = spark7Days.length - 23;
      var chartLast24H =
          spark7Days.skip(skipAmount < 0 ? 0 : skipAmount).toList();

      var index = 0;
      for (var x in chartLast24H) {
        if (index % 2 == 0 || index == chartLast24H.length || index == 0) {
          recalcSpark7Days.add(x);
        }
        index++;
      }
      chartLast24H.add(price);
    }

    return Asset(
      id: json['id'],
      rank: rank,
      symbol: json['symbol'],
      name: json['name'],
      priceUsd: price,
      marketCapUsd: marketCap,
      marketCapPercent24h: marketCapChange24h,
      changePercent7Days: changePercent7Days,
      changePercent24Hr: changePercent24Hr,
      changePercent30Days: changePercent30Days,
      changePercent1Year: changePercent1Year,
      supply: supply,
      maxSupply: maxSupply,
      imageUrl: json['image'],
      imageUrlSmall:
          json['image'].toString().replaceFirst('/large/', '/small/'),
      sparkLine7Days: recalcSpark7Days,
      pricesUpdatedAt:
          DateTime.parse(json['last_updated'] ?? DateTime.now().toString()),
    );
  }

  @override
  List<Object> get props => [
        id,
        rank,
        symbol,
        name,
        priceUsd,
        marketCapUsd,
        changePercent24Hr,
        changePercent7Days,
        changePercent30Days,
        changePercent1Year,
        marketCapPercent24h,
        supply,
        maxSupply,
        imageUrl,
        imageUrlSmall,
        sparkLine7Days,
        pricesUpdatedAt,
      ];
}
