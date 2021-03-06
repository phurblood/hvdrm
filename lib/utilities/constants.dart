import 'package:flutter/material.dart';

const kTempTextStyle = TextStyle(
  fontFamily: 'Mont-Regular',
  fontSize: 100.0,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Mont-Regular',
  fontSize: 45.0,
);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Mont-Regular',
);

const kConditionTextStyle = TextStyle(
  fontSize: 100.0,
);

const kTextFieldInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  icon: Icon(
    Icons.location_city,
    color: Colors.white,
  ),
  hintText: "Şehir Adı Giriniz",
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

const kNormalSizeText = TextStyle(fontSize: 15.0, fontFamily: 'Mont-Regular');
