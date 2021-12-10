import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medtient/layout/home_page.dart';
import 'package:medtient/modules/login/sign_up.dart';
import 'package:medtient/modules/login/sign_up_as.dart';
import 'package:medtient/shared/compnents/component.dart';
import 'package:medtient/shared/cubits/home/home_cubit.dart';
import 'package:medtient/shared/cubits/login/login_cubit.dart';
import 'package:medtient/shared/cubits/login/login_states.dart';
import 'package:medtient/shared/shared_pref/cache_helper.dart';

class LogIn extends StatelessWidget
{
  LogIn({Key key}) : super(key: key);
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<LogInCubit , LoginStates>(
      listener: (BuildContext context, state) {
        if(state is LogInAuthStateSuccess)
        {
          CacheHelper.saveData(key: 'uId', value: state.uidValue.user.uid).then((value) {
            HomeCubit.get(context).getData(state.uidValue.user.uid);
            navigateAnd(context, Homepage());
          }).catchError((onError){
            print('cacheHelper Error$onError');
          });
        }
        if(state is LogInAuthStateError)
          {
            snackBar(context, text: state.onError.toString() , color: Colors.red);
          }
      },
      builder: (BuildContext context, Object state)
      {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView(
                  physics:const BouncingScrollPhysics(),
                  children: [
                    const SizedBox(height: 50,),
                    Align(
                      alignment: Alignment.topCenter,
                      child: AvatarGlow(
                        startDelay: const Duration(seconds: 1),
                        repeatPauseDuration: const Duration(seconds: 1),
                        repeat: true,
                        glowColor: Colors.grey.shade400,
                        animate: true,
                        duration: const Duration(seconds: 1),
                        shape: BoxShape.circle,
                        endRadius: 120,
                        child: Image.asset('assets/log.png',),

                      ),
                    ),
                    Column(
                      children: [
                        const SizedBox(height: 20,),
                        Text(
                          'Log in here for more piles and all CS knowledge',
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline5
                              .copyWith(fontFamily: 'Cairo'),),
                        const SizedBox(height: 20,),
                        defaultTextFormFeild(
                            controller: emailController,
                            pre: Icons.email_outlined,
                            HintText: 'Email',
                            KeyType: TextInputType.emailAddress
                        ),
                        const SizedBox(height: 20,),
                        defaultTextFormFeild(
                            controller: passwordController,
                            pre: Icons.password_outlined,
                            suff: LogInCubit.get(context).Icon,
                            isObscure: LogInCubit.get(context).isAppear,
                            suffPress: ()
                            {
                              LogInCubit.get(context).isShown();
                            },
                            HintText: 'Password',
                            KeyType: TextInputType.emailAddress
                        ),
                        const SizedBox(height: 20,),
                        state is! LogInAuthStateLoading ? defaultButton(
                          text: 'Log in',
                          buttonColor: Colors.teal,
                          icon: Icons.login,
                          onPress: ()
                          {
                            LogInCubit.get(context).LogIn(email: emailController.text, password: passwordController.text);

                          },
                        ) : const LinearProgressIndicator(),
                        Row(
                          children: [
                            const Text('Don\'t have an account?'),
                            TextButton(onPressed: ()
                            {
                              navigateTo(context, SignUpAs(key: key,));
                            },
                                child: const Text('Sign up'))
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },

    );
  }
}
