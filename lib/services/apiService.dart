import 'networkCall.dart';

class ApiService {
  String apiKey = "FC9E8FB6-B3C2-4324-B10D-4FFB4BE517D1";

  NetworkCall _networkCall = new NetworkCall();

  Future<String> getOneExchangeRate(String currency) async {
    String url =
        "https://rest.coinapi.io/v1/exchangerate/BTC/${currency.toString().toUpperCase()}?apikey=$apiKey";
//    https://rest.coinapi.io/v1/exchangerate/BTC/SGD?apikey=FC9E8FB6-B3C2-4324-B10D-4FFB4BE517D

    dynamic response = await _networkCall.getResponse(url);
    double rate = response['rate'];

    return rate.toInt().toString();
  }
}
