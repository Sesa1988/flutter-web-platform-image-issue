import 'dart:html';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class AssetCardImage extends StatelessWidget {
  final String _url;

  const AssetCardImage(this._url);

  @override
  Widget build(BuildContext context) {
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      _url,
      (int _) => ImageElement()..src = _url,
    );
    return Container(
      color: Colors.red,
      height: 40,
      width: 40,
      child: HtmlElementView(viewType: _url),
    );
  }
}
