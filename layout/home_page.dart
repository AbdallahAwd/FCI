import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medtient/modules/login/auth_page.dart';
import 'package:medtient/modules/user/user.dart';
import 'package:medtient/shared/compnents/component.dart';
import 'package:medtient/shared/cubits/home/home_cubit.dart';
import 'package:medtient/shared/cubits/home/home_states.dart';
import 'package:medtient/shared/cubits/login/login_cubit.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {

      HomeCubit.get(context).getStackData();
      HomeCubit.get(context).getSheets();

      return BlocConsumer<HomeCubit, HomeStates>(
        listener: (BuildContext context, Object state) {},
        builder: (BuildContext context, state) {
          // return LogInCubit.get(context).userDataModel != null ? LogInCubit.get(context).userDataModel!.type == 'doctor' ? doctorHome(context) : patientHome(context) : Scaffold(body:  const Center(child: CircularProgressIndicator()));
          //لازم اكتر من اسكرينه للجسم الهوم لكل فرقه لسته

          if (HomeCubit.get(context).userDataModel2 != null) {
            if (HomeCubit.get(context).userDataModel2.type == '1') {
              return firstGrade(context);
            } else if (HomeCubit.get(context).userDataModel2.type == '2') {
              return secondGrade(context);
            } else if (HomeCubit.get(context).userDataModel2.type == '3') {
              return thirdGrade(context);
            }
            else
              {
              return fourthGrade(context);
            }
          } else {
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
          }
        },
      );
    });
  }
  Widget firstGrade(context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Image(
              image: AssetImage(
                'assets/log.png',
              ),
              width: 60,
              height: 60,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'FCIM-1',
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
        elevation: 0.5,
      ),
      body: HomeCubit.get(context).screens[HomeCubit.get(context).indexC],
      bottomNavigationBar: defaultButtonNavBar(context),
    );
  }

  Widget secondGrade(context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {

        return Scaffold(
          body: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                snap: true,
                floating: true,
                title: Row(
                  children: [
                    const Image(
                      image: AssetImage(
                        'assets/log.png',
                      ),
                      width: 60,
                      height: 60,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      HomeCubit.get(context).title[HomeCubit.get(context).indexC],
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ],
                ),
                elevation: 0.5,
                actions: [
                  if (HomeCubit.get(context).indexC == 0)
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child:
                        // IconButton(icon: Icon(Icons.logout),onPressed: ()
                        // {
                        //   LogInCubit.get(context).logOut();
                        //   navigateAnd(context, AuthPage());
                        // },)
                        PopupMenuButton(
                            onSelected: (value) {
                              LogInCubit.get(context).logOut();
                              navigateAnd(context, AuthPage());
                            },
                            padding: EdgeInsets.zero,
                            icon: const Icon(
                              Icons.filter_list,
                              color: Colors.black,
                            ),
                            itemBuilder: (context) {
                              return [
                                PopupMenuItem(
                                  child: Wrap(
                                    children: const [
                                      Icon(
                                        Icons.logout,
                                        color: Colors.black,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text('logout'),
                                    ],
                                  ),
                                  value: 'logout',
                                ),
                                PopupMenuItem(
                                  child: Wrap(
                                    children: const [
                                      Icon(Icons.update, color: Colors.black),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text('Reset Password'),
                                    ],
                                  ),
                                  onTap: () {
                                    HomeCubit.get(context).resetPassword(
                                        Users.emailController.text);
                                    state is ResetDataSuccess
                                        ? toast(
                                        text:
                                        'Send an Email to yor email')
                                        : const SizedBox();
                                  },
                                ),
                              ];
                            }))
                  else
                    const SizedBox(
                      width: 2,
                    ),
                  if (HomeCubit.get(context).indexC == 1)
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child:
                        PopupMenuButton(
                            onSelected: (value) {

                            },
                            padding: EdgeInsets.zero,
                            icon: const Icon(
                              Icons.filter_list,
                              color: Colors.black,
                            ),
                            itemBuilder: (context) {
                              return [
                                PopupMenuItem(
                                  child: Wrap(
                                    children: const [
                                      Icon(
                                        Icons.security_update,
                                        color: Colors.black,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text('Change Term'),
                                    ],
                                  ),
                                  value: 'term',
                                ),
                              ];
                            }))
                  else
                    const SizedBox(
                      width: 2,
                    ),
                ],
              ),
            ],
            body: HomeCubit.get(context).screens[HomeCubit.get(context).indexC],
          ),
          bottomNavigationBar: defaultButtonNavBar(context),
        );
      },
    );
  }

  Widget thirdGrade(context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Image(
              image: AssetImage(
                'assets/log.png',
              ),
              width: 60,
              height: 60,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'FCIM-3',
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
        elevation: 0.5,
      ),
      body: HomeCubit.get(context).screens[HomeCubit.get(context).indexC],
      bottomNavigationBar: defaultButtonNavBar(context),
    );
  }

  Widget fourthGrade(context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Image(
              image: AssetImage(
                'assets/log.png',
              ),
              width: 60,
              height: 60,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'FCIM-4',
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
        elevation: 0.5,
      ),
      body: HomeCubit.get(context).screens[HomeCubit.get(context).indexC],
      bottomNavigationBar: defaultButtonNavBar(context),
    );
  }
}


