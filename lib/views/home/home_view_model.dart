import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gweiland_web3/data/remote/markets/market_repo.dart';
import 'package:gweiland_web3/data/remote/markets/models/list_model.dart';
import 'package:gweiland_web3/domain/providers/repository_provider.dart';
import 'package:gweiland_web3/helpers/base_screen_view.dart';
import 'package:gweiland_web3/helpers/base_view_model.dart';

final marketListViewModel = ChangeNotifierProvider.autoDispose(
  (ref) => HomeViewModel(
    ref.read(marketRepositoryProvider),
  ),
);

class HomeViewModel extends BaseViewModel<BaseScreenView> {
  final BaseMarketListRepo _marketListRepo;
  List<CryptoCurrencyResponse>? _newsListResponse;
  List<CryptoCurrencyResponse>? get newsListResponse => _newsListResponse;
  HomeViewModel(this._marketListRepo);
  Future<void> initialise() async {
    await _marketListRepo.getMarketListing().then(
          (value) => value.fold((l) {
            view?.showSnackbar(l.message);
          }, (r) {
            _newsListResponse = r;
          }),
        );
    toggleLoading();
  }
}
