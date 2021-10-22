import 'dart:developer';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pscomidas/app/modules/auth/auth_store.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  final String title;
  const AuthPage({Key? key, this.title = 'AuthPage'}) : super(key: key);
  @override
  AuthPageState createState() => AuthPageState();
}

bool _showPassword = false;

class AuthPageState extends State<AuthPage> {
  final AuthStore store = Modular.get();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white70,
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Image.asset(
                'assets/images/auth-back.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Form(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 100.0,
                  vertical: 20.0,
                ),
                width: screen.width * 0.45,
                height: screen.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/logo.png",
                          width: 200,
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    const Text(
                      'Falta pouco para matar a sua fome!',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 25,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Como deseja continuar?',
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      child: TextFormField(
                        validator: (email) =>
                            email != null && !EmailValidator.validate(email)
                                ? 'E-mail Inválido'
                                : null,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.account_circle_rounded,
                            color: Colors.grey,
                          ),
                          hintText: 'E-mail',
                          border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 3, color: Colors.red),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: store.emailController,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.grey,
                          ),
                          hintText: 'Senha',
                          border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 3, color: Colors.red),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          suffixIcon: GestureDetector(
                            child: Icon(
                              _showPassword == false
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.black,
                            ),
                            onTap: () {
                              setState(() {
                                _showPassword = !_showPassword;
                              });
                            },
                          ),
                        ),
                        obscureText: _showPassword == false ? true : false,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: store.passwordController,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Esqueci minha senha',
                          style: TextStyle(
                            color: Colors.red[700],
                            fontSize: 15,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              if (Form.of(context)!.validate()) {
                                store.login();
                              }
                            },
                            style: ButtonStyle(
                              fixedSize: MaterialStateProperty.all(
                                  const Size.fromHeight(50)),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red),
                              shadowColor:
                                  MaterialStateProperty.all(Colors.black12),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                            ),
                            child: const Text(
                              'Avançar',
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: SizedBox(
                              width: 35,
                              height: 35,
                              child: Image.asset(
                                'images/google.png',
                              ),
                            ),
                            label: const Text(
                              'Continuar com Google',
                              style: TextStyle(
                                color: Colors.black87,
                              ),
                            ),
                            style: ButtonStyle(
                              fixedSize: MaterialStateProperty.all(
                                  const Size.fromHeight(50)),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              overlayColor:
                                  MaterialStateProperty.all(Colors.black12),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.facebook_outlined,
                              size: 35,
                            ),
                            label: const Text('Continuar com Facebook'),
                            style: ButtonStyle(
                              fixedSize: MaterialStateProperty.all(
                                  const Size.fromHeight(50)),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blue[700]),
                              shadowColor:
                                  MaterialStateProperty.all(Colors.black12),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
