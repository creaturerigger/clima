import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String cityName = "No entry";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/city_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: TextButton(
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 50.0,
                  ),
                  onPressed: () {
                    Navigator.pop(context, cityName);
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  decoration: kTextFieldDecoration,
                  onChanged: (value) {
                    cityName = value;
                  },
                ),
              ),
              TextButton(
                child: Text(
                  'Get Weather',
                  style: kButtonTextStyle,
                ),
                onPressed: () {
                  if (cityName != "") {
                    print(cityName);
                  } else {
                    print(cityName);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
