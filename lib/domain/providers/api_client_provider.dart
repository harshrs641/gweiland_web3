import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gweiland_web3/core/api_client.dart';

final apiClientProvider = Provider<ApiClient>((ref) => ApiClient());