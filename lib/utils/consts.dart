import 'package:flutter/material.dart';

const TR_LOCALE = Locale("tr_TR");

const kTempTextStyle = TextStyle(
  fontFamily: 'Akaya',
  fontSize: 50.0,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Akaya',
  fontSize: 15.0,
);

const kMessageeTextStyle = TextStyle(
  fontFamily: 'Akaya',
  fontSize: 20.0,
  fontWeight: FontWeight.bold,

);

const kButtonTextStyle = TextStyle(
  fontSize: 25.0,
  fontFamily: 'Akaya',
);

const kConditionTextStyle = TextStyle(
  fontSize: 70.0,
);

const kDateTextStyle = TextStyle(
    fontFamily: 'Akaya',
    fontSize: 20
);

const kAllWeather = TextStyle(
    fontFamily: 'Akaya',
    fontSize: 14
);

const kCityStyle = TextStyle(
    fontFamily: 'Akaya',
    fontSize: 40
);

const kTextFieldInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.black54,
  hintText: 'Şehir Adını Girin',
  hintStyle: TextStyle(
    color: Colors.white60,

  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(25.0),
    ),
    borderSide: BorderSide.none,
  ),
);
