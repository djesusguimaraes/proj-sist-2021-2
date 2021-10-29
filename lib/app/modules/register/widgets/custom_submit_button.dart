import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSubmit extends StatefulWidget {
  const CustomSubmit({Key? key, required this.label}) : super(key: key);
  final String label;
  @override
  _CustomSubmitState createState() => _CustomSubmitState();
}

class _CustomSubmitState extends State<CustomSubmit> {
  TextStyle get digitedText => GoogleFonts.getFont('Sen', fontSize: 22.0);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromHeight(50),
                primary: Colors.red,
              ),
              onPressed: () {},
              child: Text(
                widget.label,
                style: digitedText,
              ),
            ),
          )
        ],
      ),
    );
  }
}
