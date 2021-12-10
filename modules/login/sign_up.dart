import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medtient/layout/home_page.dart';
import 'package:medtient/modules/login/login.dart';
import 'package:medtient/shared/compnents/component.dart';
import 'package:medtient/shared/cubits/home/home_cubit.dart';
import 'package:medtient/shared/cubits/login/login_cubit.dart';
import 'package:medtient/shared/cubits/login/login_states.dart';
import 'package:medtient/shared/shared_pref/cache_helper.dart';

class SignUp extends StatelessWidget {
  SignUp({Key key}) : super(key: key);
  static var emailController = TextEditingController();
  static var passwordController = TextEditingController();
  static var phoneController = TextEditingController();
  static var nameController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogInCubit, LoginStates>(
      listener: (BuildContext context, state) {
        if (state is SaveDataStateSuccess) {
          CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
            HomeCubit.get(context).getData(state.uId);
            LogInCubit.get(context).getData(state.uId);
            navigateAnd(context, Homepage());
          }).catchError((onError){
            print('cacheHelper Error$onError');
          });
        }
        if(state is SignUpAuthStateError)
          {
            snackBar(context, text: state.onError.toString(),color: Colors.red);
          }
      },
      builder: (BuildContext context, Object state) {

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
          ),
          body: SafeArea(
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Log in here for more piles and all CS data',
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                .copyWith(fontFamily: 'Cairo'),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          defaultTextFormFeild(
                              controller: nameController,
                              pre: Icons.person_outline,
                              HintText: 'Name',
                              KeyType: TextInputType.name,
                              validate: (String value) {
                                if (value.length <= 4) {
                                  return 'This is too short name at least 4 char';
                                }
                                return null;
                              }),
                          const SizedBox(
                            height: 20,
                          ),
                          defaultTextFormFeild(
                              controller: emailController,
                              pre: Icons.email_outlined,
                              HintText: 'Email',
                              KeyType: TextInputType.emailAddress,
                              validate: (String value) {
                                if (value.length < 11)
                                {
                                  return 'This email is not valid';
                                }
                                return null;
                              }),
                          const SizedBox(
                            height: 20,
                          ),
                          defaultTextFormFeild(
                              controller: phoneController,
                              pre: Icons.phone_android_sharp,
                              HintText: 'Phone',
                              KeyType: TextInputType.phone,
                              validate: (String value) {
                                if (value.length <= 10) {
                                  return 'This is too short phone';
                                }
                                return null;
                              }),
                          const SizedBox(
                            height: 20,
                          ),
                          defaultTextFormFeild(
                              controller: passwordController,
                              pre: Icons.password_outlined,
                              HintText: 'Password',
                              isObscure: LogInCubit.get(context).isAppear,
                              suff: LogInCubit.get(context).Icon,
                              suffPress: () {
                                LogInCubit.get(context).isShown();
                              },
                              KeyType: TextInputType.emailAddress,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'This field required';
                                }
                                return null;
                              }),
                          const SizedBox(
                            height: 20,
                          ),
                         state is! SignUpAuthStateLoading ? defaultButton(
                            text: 'Sign Up',
                            buttonColor: Colors.teal,
                            icon: Icons.login_outlined,
                            onPress: () {
                              if (formKey.currentState.validate()) {
                                LogInCubit.get(context).signUp(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                  name: nameController.text,
                                );
                              }
                            },
                          ) : const LinearProgressIndicator(),
                          Row(
                            children: [
                              const Text('Have already an account?'),
                              TextButton(
                                  onPressed: () {
                                    navigateTo(
                                        context,
                                        LogIn(
                                          key: key,
                                        ));
                                  },
                                  child: Text('Log In'))
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
