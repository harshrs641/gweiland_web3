import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gweiland_web3/data/remote/markets/models/list_model.dart';

import 'utils/crypto_colors.dart';

class TopCrytoCard extends StatelessWidget {
  final CryptoCurrencyResponse cryptoDatum;
  const TopCrytoCard({super.key, required this.cryptoDatum});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color:
              CryptoColors.getPercentColor(cryptoDatum.priceChangePercentage24H)
                  .withOpacity(.1)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Image.network(
                  cryptoDatum.image ?? "",
                  width: 48,
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cryptoDatum.symbol!.toUpperCase(),
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                    ),
                    Text(
                      cryptoDatum.name!,
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "\$${cryptoDatum.currentPrice?.toStringAsFixed(0) ?? "0.0"} USD",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    Text(
                        "${cryptoDatum.priceChangePercentage24H?.toStringAsFixed(1) ?? "0.0"}%",
                        style: TextStyle(
                            color: CryptoColors.getPercentColor(
                                cryptoDatum.priceChangePercentage24H),
                            fontWeight: FontWeight.w700,
                            fontSize: 13)),
                  ],
                )
              ],
            ),
          ),
          SvgPicture.asset(
            "assets/icons/crypto_card_bottom.svg",
            fit: BoxFit.fill,
            color: CryptoColors.getPercentColor(
                cryptoDatum.priceChangePercentage24H),
            width: MediaQuery.of(context).size.width,
          )
        ],
      ),
    );
  }
}
