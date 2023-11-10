import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gweiland_web3/data/remote/markets/market_repo.dart';
import 'package:gweiland_web3/data/remote/markets/market_repo_impl.dart';

import 'api_client_provider.dart';

final marketRepositoryProvider = Provider<BaseMarketListRepo>(
  (ref) => MarketListRepoImpl(ref.read(apiClientProvider)),
);
