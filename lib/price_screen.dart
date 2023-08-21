import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'crypto_card.dart';

class PriceScreen extends StatefulWidget {
  final price;

  PriceScreen({this.price});

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  double currentPrice;
  CoinData coin = CoinData();
  double roundedPrice;
  String selectedCurrency = 'USD';
  Map<String, String> coinValues = {};
  bool isWaiting = false;
  @override
  void initState() {
    super.initState();
    getCoinData();
  }



  void getCoinData() async {
    isWaiting = true;
    try {
      var coinData = await coin.getData(selectedCurrency: selectedCurrency);
      isWaiting = false;
      print(coinData);
      updateUI(coinData);
    } catch (e) {
      print(e);
    }
  }

  void updateUI(dynamic coinData) {
    setState(() {
      coinValues = coinData;
      print(coinValues);
    });
  }

  Column makeCards() {
    List<cryptoCard> cryptoCards = [];
    for (String crypto in cryptoList) {
      cryptoCards.add(
          cryptoCard(
              isWaiting ? '...' : coinValues[crypto],
              crypto,
              selectedCurrency
          )
      );
    }
    return Column(
      children: cryptoCards,
      crossAxisAlignment: CrossAxisAlignment.stretch,
    );
  }

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];

    for (String currency in currenciesList) {
      var newMenuItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );

      dropdownItems.add(newMenuItem);
    }

    return DropdownButton(
        iconSize: 40,
        iconEnabledColor: Colors.white,
        itemHeight: 50,
        dropdownColor: Colors.grey,
        menuMaxHeight: 200,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20),
        value: selectedCurrency,
        items: dropdownItems,
        onChanged: (value) {
          setState(() {
            selectedCurrency = value;
            getCoinData();
          });
        });
  }

  CupertinoPicker iOSPicker() {
    List<Text> cupertinoItems = [];

    for (String currency in currenciesList) {
      cupertinoItems.add(Text(currency));
    }

    return CupertinoPicker(
      itemExtent: 31,
      onSelectedItemChanged: (value) {
        selectedCurrency = currenciesList[value];
        print(selectedCurrency);
        getCoinData();
      },
      children: cupertinoItems,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.stretch,
          //   children: [
          //     cryptoCard(coinValues['BTC'], cryptoList[0], selectedCurrency,
          //         Colors.brown),
          //     cryptoCard(coinValues['ETH'], cryptoList[1], selectedCurrency,
          //         Colors.blueGrey),
          //     cryptoCard(coinValues['LTC'], cryptoList[2], selectedCurrency,
          //         Colors.blueAccent),
          //   ],
          // ),
          makeCards(),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 26.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}
