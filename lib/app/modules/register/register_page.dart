import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pscomidas/app/modules/register/register_store.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final String title;
  const RegisterPage({Key? key, this.title = 'RegisterPage'}) : super(key: key);
  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final RegisterStore store = Modular.get();

  TextStyle get fontFamily => GoogleFonts.getFont('Sen', fontSize: 16.0);

  TextStyle get digitedText => GoogleFonts.getFont(
        'Sen',
        fontSize: 14.0,
      );

  final TextEditingController controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.red[900],
        body: Center(
          child: Container(
            width: screen.width * .35,
            height: screen.height * .97,
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 40.0,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 2,
                  spreadRadius: 2,
                )
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Image.asset(
                    'assets/images/logo.png',
                    scale: 2.4,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Falta pouco para matar sua fome!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      'Insira seus dados para iniciar o cadastro',
                      style: fontFamily,
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: controller,
                    title: 'E-mail',
                    hint: 'Insira seu email',
                  ),
                  CustomSubmit(
                    label: 'Enviar',
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.title,
    this.validator,
    this.hint,
    required this.controller,
  }) : super(key: key);

  final String? title;
  final String? hint;
  final String? Function(String?)? validator;
  final TextEditingController controller;

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
