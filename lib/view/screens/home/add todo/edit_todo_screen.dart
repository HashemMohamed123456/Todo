import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todoappv2/view/components/widgets/text_custom.dart';
import 'package:todoappv2/view/components/widgets/text_form_field_widget.dart';
import 'package:todoappv2/view_model/bloc/todo/todo_cubit.dart';
import '../../../../view_model/utilis/colors.dart';
class EditTodoScreen extends StatelessWidget {
  const EditTodoScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.background,
        title: const TextCustom(text: 'Edit Task',color: AppColors.blue),
        iconTheme: const IconThemeData(
          color: AppColors.amber
        ),
      ),
    body:  Form(
      key: TodoCubit.get(context).formKey,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
         children: [
           Expanded(child:SingleChildScrollView(
           child: Column(
               children: [
                  TextFormFieldCustom(
                   controller: TodoCubit.get(context).titleController,
                   labelText: 'Title',
                   textInputAction: TextInputAction.next,
                      onTap: (){},),
                 const SizedBox(height: 12,),
                  TextFormFieldCustom(
                   controller: TodoCubit.get(context).descriptionController,
                   labelText: 'Description',
                  textInputAction:  TextInputAction.next,
                  onTap: (){},),
                 const SizedBox(height: 12,),
                 TextFormFieldCustom(
                   controller: TodoCubit.get(context).startDateController,
                   labelText: 'Start Date',
                   keyboardType:TextInputType.none,
                   readOnly: true,
                   onTap:(){showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2019,5,1), lastDate: DateTime.now().add(const Duration(days: 365*5)
                   )
                   ).then((value){
                     if(value!=null){
                       TodoCubit.get(context).startDateController.text=DateFormat('yyyy-MM-dd').format(value);
                     }
                   });
                     },
                 ),
                 const SizedBox(height: 12,),
                 TextFormFieldCustom(
                   controller: TodoCubit.get(context).endDateController,
                   labelText: 'End Date',
                   keyboardType: TextInputType.none,
                   readOnly: true,
                   onTap: (){showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2019,5,1), lastDate: DateTime.now().add(const Duration(days: 365*5))
                   ).then((value){
                     if(value!=null){
                       TodoCubit.get(context).endDateController.text=DateFormat('yyyy-MM-dd').format(value);
                     }
                   });
                     },
                 ),
      const SizedBox(height: 12,),
                 TextFormFieldCustom(
                   controller: TodoCubit.get(context).statusController,
                   labelText: 'Status',
                   textInputAction:  TextInputAction.next,
                   onTap: (){},),
                 const SizedBox(height: 12,),

      Material(
          borderRadius: BorderRadius.circular(12),
          color: Colors.transparent,
          child: InkWell(
            onTap: (){},
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.blue,width: 1)
              ),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                   Icon(Icons.image_outlined,size: 250,color: AppColors.blue,),
                   SizedBox(height: 12,),
                  TextCustom(text: 'Edit Image',fontSize: 20,fontWeight: FontWeight.bold,color: AppColors.blue,),
                ],
              ),),
          ),
      )
               ]
           ),
           )
           ),
         SafeArea(child: Row(
           children: [
             Expanded(
               child: ElevatedButton(
                 style: ElevatedButton.styleFrom(
                   backgroundColor: AppColors.blue,
                   minimumSize: const Size(double.infinity,50),
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(12)
                   )
                 ),
                 onPressed: (){
                   if(TodoCubit.get(context).formKey.currentState!.validate()){
                     TodoCubit.get(context).updateTask().then((value){Navigator.pop(context);});
                   }
                 },
                 child: const TextCustom
                   (text: 'Edit Task',color: AppColors.background,fontSize: 20,),),
             ),
             const SizedBox(width: 20,),
             Expanded(
               child: ElevatedButton(
                 style: ElevatedButton.styleFrom(
                     backgroundColor: AppColors.blue,
                     minimumSize: const Size(double.infinity,50),
                     shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(12)
                     )
                 ),
                 onPressed: (){
                   if(TodoCubit.get(context).formKey.currentState!.validate()){
                     TodoCubit.get(context).deleteTasks().then((value){Navigator.pop(context);});
                   }
                 },
                 child: const TextCustom
                   (text: 'Delete Task',color: AppColors.background,fontSize: 20,),),
             ),],
         ))
         ],
        ),
      ),
    ),);
  }
}
