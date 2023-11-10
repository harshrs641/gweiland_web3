import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gweiland_web3/top_crypto_card.dart';
import 'package:gweiland_web3/utils/crypto_colors.dart';
import 'package:gweiland_web3/views/home/home_view_model.dart';

class ExchangesTabView extends ConsumerStatefulWidget {
  const ExchangesTabView({super.key});

  @override
  ConsumerState<ExchangesTabView> createState() => _ExchangesTabViewState();
}

class _ExchangesTabViewState extends ConsumerState<ExchangesTabView> {
  late HomeViewModel _viewModel;
  @override
  Widget build(BuildContext context) {
    _viewModel = ref.watch(marketListViewModel);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          "Exchanges",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: SvgPicture.asset("assets/icons/bell.svg")),
          IconButton(
              onPressed: () {},
              icon: SvgPicture.asset("assets/icons/settings.svg")),
        ],
      ),
      body: _viewModel.newsListResponse == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        children: [
                          const Text(
                            "Cryptocurrency",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 20),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Text(
                            "NFT",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                color: CryptoColors.grey),
                          ),
                        ],
                      ),
                    ),
                    TopCrytoCard(
                      cryptoDatum: _viewModel.newsListResponse![0],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Top Cryptocurrencies',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        Text("View All",
                            style: TextStyle(
                                fontSize: 13, color: CryptoColors.grey))
                      ],
                    ),
                    ...List.generate(_viewModel.newsListResponse!.length,
                        (index) {
                      final element = _viewModel.newsListResponse![index];
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Row(
                          children: [
                            Text(element.symbol?.toUpperCase() ?? "",
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600)),
                            const SizedBox(width: 12),
                            if ((element.priceChangePercentage24H ?? 0) < 0)
                              SvgPicture.asset("assets/icons/low.svg")
                            else
                              SvgPicture.asset("assets/icons/high.svg")
                          ],
                        ),
                        leading: ClipOval(
                          child: Image.network(
                            element.image ?? "",
                            height: 48,
                          ),
                        ),
                        subtitle: Text(element.name ?? "",
                            style: TextStyle(
                                fontSize: 13, color: CryptoColors.grey)),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "\$${element.currentPrice?.toString() ?? "0.0"}",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              "${element.priceChangePercentage24H?.toStringAsFixed(1) ?? "0.0"}%",
                              style: TextStyle(
                                  color: CryptoColors.getPercentColor(
                                      element.priceChangePercentage24H),
                                  fontSize: 13),
                            ),
                          ],
                        ),
                      );
                    })
                  ],
                ),
              ),
            ),
    );
  }

  Row _buildHeader() {
    return Row(
      children: [
        Expanded(
          child: _buildSearch(),
        ),
        const SizedBox(width: 16),
        _buildFilter()
      ],
    );
  }

  Container _buildFilter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400, width: 1.5),
          borderRadius: BorderRadius.circular(24)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset("assets/icons/filter.svg"),
          const SizedBox(width: 6),
          Text(
            "Filter",
            style: TextStyle(color: CryptoColors.grey),
          )
        ],
      ),
    );
  }

  TextFormField _buildSearch() {
    return TextFormField(
      style: const TextStyle(
        fontSize: 13,
      ),
      decoration: InputDecoration(
        hintText: "Search Cryptocurrency",
        hintStyle: TextStyle(color: CryptoColors.grey, fontSize: 13),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(16),
          child: SvgPicture.asset(
            "assets/icons/search.svg",
            width: 10,
            height: 10,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(48),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        filled: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      ),
    );
  }
}
