import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medtient/modules/login/auth_page.dart';
import 'package:medtient/shared/cubits/home/home_cubit.dart';
import 'package:medtient/shared/cubits/login/login_cubit.dart';
import 'package:medtient/shared/cubits/subjects/subjects.dart';
import 'package:medtient/shared/shared_pref/cache_helper.dart';

import 'bloc_observer.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  String uId = CacheHelper.getData(key: 'uId');
  bool order = CacheHelper.getData(key: 'order');
  Bloc.observer = MyBlocObserver();
  runApp(MyApp(uId ,order));
}

class MyApp extends StatelessWidget {
  final String uId;
  final bool order;
  MyApp(this.uId,this.order);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:
      [
        BlocProvider(create: (context) => LogInCubit()),
        BlocProvider(create: (context) => HomeCubit()..getData(uId)),
        BlocProvider(create: (context) => SubCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Medtient Demo',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0.0,
            systemOverlayStyle: SystemUiOverlayStyle(
              systemNavigationBarContrastEnforced: false,
              statusBarColor: Colors.white,
            )
          ),

          scaffoldBackgroundColor: Colors.white
        ),
        home:  AuthPage(),
      ),
    );
  }
}
