import 'package:avatar_glow/avatar_glow.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medtient/layout/home_page.dart';
import 'package:medtient/modules/login/login.dart';
import 'package:medtient/modules/login/sign_up.dart';
import 'package:medtient/modules/login/sign_up_as.dart';
import 'package:medtient/shared/compnents/component.dart';
import 'package:medtient/shared/cubits/login/login_cubit.dart';
import 'package:medtient/shared/cubits/login/login_states.dart';

class AuthPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogInCubit, LoginStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object state) {
        return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return snackBar(context,
                    text: 'Error happened', color: Colors.red);
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                return Homepage();
              } else {
                return Scaffold(
                  backgroundColor: Colors.white,
                  body: SafeArea(
                    child: SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: AvatarGlow(
                                startDelay: Duration(seconds: 1),
                                repeatPauseDuration: Duration(seconds: 1),
                                repeat: true,
                                glowColor: Colors.grey.shade400,
                                animate: true,
                                duration: Duration(seconds: 1),
                                shape: BoxShape.rectangle,
                                endRadius: 220,
                                child: Image.asset(
                                  'assets/log.png',
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'Log in here for more piles and all CS data',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4
                                        .copyWith(fontFamily: 'Cairo'),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  // defaultOutLineButton(
                                  //     onPress: () {
                                  //       LogInCubit.get(context).googleLogin();
                                  //     },
                                  //     text: 'Google',
                                  //     icon: FontAwesomeIcons.google,
                                  //     iconColor: Colors.red,
                                  //     borderColor: Colors.red,
                                  //     textColor: Colors.red),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  defaultButton(
                                    text: 'Log in',
                                    buttonColor: Colors.teal,
                                    icon: Icons.login,
                                    onPress: () {
                                      navigateTo(
                                          context,
                                          LogIn(
                                            key: key,
                                          ));
                                    },
                                  ),
                                  Row(
                                    children: [
                                      Text('Don\'t have an account?'),
                                      TextButton(
                                          onPressed: () {
                                            navigateTo(
                                                context,
                                                SignUpAs(
                                                  key: key,
                                                ));
                                          },
                                          child: Text('Sign up'))
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
            });
      },
    );
  }
}
