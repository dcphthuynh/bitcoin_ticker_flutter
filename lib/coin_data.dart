import 'package:bitcoin_ticker/networking.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


String apiKey = 'ED395DC6-2154-4CB6-837E-CDF0EEC0B718';
String coinURL = 'https://rest.coinapi.io/v1/exchangerate';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR',
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
  'BNB',
  'USDT',
  'SHIB',
];


class CoinData {

  Map<String, String> cryptoPrices = {};

  Future<dynamic> getData ({selectedCurrency}) async {
    for(String crypto in cryptoList){
      Networking networking = Networking(url: '$coinURL/$crypto/${selectedCurrency}?apikey=$apiKey');

      var coinData = await networking.getData();
      double lastPrice = coinData['rate'];
      cryptoPrices[crypto] = lastPrice.toStringAsFixed(8);
      print(cryptoPrices);

    }
    return cryptoPrices;
  }

}
