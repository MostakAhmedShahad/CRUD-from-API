import 'package:flutter/material.dart';

// Colors
const colorRed = Color.fromRGBO(235, 28, 36, 1);
const colorGreen = Color.fromRGBO(33, 191, 115, 1);
const colorWhite = Color.fromRGBO(255, 255, 255, 1);
const colorDarkBlue = Color.fromRGBO(44, 62, 80, 1);

// Text Styles
const TextStyle appBarTitleStyle = TextStyle(
  color: colorWhite,
  fontWeight: FontWeight.bold,
  fontSize: 20,
);

const TextStyle formTitleStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  color: colorDarkBlue,
);

const TextStyle buttonTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
  color: colorWhite,
);

const TextStyle linkTextStyle = TextStyle(
  color: colorDarkBlue,
  fontSize: 16,
  fontWeight: FontWeight.bold,
);

// Input Decoration
InputDecoration appInputDecoration(String label, IconData icon) {
  return InputDecoration(
    labelText: label,
    labelStyle: TextStyle(color: colorDarkBlue),
    prefixIcon: Icon(icon, color: colorDarkBlue),
    filled: true,
    fillColor: Colors.blueGrey[50],
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: colorDarkBlue, width: 2),
    ),
  );
}

// Button Styles
ButtonStyle appElevatedButtonStyle() {
  return ElevatedButton.styleFrom(
    backgroundColor: colorDarkBlue,
    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );
}

// Card Style
BoxDecoration appCardDecoration() {
  return BoxDecoration(
    color: colorWhite,
    borderRadius: BorderRadius.circular(15),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.2),
        blurRadius: 10,
        offset: Offset(0, 4),
      ),
    ],
  );
}

// Background Gradient
BoxDecoration appBackgroundGradient() {
  return BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.blueGrey[800]!,
        Colors.blueGrey[900]!,
      ],
    ),
  );
}