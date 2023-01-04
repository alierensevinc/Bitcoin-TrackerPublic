import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api_data.dart';

const List<String> currenciesList = [
  'EUR',
  'USD',
  'TRY',
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';

class CoinData {
  Future getCoinData(String selectedCurrency) async {
    Map<String, String> cryptoPrices = {};

    for (String crypto in cryptoList) {
      String requestURL =
          '$coinAPIURL/$crypto/$selectedCurrency?apikey=${ApiData().getApiKey()}';
      http.Response response = await http.get(requestURL);
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        double price = decodedData['rate'];
        cryptoPrices[crypto] = price.toStringAsFixed(0);
      } else {
        var decodedData = jsonDecode(response.body);
        String error = decodedData['error'];
        throw error;
      }
    }

    return cryptoPrices;
  }
}
