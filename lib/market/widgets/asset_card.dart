import 'package:flutter/material.dart';
import 'package:platform_image_issue/market/widgets/asset_card_image.dart';
import 'package:platform_image_issue/models/asset.dart';

class AssetCard extends StatelessWidget {
  final Asset _asset;

  const AssetCard(this._asset);

  @override
  Widget build(BuildContext context) {
    var borderWidth = 1.0 / MediaQuery.of(context).devicePixelRatio;
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
              width: borderWidth, color: Theme.of(context).dividerColor),
          bottom: BorderSide(width: borderWidth, color: Colors.transparent),
        ),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          AssetCardImage(_asset.imageUrlSmall),
        ],
      ),
    );
  }
}
