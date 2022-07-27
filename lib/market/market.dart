import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform_image_issue/market/bloc/market_bloc.dart';
import 'package:platform_image_issue/market/widgets/market_collection.dart';

class Market extends StatefulWidget {
  const Market({Key? key}) : super(key: key);

  @override
  _MarketState createState() => _MarketState();
}

class _MarketState extends State<Market> with AutomaticKeepAliveClientMixin {
  late Completer<void> _refreshCompleter;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();

    context.read<MarketBloc>().add(GetAssets());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: BlocConsumer<MarketBloc, MarketState>(
        listener: (context, state) {
          if (state is AssetsLoaded) {
            _refreshCompleter.complete();
            _refreshCompleter = Completer();
          }
        },
        builder: (context, state) {
          if (state is AssetsLoading) {
            return const CircularProgressIndicator();
          }
          if (state is AssetsLoaded) {
            return Column(
              children: [
                Container(
                  color: Colors.yellow,
                  height: 80,
                  child: MarketCollection(state.assets, Axis.horizontal),
                ),
                const SizedBox(height: 20),
                Container(
                  color: Colors.orange,
                  height: 80,
                  child: MarketCollection(state.assets, Axis.horizontal),
                ),
                const SizedBox(height: 20),
                Container(
                  color: Colors.blue[200],
                  height: 80,
                  child: MarketCollection(state.assets, Axis.horizontal),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Container(
                    color: Colors.green[200],
                    child: MarketCollection(state.assets, Axis.vertical),
                  ),
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
