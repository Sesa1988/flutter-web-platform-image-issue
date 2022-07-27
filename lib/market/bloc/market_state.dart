part of 'market_bloc.dart';

abstract class MarketState extends Equatable {
  const MarketState();

  @override
  List<Object> get props => [];
}

class MarketInitial extends MarketState {}

class AssetsLoading extends MarketState {}

class AssetsLoaded extends MarketState {
  final List<Asset> assets;

  const AssetsLoaded(this.assets);

  @override
  List<Object> get props => [assets];
}
