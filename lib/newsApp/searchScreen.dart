import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app1/newsApp/cubit/cubit.dart';
import 'package:news_app1/newsApp/cubit/states.dart';

import 'business/business.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list=NewsCubit.get(context).search;
        final _contrller=TextEditingController();
        return Scaffold(
          appBar: AppBar(title: Text("Search"),),
          body: Column(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    height: 50.0,
                    child: TextField(
                      onChanged: (value)
                      {
                        NewsCubit.get(context).getSearch(value);
                      },
                      controller: _contrller,
                      keyboardType:TextInputType.multiline ,
                      decoration: InputDecoration(
                        labelText: 'Search',
                        prefixIcon: Icon(Icons.search),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepOrange),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder:OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
                ConditionalBuilder(
                  condition:list.length>0 ,
                  builder:(context) =>  ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) => ReusableTest(list[index],context),
                    separatorBuilder: (context, index) => Divider(thickness: 2.0,),
                    itemCount: list.length),
                  fallback: (context) => Center(child: CircularProgressIndicator()),
                  )

            ],
          ),
        );
      },
    );
  }
}
