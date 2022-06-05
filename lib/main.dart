import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preparedacademy/auth/auth_repository.dart';
import 'package:preparedacademy/auth/login/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home:RepositoryProvider(
        create: (context)=>AuthRepository(),
        child: LoginView(),
      ) ,
    );
  }

}
