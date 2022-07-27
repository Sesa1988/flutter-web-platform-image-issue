import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform_image_issue/market/bloc/market_bloc.dart';
import 'package:platform_image_issue/market/market.dart';
import 'package:platform_image_issue/market/services/market_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Platform Image Issue',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => MarketBloc(MarketService()),
        child: const Market(),
      ),
    );
  }
}
