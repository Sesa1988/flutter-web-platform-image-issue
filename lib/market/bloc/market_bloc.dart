import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform_image_issue/market/services/market_service.dart';
import 'package:platform_image_issue/models/asset.dart';

part 'market_event.dart';
part 'market_state.dart';

class MarketBloc extends Bloc<MarketEvent, MarketState> {
  final IMarketService _marketService;

  List<Asset> _assets = [];

  MarketBloc(this._marketService) : super(MarketInitial()) {
    on<GetAssets>((event, emit) => _getAssets(event, emit));
  }

  Future<void> _getAssets(
    GetAssets event,
    Emitter<MarketState> emit,
  ) async {
    emit(AssetsLoading());

    if (_assets.isEmpty) {
      var newAssets = await _marketService.getAssets(0, 'USD', ids: [])
        ..sort((a, b) => a.rank.compareTo(b.rank));

      _assets = _assets + newAssets;
    }

    emit(AssetsLoaded(_assets));
  }
}
