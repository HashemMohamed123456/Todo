import 'package:flutter/material.dart';
import 'package:todoappv2/model/todomodel/todo_model.dart';
import 'package:todoappv2/view/components/widgets/text_custom.dart';
import '../../../view_model/utilis/colors.dart';
class TodoWidget extends StatelessWidget {
  final Tasks task;
  final void Function()? onTap;
  const TodoWidget({ required this.task,this.onTap,super.key});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color:AppColors.blue,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.blue,width: 2),

        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextCustom(text: "Title: ${task.title??''}",color: AppColors.background,fontSize: 20,),
            const SizedBox(height: 10,),
            Visibility(visible:task.description!=null, child: TextCustom(text: "Description: ${task.description??''}",color: AppColors.background,fontSize: 15,)),
            const SizedBox(height: 10,),
           Row(
             children: [
               Expanded(child: TextCustom(text: 'Start Date: ${task.startDate.toString()}',fontSize: 12,)),
               Expanded(child: TextCustom(text: 'End Date: ${task.endDate.toString()}',fontSize: 12,)),
             ],
           ),
        TextCustom(text: "Status: ${task.status??''}",color: AppColors.background,fontSize: 15,),],
        ),
      ),
    );
  }
}
