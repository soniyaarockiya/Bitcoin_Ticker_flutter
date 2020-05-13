import 'package:flutter/material.dart';

import 'coin_data.dart';

class TickerBrain {
  List<DropdownMenuItem<String>> getDropDownMenuItem() {
    List<DropdownMenuItem<String>> dropDownItemList = [];

    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropDownItemList.add(newItem);
    }

    return dropDownItemList;
  }

  List<Widget> getDropDownMenuItemCupertino() {
    List<Widget> dropDownItemList = [];

    for (String currency in currenciesList) {
      var newItem = Text(currency);
      dropDownItemList.add(newItem);
    }

    return dropDownItemList;
  }
}
