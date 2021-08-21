import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app1/bloc/states.dart';

import 'cubit.dart';
class Counter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>CounterCubit() ,
      child: BlocConsumer<CounterCubit,CounterStates>(
        listener: (context, state) {
          if(state is CounterMinusState)print('minus state${state.counter}');
          if(state is CounterPlusState)print('plus state${state.counter}');
        },
        builder: (context, state) {
          return  Scaffold(
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: (){
                      CounterCubit.get(context).minus();
                    },
                    child: Text("Minus",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30.0),),
                  ),
                  Padding(
                    padding:EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text("${CounterCubit.get(context).counter}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 80.0),),
                  ),
                  InkWell(
                    onTap: (){
                      CounterCubit.get(context).plus();
                    },
                    child: Text("Plus",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30.0),),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
