import 'dart:convert';
import 'package:http/http.dart' as http;

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
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const coinapiURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '58A20401-7D7D-49F8-AB20-F73809C451E8';

class CoinData {

    Future getCoinData() async{
      String requestURL = '$coinapiURL/BTC/USD?apikey=$apiKey';
      http.Response response = await http.get(requestURL);

      if(response.statusCode ==200){
        String data = response.body;
        print(data);
      
      var decodedData = jsonDecode(data);
      var lastPrice = decodedData['rate'];
      return lastPrice;
      }
      else{
        print(response.statusCode);

        throw 'Problem with get request'; //Optional
      }
    }
}
