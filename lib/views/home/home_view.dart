import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gweiland_web3/helpers/base_screen_view.dart';
import 'package:gweiland_web3/views/home/tabs/exchanges_tab_view.dart';
import 'package:gweiland_web3/utils/strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'home_view_model.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> with BaseScreenView {
  late HomeViewModel _viewModel;
  @override
  void initState() {
    _viewModel = ref.read(marketListViewModel);
    _viewModel.attachView(this);
    _viewModel.initialise();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _viewModel = ref.watch(marketListViewModel);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _viewModel.loading
          ? null
          : Image.asset("assets/icons/metaverse.png", width: 175),
      extendBody: true,
      body: const ExchangesTabView(),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: Colors.black,
            child: SizedBox(
              height: 60,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildIcons('e-shop'),
                  _buildIcons('exchange'),
                  const SizedBox(width: 50),
                  _buildIcons('launchpads'),
                  _buildIcons('wallet'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column _buildIcons(String title) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (title == "e-shop")
          Image.asset(
            "assets/icons/$title.png",
            color: Colors.white,
            height: 16,
          )
        else
          SvgPicture.asset(
            "assets/icons/$title-logo.svg",
            color: Colors.white.withOpacity(.4),
            height: 16,
          ),
        const SizedBox(height: 4),
        if (title == "e-shop")
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: SvgPicture.asset(
              "assets/icons/$title.svg",
              color: Colors.white,
            ),
          )
        else
          Text(
            title.capitalize(),
            style: TextStyle(
                color: Colors.white.withOpacity(.4),
                fontSize: 10,
                fontWeight: FontWeight.w600),
          )
      ],
    );
  }

  @override
  void showSnackbar(String message, {Color? color}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }
}
