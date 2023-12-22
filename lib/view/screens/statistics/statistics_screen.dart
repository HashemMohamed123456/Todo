import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:todoappv2/view/components/widgets/text_custom.dart';
import 'package:todoappv2/view/screens/home/home_screen.dart';
import 'package:todoappv2/view_model/bloc/todo/todo_cubit.dart';
import 'package:todoappv2/view_model/bloc/todo/todo_states.dart';
import 'package:todoappv2/view_model/utilis/colors.dart';
import 'package:todoappv2/view_model/utilis/navigation.dart';

class StatisticsTaskScreen extends StatelessWidget {
  const StatisticsTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: TodoCubit.get(context)
        ..getStatistics(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          title: const TextCustom(
            text: 'Tasks Statistics', color: AppColors.white,),
          iconTheme: const IconThemeData(color: AppColors.blue),
        ),
        body: SafeArea(
          child: BlocConsumer<TodoCubit, TodoCubitStates>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              return Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          child: CircularPercentIndicator(
                            radius: 160.0,
                            lineWidth: 13.0,
                            animation: true,
                            backgroundColor: AppColors.white,
                            animationDuration: 400,
                            progressColor: AppColors.blue,
                            circularStrokeCap: CircularStrokeCap.butt,
                            percent: (TodoCubit.get(context).statistics?.data?.New??0.0).toDouble()/(
                                (TodoCubit.get(context).statistics?.data?.New??0.0).toDouble()+
                                    (TodoCubit.get(context).statistics?.data?.outdated??0.0).toDouble()+
                    (TodoCubit.get(context).statistics?.data?.compeleted??0.0).toDouble()+
                                    (TodoCubit.get(context).statistics?.data?.doing??0.0).toDouble()
                            ),
                          center:CircularPercentIndicator(
                            radius: 140.0,
                            lineWidth: 13.0,
                            animation: true,
                            backgroundColor: AppColors.white,
                            animationDuration: 400,
                            progressColor:Colors.red,
                            circularStrokeCap: CircularStrokeCap.butt,
                            percent: (TodoCubit.get(context).statistics?.data?.doing??0.0).toDouble()/(
                    (TodoCubit.get(context).statistics?.data?.New??0.0).toDouble()+
                    (TodoCubit.get(context).statistics?.data?.outdated??0.0).toDouble()+
                    (TodoCubit.get(context).statistics?.data?.compeleted??0.0).toDouble()+
                    (TodoCubit.get(context).statistics?.data?.doing??0.0).toDouble()
                    ),
                          center: CircularPercentIndicator(
                              radius: 120.0,
                              lineWidth: 13.0,
                              animation: true,
                              backgroundColor: AppColors.white,
                              animationDuration: 400,
                              progressColor:Colors.greenAccent,
                              circularStrokeCap: CircularStrokeCap.butt,
                            percent: (TodoCubit.get(context).statistics?.data?.outdated??0.0).toDouble()/(
                                (TodoCubit.get(context).statistics?.data?.New??0.0).toDouble()+
                                    (TodoCubit.get(context).statistics?.data?.outdated??0.0).toDouble()+
                                    (TodoCubit.get(context).statistics?.data?.compeleted??0.0).toDouble()+
                                    (TodoCubit.get(context).statistics?.data?.doing??0.0).toDouble()
                            ),
                          center: CircularPercentIndicator(
                            radius: 100.0,
                            lineWidth: 13.0,
                            animation: true,
                            backgroundColor: AppColors.white,
                            animationDuration: 400,
                            progressColor:Colors.amber,
                            circularStrokeCap: CircularStrokeCap.butt,
                            percent: (TodoCubit.get(context).statistics?.data?.compeleted??0.0).toDouble()/(
                                (TodoCubit.get(context).statistics?.data?.New??0.0.toDouble())+
                                    (TodoCubit.get(context).statistics?.data?.outdated??0.0).toDouble()+
                                    (TodoCubit.get(context).statistics?.data?.compeleted??0.0).toDouble()+
                                    (TodoCubit.get(context).statistics?.data?.doing??0.0).toDouble()
                            ),
                          center: TextCustom(
                            text: "${ (TodoCubit.get(context).statistics?.data?.New??0.0).toDouble()+
                                (TodoCubit.get(context).statistics?.data?.outdated??0.0).toDouble()+
                                (TodoCubit.get(context).statistics?.data?.compeleted??0.0).toDouble()+
                                (TodoCubit.get(context).statistics?.data?.doing??0.0).toDouble()} Tasks",fontSize: 30,color: AppColors.white,
                          )),
                          ),
                          ),
                          ),
                        ),
                          Row(
                           children: [
                             Padding(
                               padding: const EdgeInsets.all(12.0),
                               child: Container(width: 40,height: 25,decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(12),
                                 color: AppColors.blue
                               ),),
                             ),
                            const SizedBox(width: 5,),
                            const TextCustom(text: 'New Tasks',color: AppColors.white,fontSize: 30,),
                           ],
                         ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Container(width: 40,height: 25,decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.red
                              ),),
                            ),
                            const SizedBox(width: 5,),
                            const TextCustom(text: 'Doing Tasks',color: AppColors.white,fontSize: 30,),
                          ],
                        ),  Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Container(width: 40,height: 25,decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.greenAccent
                              ),),
                            ),
                            const SizedBox(width: 5,),
                            const TextCustom(text: 'Outdated Tasks',color: AppColors.white,fontSize: 30,),
                          ],
                        ),  Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Container(width: 40,height: 25,decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: AppColors.amber
                              ),),
                            ),
                            const SizedBox(width: 5,),
                            const TextCustom(text: 'Completed Tasks',color: AppColors.white,fontSize: 30,),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.blue,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)
                          )
                      ),
                      onPressed: () {
                        Navigation.pushAndRemove(context, const TodoHomeScreen());
                      },
                      child: const TextCustom
                        (text: 'Home',
                        color: AppColors.background,
                        fontSize: 20,),),
                  ),],
              );
            },
          ),
        ),),
    );
  }
}
