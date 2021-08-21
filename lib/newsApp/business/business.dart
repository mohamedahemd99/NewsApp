import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app1/newsApp/cubit/cubit.dart';
import 'package:news_app1/newsApp/cubit/states.dart';
import 'package:news_app1/newsApp/webView/web_view.dart';
class Business extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list=NewsCubit.get(context).business;
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


  Widget ReusableTest(article,context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: InkWell(
        onTap:(){
          Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewScreen(article['url']),));
        } ,
        child: Row(
          children: [
            Container(
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(
                borderRadius:BorderRadius.circular(10.0),
                image: DecorationImage(image: NetworkImage('${article['urlToImage']}'),fit: BoxFit.cover),
              ),
            ),
            SizedBox(width: 20.0,),
            Expanded(
              child: Container(
                height: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        "${article['title']}",
                        style:Theme.of(context).textTheme.bodyText1,maxLines: 4,overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      "${article['publishedAt']}",
                      style:TextStyle(color: Colors.grey,fontSize: 15.0),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

