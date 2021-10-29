import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pscomidas/app/modules/register/register_store.dart';
import 'package:flutter/material.dart';
import 'package:pscomidas/app/modules/register/widgets/custom_submit_button.dart';
import 'package:pscomidas/app/modules/register/widgets/custom_text_field.dart';

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
              child: SingleChildScrollView(
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
                      controller: store.nameController,
                      title: 'Nome',
                      hint: 'Insira seu nome completo',
                    ),
                    CustomTextField(
                      controller: store.cpfController,
                      title: 'CPF',
                      hint: 'Insira seu CPF',
                    ),
                    CustomTextField(
                      controller: store.bornController,
                      title: 'Data de Nascimento',
                      hint: 'Insira sua data de nascimento',
                    ),
                    CustomTextField(
                      controller: store.emailController,
                      title: 'E-mail',
                      hint: 'Insira seu email',
                    ),
                    CustomTextField(
                      controller: store.phoneController,
                      title: 'Telefone com (DDD)',
                      hint: 'Insira seu telefone',
                    ),
                    const SizedBox(height: 10),
                    const CustomSubmit(label: 'Enviar')
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
