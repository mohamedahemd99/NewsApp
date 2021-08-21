import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app1/newsApp/cubit/cubit.dart';
import 'package:news_app1/newsApp/cubit/newsLayout.dart';

import 'bloc/cubit.dart';
import 'newsApp/cacheHelper.dart';
import 'newsApp/cubit/states.dart';
import 'newsApp/network/dio_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  bool isDark = CacheHelper.getBoolean(key: 'isDark');
  runApp(MyApp(isDark));

}

class MyApp extends StatelessWidget {
  final bool isDark;
  MyApp(this.isDark);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => NewsCubit()..changeAppMode(fromShared: isDark),
        child:BlocConsumer<NewsCubit,NewsStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return  MaterialApp(
              debugShowCheckedModeBanner: false,
              theme:ThemeData(
                  primarySwatch:Colors.deepOrange ,
                  scaffoldBackgroundColor:Colors.white,
                  appBarTheme: AppBarTheme(
                    iconTheme:IconThemeData(
                        color: Colors.black
                    ) ,
                    color: Colors.white,
                    elevation: 0.0,
                    brightness:Brightness.light,
                  ),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                      type: BottomNavigationBarType.fixed,
                      selectedItemColor: Colors.deepOrange,
                      backgroundColor: Colors.white,
                      unselectedItemColor: Colors.grey
                  ),
                  floatingActionButtonTheme:FloatingActionButtonThemeData(
                      backgroundColor: Colors.deepOrange
                  ),
                  textTheme: TextTheme(
                      bodyText1: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.black
                      )
                  )
              ) ,
              darkTheme: ThemeData(
                  primarySwatch:Colors.deepOrange ,
                  scaffoldBackgroundColor: HexColor('333739'),
                  appBarTheme: AppBarTheme(
                    iconTheme:IconThemeData(
                        color: Colors.white
                    ) ,
                    color:HexColor('333739')  ,
                    elevation: 0.0,
                    brightness:Brightness.light,
                  ),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                      type: BottomNavigationBarType.fixed,
                      selectedItemColor: Colors.deepOrange,
                      backgroundColor: HexColor('333739'),
                      unselectedItemColor: Colors.grey
                  ),
                  floatingActionButtonTheme:FloatingActionButtonThemeData(
                      backgroundColor: Colors.deepOrange
                  ),
                  textTheme: TextTheme(
                      bodyText1: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          color: CupertinoColors.white
                      )
                  )
              ),
              themeMode: NewsCubit.get(context).isDark?ThemeMode.dark:ThemeMode.light,
              home: NewsLayout(),
            );
          },
        )
    );
  }
}
