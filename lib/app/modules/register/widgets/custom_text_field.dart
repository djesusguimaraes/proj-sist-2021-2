import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.title,
    this.validator,
    this.hint,
    required this.controller,
    this.formaters,
  }) : super(key: key);

  final String? title;
  final String? hint;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final List<TextInputFormatter>? formaters;

  TextStyle get titleStyle =>
      GoogleFonts.getFont('Sen', fontSize: 16.0, fontWeight: FontWeight.bold);

  TextStyle get digitedText => GoogleFonts.getFont('Sen', fontSize: 16.0);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          if (title != null) ...[
            Row(
              children: [
                Expanded(
                  child: Text(
                    title!,
                    style: titleStyle,
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5.0),
          ],
          TextFormField(
            style: digitedText,
            inputFormatters: formaters,
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black26),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
              hintText: hint ?? '',
            ),
            cursorColor: Colors.red,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: controller,
            validator: validator ??
                (value) {
                  if (value == null || value.isEmpty) {
                    return 'O campo é obrigatório';
                  }
                },
          ),
        ],
      ),
    );
  }
}
