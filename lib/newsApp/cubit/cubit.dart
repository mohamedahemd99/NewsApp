import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app1/newsApp/business/business.dart';
import 'package:news_app1/newsApp/cubit/states.dart';
import 'package:news_app1/newsApp/modules/science/science1.dart';
import 'package:news_app1/newsApp/network/dio_helper.dart';
import 'package:news_app1/newsApp/sports/sports.dart';

import '../cacheHelper.dart';

class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit(): super(NewsInitialState());

  static NewsCubit get(context)=>BlocProvider.of(context);

  int currentIndex=0;

  List<BottomNavigationBarItem> bottomItems=
  [
    BottomNavigationBarItem(
      title: Text("Business"),
      icon:Icon(Icons.business),
    ),
    BottomNavigationBarItem(
      title: Text("Sports"),
      icon:Icon(Icons.golf_course),
    ),
    BottomNavigationBarItem(
      title: Text("Science"),
      icon:Icon(Icons.school),
    ),
  ];

  List<Widget> screens =
  [
    Business(),
    Sports(),
    Science(),
  ];

  void changeBottomNavBar(int index){
    currentIndex=index;
    if(index==1)
      getSports();
    if(index==2)
      getScience();

    emit(NewsBottomNavState());
  }
  List<dynamic> business= [];
  List<dynamic> sports= [];
  List<dynamic> science= [];


  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
        url:'v2/top-headlines',
        query:{
          'country':'eg',
          'category':'business',
          'apiKey':'7142965a092f4cbe8c27fd750f23d344'
        }
    ).then((value) {
      business=value.data['articles'];
      print(business[5]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  void getSports() {
    emit(NewsGetSportsLoadingState());
    if(sports.length==0)
    {
      DioHelper.getData(
          url:'v2/top-headlines',
          query:{
            'country':'eg',
            'category':'sports',
            'apiKey':'7142965a092f4cbe8c27fd750f23d344'
          }
      ).then((value) {
        sports=value.data['articles'];
        print(sports[5]['title']);
        emit(NewsGetSportsSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    }
    else
      emit(NewsGetSportsLoadingState());


  }

  void getScience() {
    emit(NewsGetScienceLoadingState());
    if(science.length==0)
    {
      DioHelper.getData(
          url:'v2/top-headlines',
          query:{
            'country':'eg',
            'category':'science',
            'apiKey':'7142965a092f4cbe8c27fd750f23d344'
          }
      ).then((value) {
        science=value.data['articles'];
        print(science[5]['title']);
        emit(NewsGetScienceSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    }
    else
      emit(NewsGetScienceLoadingState());
  }

  bool isDark=false;

  void changeAppMode({bool fromShared}){
    if(fromShared!=null)
    {
      isDark=fromShared;
      emit(NewsGetChangeModeState());
    }
    else
    {
      isDark=!isDark;
      CacheHelper.PutBoolean(key: "isDark", value:isDark);
      emit(NewsGetChangeModeState());
    }
  }

  List<dynamic> search= [];


  void getSearch(String value) {

    emit(NewsGetSearchLoadingState());
    search=[];
    DioHelper.getData(
        url:'v2/everything',
        query:{
          'q':'$value',
          'apiKey':'7142965a092f4cbe8c27fd750f23d344'
        }
    ).then((value) {
      search=value.data['articles'];
      print(search[5]['title']);
      emit(NewsGetSearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }

}