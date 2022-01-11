import 'package:flutter/material.dart';

class Styles {
  button() {
    return ElevatedButton.styleFrom(
      primary: Color.fromRGBO(23, 195, 131, 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
