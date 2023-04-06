import 'dart:io';

import 'network_helper.dart';
import 'package:bitcoin_tracker/coin_data.dart';

class CoinPrice{
  static const apiKey = '7C440544-A01C-4C8A-A237-DD5F0BBF13BE';
  String startUrl ='https://rest.coinapi.io/v1/exchangerate';

  Future getPriceByCurrency(currency) async {
    List<String> cryptoNames = [];
    for(String coin in cryptoList){
      String url ='$startUrl/$coin/$currency?apikey=$apiKey';

      NetworkHelper networkHelper = NetworkHelper(url);

      var currencyRate = await networkHelper.getData();
      print(url);
      cryptoNames.add(currencyRate);

      // else{
      //     AlertDialog alert = AlertDialog(
      //       title: Text("Internet is not Working"),
      //       content: Text("Please Connect to the Internet"),
      //     );
      //     showDialog(
      //       context: context,
      //       builder: (BuildContext context) {
      //         return alert;
      //       },
      //     );
      // }


    }

    return cryptoNames;


}}

// const List<String> cryptoList = ['BTC', 'ETH', 'LTC'];
//
// const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
// const apiKey = 'YOUR-API-KEY-HERE';
//
// class CoinData {
//   Future getCoinData(String selectedCurrency) async {
//     Map<String, String> cryptoPrices = {};
//     for (String crypto in cryptoList) {
//       String requestURL =
//           '$coinAPIURL/$crypto/$selectedCurrency?apikey=$apiKey';
//       http.Response response = await http.get(requestURL);
//       if (response.statusCode == 200) {
//         var decodedData = jsonDecode(response.body);
//         double price = decodedData['rate'];
//         cryptoPrices[crypto] = price.toStringAsFixed(0);
//       } else {
//         print(response.statusCode);
//         throw 'Problem with the get request';
//       }
//     }
//     return cryptoPrices;
//   }
// }