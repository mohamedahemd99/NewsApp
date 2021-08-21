import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app1/newsApp/cubit/states.dart';
import 'package:news_app1/newsApp/searchScreen.dart';

import 'cubit.dart';

class NewsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()..getBusiness()..getSports()..getScience(),
      child: BlocConsumer<NewsCubit,NewsStates>(
        listener: (context, state) => {},
        builder: (context, state) {
          var cubit=NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(icon: Icon(Icons.search),onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context) => SearchScreen(),));
                },),
                IconButton(icon: Icon(Icons.brightness_4),
                  onPressed: ()
                  {
                  NewsCubit.get(context).changeAppMode();
                  print(NewsCubit.get(context).isDark);
                  }
                ,)
              ],
              title:Text("News App",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.black),) ,
            ),
             body: cubit.screens[cubit.currentIndex ],
            bottomNavigationBar: BottomNavigationBar(
              items: cubit.bottomItems,
              currentIndex: cubit.currentIndex,
              onTap: (index){
                cubit.changeBottomNavBar(index);
              },
            ),
          );
        },
      ),
    );
  }
}
