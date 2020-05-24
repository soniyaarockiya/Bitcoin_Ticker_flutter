import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'subWidgets/cryptoCard.dart';

import 'coin_data.dart';
import 'services/apiService.dart';
import 'tickerBrain.dart';

import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  ApiService _apiService = new ApiService();
  TickerBrain _tickerBrain = new TickerBrain();
  String currentCurrency = 'INR';
  String currentRate = '0';
  Map<String, String> cryptoRate = {};

  @override
  void initState() {
    super.initState();
    getExchangeRate(currentCurrency);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          makeCards(),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iosPicker() : androidDropDownMenu(),
          ),
        ],
      ),
    );
  }

  Widget androidDropDownMenu() {
    List<DropdownMenuItem<String>> dropDownItem;
    dropDownItem = _tickerBrain.getDropDownMenuItem();
    return DropdownButton(
      items: dropDownItem,
      value: currentCurrency,
      onChanged: (value) {
        setState(() {
          currentCurrency = value;
          getExchangeRate(currentCurrency);
        });
      },
    );
  }

  CupertinoPicker iosPicker() {
    List<Widget> dropDownItem;
    dropDownItem = _tickerBrain.getDropDownMenuItemCupertino();

    return CupertinoPicker(
        backgroundColor: Colors.lightBlue,
        itemExtent: 40.0,
        onSelectedItemChanged: (selectedIndex) {
          setState(() {
            currentCurrency = currenciesList[selectedIndex];
            print(currentCurrency);
            getExchangeRate(currentCurrency);
          });
        },
        children: dropDownItem);
  }

  Column makeCards() {
    List<CryptoCard> cryptoCardList = [];
    for (String crypto in cryptoList) {
      cryptoCardList.add(CryptoCard(
        currentCrypto: crypto,
        currentCurrency: currentCurrency,
        currentRate: cryptoRate[crypto],
      ));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: cryptoCardList,
    );
  }

  void getExchangeRate(String currentCurrencyNew) async {
    Map<String, String> rate =
        await _apiService.getOneExchangeRate(currentCurrencyNew);
    setState(() {
      cryptoRate = rate;
    });
  }
}
