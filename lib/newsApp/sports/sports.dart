import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app1/newsApp/business/business.dart';
import 'package:news_app1/newsApp/cubit/cubit.dart';
import 'package:news_app1/newsApp/cubit/states.dart';

class Sports extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list=NewsCubit.get(context).sports;
        return ConditionalBuilder(
          condition:list.length>0 ,
          builder:(context) =>  ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => ReusableTest(list[index],context),
              separatorBuilder: (context, index) => Divider(thickness: 2.0,),
              itemCount: list.length),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

