import 'package:bitcoin_ticker/coin_data.dart';

import 'networkCall.dart';

class ApiService {
  String apiKey = "A99BFEF2-6403-44A2-8DB9-AA0960AD9C5B";

  NetworkCall _networkCall = new NetworkCall();

  Future<Map<String, String>> getOneExchangeRate(String currency) async {
    Map<String, String> cryptoPriceList = {};

    for (String crypto in cryptoList) {
      String url =
          "https://rest.coinapi.io/v1/exchangerate/${crypto.toUpperCase().toString()}/${currency.toString().toUpperCase()}?apikey=$apiKey";
      dynamic response = await _networkCall.getResponse(url);
      double rate = response['rate'];
      print(rate);
      print(crypto);
      cryptoPriceList[crypto] = rate.toStringAsFixed(0);
    }

    return cryptoPriceList;
  }
}
