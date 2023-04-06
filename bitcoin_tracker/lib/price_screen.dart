import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'services/coin_price.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


class PriceScreen extends StatefulWidget {
  const PriceScreen({Key? key}) : super(key: key);

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  var coinPrice = CoinPrice();
  String selectedCurrency = 'USD';
  String BTCRate = '?';
  String ETHRate = '?';
  String LTCRate = '?';


  DropdownButton<String> getDropDownButton(context){
    return DropdownButton<String>(
          value: selectedCurrency,
        iconEnabledColor: Colors.white,
        items: currenciesList.map((currency) => buildDropdownMenuItem(currency)).toList()
        ,
        onChanged: (value){
            setState(() {
              selectedCurrency = value!;
              // currencyRate = rate.toString();
              getData(context);

                });
          });}


    bool isWaiting = false;



  void getData(context) async{
    isWaiting = true;
    try{
      var data = await coinPrice.getPriceByCurrency(selectedCurrency);
      isWaiting = false;
      setState(() {
        print(data);
        BTCRate = data[0];
        ETHRate = data[1];
        LTCRate = data[2];
      });
    }
    catch(e){
      print(e);

      AlertDialog alert = AlertDialog(
            title: Text("Internet is not Working"),
            content: Text("Please Connect to the Internet"),
          );

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return alert;
            },
          );
      // Alert(
      //   context: context,
      //   title: 'Finished!',
      //   desc: 'You\'ve reached the end of the quiz.',
      // ).show();
    }
  }

  @override
  void initState() {
    super.initState();
    getData(context);
  }

  CupertinoPicker getCupertinoPicker(context){
    return CupertinoPicker(itemExtent: 32, onSelectedItemChanged:(selectedIndex){
      setState(() {
        getData(context);
      });
    }, children: currenciesList.map((currency) => buildDropdownMenuItem(currency)).toList() );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, 
            children: [
              makecard('BTC',BTCRate),
              makecard("ETH",ETHRate),
              makecard('LTC',LTCRate),
            ],
          ),

          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isAndroid ?getDropDownButton(context)
            : getCupertinoPicker(context),
          ),
        ],
      ),
    );
  }

  Padding makecard(String coinName,String coinPrice) {
    return Padding(
          padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
          child: Card(
            color: Colors.lightBlueAccent,
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
              child: Text(
                '1 $coinName = $coinPrice $selectedCurrency',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
  }

  DropdownMenuItem<String> buildDropdownMenuItem(currency) {
    return DropdownMenuItem(
                  child: Text(currency),
                  value: currency,
                );
  }
}
