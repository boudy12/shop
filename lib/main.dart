import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop/layout/shop_layout/cubit/cubit.dart';
import 'package:shop/layout/shop_layout/shop_home_screen.dart';

import 'package:shop/modules/on_boarding/on_boarding_screen.dart';

import 'package:shop/modules/shop_app/login/login_screen.dart';
import 'package:shop/shared/Bloc_Observer.dart';
import 'package:bloc/bloc.dart';
import 'package:shop/shared/components/constants.dart';
import 'package:shop/shared/cubit/cubit.dart';
import 'package:shop/shared/cubit/states.dart';
import 'package:shop/shared/network/local/cache_helper.dart';
import 'package:shop/shared/network/remote/dio_helper.dart';
import 'package:shop/styles/Themes.dart';


class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() async

{
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  isDark1 =  CacheHelper.getData(key: 'isDark') ?? false;

  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');

  token = CacheHelper.getData(key: 'token');
  print(token);
  Widget widget;
  if(onBoarding != null)
  {
    if(token != null)
    {
      widget = ShopLayoutScreen();
    }
    else{
      widget = ShopAppLoginScreen();
    }
  }
  else{
    widget = OnBoardingScreen();
  }

  runApp(MyApp(
    isDark: isDark1,
    startWidget: widget,
  ));
}


class MyApp extends StatelessWidget {

  final bool? isDark;
  final Widget startWidget;

  MyApp({this.isDark,required this.startWidget});

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppCubit()..changeMode(fromShared: isDark),),
        BlocProvider(create: (context) => ShopAppCubit()..getHomeData()..getCategories()..getFavorites()..getUserData()..getCarts(),),
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:   AppCubit.get(context).isDark? ThemeMode.dark : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: startWidget,
          );
        },

      ),
    );
  }
// This widget is the root of your application.

}

