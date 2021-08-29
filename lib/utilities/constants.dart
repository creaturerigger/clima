import 'package:flutter/material.dart';

const String _spartanBlack = 'Spartan';

const kTempTextStyle = TextStyle(
  fontFamily: _spartanBlack,
  fontSize: 100.0,
);

const kMessageTextStyle = TextStyle(
  fontFamily: _spartanBlack,
  fontSize: 60.0,
);

const kButtonTextStyle = TextStyle(
  fontFamily: _spartanBlack,
  fontSize: 30.0,
);

const kConditionTextStyle = TextStyle(
  fontSize: 100.0,
);

const kTextFieldDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  icon: Icon(
    Icons.location_city,
    color: Colors.white,
  ),
  hintText: 'Enter city name',
  hintStyle: TextStyle(
    color: Colors.grey,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
    borderSide: BorderSide.none,
  ),
);
