import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:platform_image_issue/market/widgets/asset_card.dart';
import 'package:platform_image_issue/models/asset.dart';

class MarketCollection extends StatelessWidget {
  final List<Asset> assets;
  final Axis scrollDirection;

  const MarketCollection(this.assets, this.scrollDirection);

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch}),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return ListView.builder(
            scrollDirection: scrollDirection,
            itemExtent: 80,
            shrinkWrap: false,
            controller: ScrollController(),
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: assets.length,
            itemBuilder: (context, index) {
              return AssetCard(assets[index]);
            },
          );
        },
      ),
    );
  }
}
