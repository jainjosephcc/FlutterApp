import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:preparedacademy/auth/auth_repository.dart';
import 'package:preparedacademy/auth/form_submission_status.dart';
import 'package:preparedacademy/auth/login/login_bloc.dart';
import 'package:preparedacademy/auth/login/login_event.dart';
import 'package:preparedacademy/auth/login/login_state.dart';

import '../../animation/fadeanimation.dart';

enum Gender {
  Email,
  password,
}

class LoginView extends StatefulWidget {
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formkey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  Color enabled = const Color(0xFF827F8A);

  Color enabledtxt = Colors.white;

  Color deaible = Colors.grey;

  Color backgroundColor = const Color(0xFF1F1A30);

  bool ispasswordev = true;

  Gender? selected;

  @override
  Widget build(BuildContext context) {
    var we = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        body: BlocProvider(
          create: (context) => LoginBloc(
            authRepo: context.read<AuthRepository>(),
          ),
          child: SingleChildScrollView(
            child: SizedBox(
              width: we,
              height: he,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: he * 0.03,
                  ),
                  FadeAnimation(
                    delay: 1,
                    child: Image.network(
                      "https://cdni.iconscout.com/illustration/premium/thumb/job-starting-date-2537382-2146478.png",
                      width: we * 0.9,
                      height: he * 0.4,
                    ),
                  ),
                  FadeAnimation(
                    delay: 1,
                    child: Container(
                      margin: const EdgeInsets.only(left: 20.0),
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Prepared Planner",
                        style: GoogleFonts.cairo(
                          color: Colors.black45,
                          fontWeight: FontWeight.normal,
                          fontSize: 25,
                          letterSpacing: 2,
                        ),
                        maxLines: 1,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: he * 0.01,
                  ),
                  FadeAnimation(
                    delay: 1,
                    child: Container(
                      margin: const EdgeInsets.only(left: 20.0),
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Please sign in to continue",
                        style: GoogleFonts.cairo(
                            color: Colors.grey, letterSpacing: 0.5),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: he * 0.04,
                  ),
                  BlocListener<LoginBloc,LoginState>(listener: (context,state){
                    final formStatus=state.formStatus;
                    if(formStatus is SubmissionFailed){
                      _showSnackBar(context, formStatus.exception);
                    }
                  },
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        FadeAnimation(
                          delay: 1,
                          child: Container(
                            width: we * 0.9,
                            height: he * 0.071,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: selected == Gender.Email
                                  ? enabled
                                  : backgroundColor,
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: _emailField(),
                          ),
                        ),
                        SizedBox(
                          height: he * 0.02,
                        ),
                        FadeAnimation(
                          delay: 1,
                          child: Container(
                            width: we * 0.9,
                            height: he * 0.071,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: selected == Gender.password
                                    ? enabled
                                    : backgroundColor),
                            padding: const EdgeInsets.all(8.0),
                            child: _passwordField(),
                          ),
                        ),
                        SizedBox(
                          height: he * 0.02,
                        ),
                        FadeAnimation(
                          delay: 1,
                          child: _loginButton(),
                        ),
                        SizedBox(
                          height: he * 0.01,
                        ),
                        FadeAnimation(
                          delay: 1,
                          child: Text("Forgot password?",
                              style: GoogleFonts.cairo(
                                color: const Color(0xFF0DF5E4).withOpacity(0.9),
                                letterSpacing: 0.5,
                              )),
                        ),
                      ],
                    ),
                  ),
                  )

                ],
              ),
            ),
          ),
        ));
  }

  Widget _emailField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
          onTap: () {
            setState(() {
              selected = Gender.Email;
            });
          },
          decoration: InputDecoration(
            enabledBorder: InputBorder.none,
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.email_outlined,
              color: selected == Gender.Email ? enabledtxt : deaible,
            ),
            hintText: 'Email',
            hintStyle: TextStyle(
              color: selected == Gender.Email ? enabledtxt : deaible,
            ),
          ),
          style: TextStyle(
              color: selected == Gender.Email ? enabledtxt : deaible,
              fontWeight: FontWeight.bold),
          validator: (value) => state.isValidEmail ? null : 'Email too short',
          onChanged: (value) =>
              context.read<LoginBloc>().add(LoginEmailChanged(email: value)),
        );
      },
    );
  }

  Widget _passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
          onTap: () {
            setState(() {
              selected = Gender.password;
            });
          },
          decoration: InputDecoration(
              enabledBorder: InputBorder.none,
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.lock_open_outlined,
                color: selected == Gender.password ? enabledtxt : deaible,
              ),
              suffixIcon: IconButton(
                icon: ispasswordev
                    ? Icon(
                        Icons.visibility_off,
                        color:
                            selected == Gender.password ? enabledtxt : deaible,
                      )
                    : Icon(
                        Icons.visibility,
                        color:
                            selected == Gender.password ? enabledtxt : deaible,
                      ),
                onPressed: () => setState(() => ispasswordev = !ispasswordev),
              ),
              hintText: 'Password',
              hintStyle: TextStyle(
                  color: selected == Gender.password ? enabledtxt : deaible)),
          obscureText: ispasswordev,
          style: TextStyle(
              color: selected == Gender.password ? enabledtxt : deaible,
              fontWeight: FontWeight.bold),
          validator: (value) =>
              state.isValidPassword ? null : 'Password is too short',
          onChanged: (value) => context
              .read<LoginBloc>()
              .add(LoginPasswordChanged(password: value)),
        );
      },
    );
  }

  Widget _loginButton() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return state.formStatus is FormSubmitting
            ? CircularProgressIndicator()
            : TextButton(
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    context.read<LoginBloc>().add(LoginSubmitted());
                  }
                },
                style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFF0DF5E4),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 80),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0))),
                child: Text(
                  "Login",
                  style: GoogleFonts.cairo(
                    color: Colors.black,
                    letterSpacing: 0.5,
                    fontSize: 20.0,
                    fontWeight: FontWeight.normal,
                  ),
                ));
      },
    );
  }

  void _showSnackBar(BuildContext context,String message){
    final snackBar=SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
