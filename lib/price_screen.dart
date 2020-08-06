import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform; //To check on which OS our app is running.

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
String selectedCurrency = 'AUD';

  DropdownButton<String> androidDropDown(){
    List <DropdownMenuItem<String>> dropdownItems = [];
    for(String currency in currenciesList){
       var newItem = DropdownMenuItem(child: Text(
         currency, style: TextStyle(color: Colors.white),),
         value: currency,);
         dropdownItems.add(newItem);
    }
    return DropdownButton <String>(value: selectedCurrency, //starting value.
            items: dropdownItems, onChanged: (value){
              setState(() {
                getData();
              selectedCurrency = value;
              //print(value);
              },);
            },);
  }

  CupertinoPicker iOSPicker(){
    List <Text> pickerItems = [];
    for (String currency in currenciesList){
      pickerItems.add(Text(currency, style: TextStyle(color: Colors.white),));
    }
    return CupertinoPicker(itemExtent: 32.0, onSelectedItemChanged: (selectedIndex){
              print(selectedIndex);
              setState(() {
                selectedCurrency = currenciesList[selectedIndex];
                getData();
              });
            }, children: pickerItems,
            );
  }

  String bitcoinValue = '?';
  String etheriumValue = '?';
  String litecoinValue = '?';


  void getData()async {
    try {
      double dataBTC = await CoinData().getCoinDataBTC(selectedCurrency);
      double dataETH = await CoinData().getCoinDataETH(selectedCurrency);
      double dataLTC = await CoinData().getCoinDataLTC(selectedCurrency);
      setState(() {
        bitcoinValue = dataBTC.toStringAsFixed(0);
        etheriumValue = dataETH.toStringAsFixed(0);
        litecoinValue = dataLTC.toStringAsFixed(0);
      });
    }catch(e){
      print(e);
    }
  }

  Widget cards(String baseCoin) {

    String baseVal;

    if(baseCoin == 'BTC')
      baseVal = bitcoinValue;
    else if(baseCoin == 'ETH')
      baseVal = etheriumValue;
    else
      baseVal = litecoinValue;
       return Padding(
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
            '1 $baseCoin = $baseVal $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
 @override
  void initState() {
    super.initState();
    getData();
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
               cards('BTC'),
              cards('ETH'),
              cards('LTC'),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS? iOSPicker() : androidDropDown()
          ),
        ],
      ),
    );
  }
}