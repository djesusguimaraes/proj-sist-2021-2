import 'dart:developer';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pscomidas/app/global/widgets/app_bar/custom_app_bar.dart';
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
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Center(
        child: Form(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Image(
                  image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/9/90/IFood_logo.svg/1200px-IFood_logo.svg.png'),
                  width: 150,
                ),
                SizedBox(height: 10,),
                Text('Portal do parceiro', style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
                SizedBox(height: 10,),
                Text('Gerencie sua loja de forma fácil e rápida', style: TextStyle(fontSize: 17,color: Colors.grey),),
                SizedBox(height: 20,),
                Container(
                  width: 500,
                  child: TextFormField(
                     validator: (email) => email != null && !EmailValidator.validate(email)
                      ? 'Enter a valid email'
                      : null,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.account_circle_rounded,color: Colors.grey,),
                      hintText: 'E-mail',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: Colors.blue),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: store.emailController,
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  width: 500,
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock,color: Colors.grey,),
                      hintText: 'Senha',
                      //hintStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: Colors.blue),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      suffixIcon: GestureDetector(
                          child: Icon( _showPassword == false ? Icons.visibility_off : Icons.visibility, color: Colors.black,),
                          onTap: (){
                            setState(() {
                              _showPassword = !_showPassword;
                            });
                          },
                      )
                    ),
                    obscureText: _showPassword == false ? true: false,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: store.passwordController,
                  ),
                ),
                SizedBox(height: 10,),
                ElevatedButton(
                  onPressed: () {
                    if (Form.of(context)!.validate()) {
                      log('durr');
                    }
                  },
                  child: const Text('Login'),
                ),
                SizedBox(height: 10,),
                Text('Esqueci meu e-mail', style: TextStyle(color: Colors.red[700],fontSize: 15,decoration: TextDecoration.underline)),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Ainda não tem cadastro?', style: TextStyle(color: Colors.grey,fontSize: 15)),
                    Text('Cadastre sua loja', style: TextStyle(color: Colors.red[700],fontSize: 15))
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Ink(
                        color: Color(0xFF397AF3),
                        child: Padding(
                          padding: EdgeInsets.all(6),
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Icon(Icons.android, color: Colors.white),
                              SizedBox(width: 12),
                              Text('Sign in with Google', style: TextStyle(color: Colors.white),),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    InkWell(
                      onTap: () {},
                      child: Ink(
                        color: Color(0xFF397AF3),
                        child: Padding(
                          padding: EdgeInsets.all(6),
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Icon(Icons.facebook, color: Colors.white,),
                              SizedBox(width: 12),
                              Text('Sign in with Facebook', style: TextStyle(color: Colors.white),),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}