import 'dart:convert';

import 'package:http/http.dart' as http;

class NomicsApi {
  static const key = '37CD11FC-A4A5-47A8-81A4-9BF7FDD4C8AA';
  static const String _cryptoSymbols =
      "BTC,ETH,USDT,XRP,LINK,BCH,DOT,BNB,CRO,LTC";
  static const url = "https://rest.coinapi.io/v1";

  // GET
  Future<List> getCurrencies() async {
    String dataUrl = url + "/assets/" + _cryptoSymbols + "?apikey=$key";
    print(dataUrl);
    http.Response response = await http.get(dataUrl);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print('Error Occured');
      return null;
    }
  }
}
