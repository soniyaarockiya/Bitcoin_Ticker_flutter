import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'coin_data.dart';
import 'services/apiService.dart';
import 'tickerBrain.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
//  List<DropdownMenuItem<String>> dropDownItem;
  ApiService _apiService = new ApiService();

  List<Widget> dropDownItem;

  TickerBrain _tickerBrain = new TickerBrain();
  String currentCurrency = 'INR';
  String currentRate = '0';

  @override
  void initState() {
    super.initState();
    //You can also directly specify this in the item: property in DropDownButton, as in getDropDown method
    dropDownItem = _tickerBrain.getDropDownMenuItemCupertino();
//    dropDownItem = _tickerBrain.getDropDownMenuItem();
    getExchangeRate(currentCurrency);
  }

  void getExchangeRate(String currentCurrencyNew) async {
    String rate = await _apiService.getOneExchangeRate(currentCurrencyNew);
    setState(() {
      currentRate = rate;
    });
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
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $currentRate $currentCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: CupertinoPicker(
                  backgroundColor: Colors.lightBlue,
                  itemExtent: 40.0,
                  onSelectedItemChanged: (selectedIndex) {
                    setState(() {
                      currentCurrency = currenciesList[selectedIndex];
                      print(currentCurrency);
                      getExchangeRate(currentCurrency);
                    });
                  },
                  children: dropDownItem)
//            child: DropdownButton(
//              items: dropDownItem,
//              value: currentCurrency,
//              onChanged: (value) {
//                setState(() {
//                  currentCurrency = value;
//                  getExchangeRate(currentCurrency);
//                });
//              },
//            ),
          ),
        ],
      ),
    );
  }
}
