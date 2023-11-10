import 'package:dartz/dartz.dart';
import 'package:gweiland_web3/core/exceptions.dart';
import 'package:gweiland_web3/data/remote/markets/models/list_model.dart';

abstract class BaseMarketListRepo {
  Future<Either<ApiException, List<CryptoCurrencyResponse>>> getMarketListing();
}
