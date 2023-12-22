import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoappv2/model/todomodel/todo_model.dart';
import 'package:todoappv2/view/components/widgets/text_custom.dart';
import 'package:todoappv2/view/components/widgets/todo_widget.dart';
import 'package:todoappv2/view/screens/home/add%20todo/add_todo_screen.dart';
import 'package:todoappv2/view/screens/home/add%20todo/edit_todo_screen.dart';
import 'package:todoappv2/view_model/bloc/todo/todo_cubit.dart';
import 'package:todoappv2/view_model/bloc/todo/todo_states.dart';
import 'package:todoappv2/view_model/utilis/colors.dart';
import 'package:todoappv2/view_model/utilis/navigation.dart';
class TodoHomeScreen extends StatelessWidget {
  const TodoHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
  value: TodoCubit.get(context)..getAllTasks()..initController()..scrollListener(),
  child: Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor:AppColors.background,
        title: const TextCustom(text: 'TodoApp',color: AppColors.blue,),
        iconTheme: const IconThemeData(color: AppColors.blue),
      ),
    body:BlocConsumer<TodoCubit,TodoCubitStates>(
      builder:(context,state){
        return Column(
          children: [
            Expanded(
              child: Visibility(
                visible: TodoCubit.get(context).newTodoModel?.data?.tasks?.isNotEmpty??true,
                child: ListView.separated(
                    controller: TodoCubit.get(context).sController,
                    padding: const EdgeInsets.all(12),itemBuilder:(context,index){
                  return TodoWidget(
                    task: TodoCubit.get(context).newTodoModel?.data?.tasks?[index]??Tasks(),
                    onTap:(){
                    TodoCubit.get(context).changeIndex(index);
                    Navigation.push(context, EditTodoScreen());} ,);
                },
                    separatorBuilder: (context,index)=>const SizedBox(height: 10,),
                    itemCount:TodoCubit.get(context).newTodoModel?.data?.tasks?.length??0),
              replacement:const Center(
                child:  TextCustom(text:'Please Add Your Task',color: AppColors.blue,fontSize: 30,),
              ),),
            ),
            if(TodoCubit.get(context).isLoadingTasks)
              const Padding(
                padding:  EdgeInsets.all(12.0),
                child:  CircularProgressIndicator(
                  color: AppColors.blue,
                ),
              ),
            if(!TodoCubit.get(context).hasMoreTasks)
              const Padding(
                padding:  EdgeInsets.all(12.0),
                child:  TextCustom(text: 'No More Tasks To Load !',color: AppColors.blue,),
              )
          ],
        );
      } ,
    listener: (context,state){},),
    floatingActionButton: FloatingActionButton(
      onPressed: (){
        Navigation.push(context, const AddTodoScreen());
      },
      shape:const CircleBorder(),
      backgroundColor: AppColors.blue,
      child: const Icon(Icons.add,color: AppColors.background,),
    ),),
);
  }
}
