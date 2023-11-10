import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:gweiland_web3/core/api_client.dart';
import 'package:gweiland_web3/core/exceptions.dart';
import 'package:gweiland_web3/data/remote/markets/market_repo.dart';
import 'package:gweiland_web3/data/remote/markets/models/list_model.dart';

class MarketListRepoImpl implements BaseMarketListRepo {
  final ApiClient _apiClient;

  MarketListRepoImpl(this._apiClient);
  @override
  Future<Either<ApiException, List<CryptoCurrencyResponse>>>
      getMarketListing() async {
    try {
      final response = await _apiClient.get(
        "/${ApiClient.MARKETS}?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false&locale=en",
      );
      return Right(cryptoCurrencyResponseFromJson(jsonEncode(response.data!)));
    } catch (e) {
      return Left(ApiException(e.toString()));
    }
  }
}
