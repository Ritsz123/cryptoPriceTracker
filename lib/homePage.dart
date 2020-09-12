import 'package:flutter/material.dart';
import 'package:flutter_crypto/API/nomicsApi.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _cryptoList = [];
  final List<Color> _colorList = [Colors.blue, Colors.green, Colors.pinkAccent];
  @override
  void initState() {
    super.initState();
    getCurrencies();
  }

  void getCurrencies() async {
    var data = await NomicsApi().getCurrencies();
    setState(() {
      _cryptoList = data;
    });
  }

  Widget _cryptoWidget() {
    return ListView.builder(
        itemCount: _cryptoList.length,
        itemBuilder: (context, index) {
          final Map currency = _cryptoList[index];
          final Color currencyColor = _colorList[index % _colorList.length];
          return _listItemUI(currency, currencyColor);
        });
  }

  Widget _listItemUI(currency, color) {
    String price = currency['price_usd'].toString();
    String symbol = currency['asset_id'];
    String name = currency['name'];
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: color,
            child: Center(
              child: Text(
                symbol[0],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          title: Text(
            symbol,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          subtitle: _subtitle(
              name, double.parse(price).toStringAsFixed(4).toString()),
          isThreeLine: true,
        ),
      ),
    );
  }

  Widget _subtitle(name, priceUSD) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        SizedBox(
          height: 3,
        ),
        Text(
          'USD value: $priceUSD',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crypto App'),
        centerTitle: true,
      ),
      body: _cryptoList == null || _cryptoList.isEmpty
          ? Padding(
              padding: EdgeInsets.symmetric(vertical: 200),
              child: Dialog(
                elevation: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(semanticsLabel: 'Loading...'),
                    SizedBox(height: 5),
                    Text('Loading...'),
                  ],
                ),
              ),
            )
          : _cryptoWidget(),
    );
  }
}
