import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoappv2/view/components/widgets/text_custom.dart';
import 'package:todoappv2/view/components/widgets/text_form_field_widget.dart';
import 'package:todoappv2/view/screens/home/home_screen.dart';
import 'package:todoappv2/view/screens/home/register/register_screen.dart';
import 'package:todoappv2/view/screens/statistics/statistics_screen.dart';
import 'package:todoappv2/view_model/bloc/auth/auth_cubit.dart';
import 'package:todoappv2/view_model/data/local/shared_keys.dart';
import 'package:todoappv2/view_model/data/local/shared_preference.dart';
import 'package:todoappv2/view_model/utilis/colors.dart';
import 'package:todoappv2/view_model/utilis/navigation.dart';
class TodoLoginScreen extends StatelessWidget {
   const TodoLoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => AuthCubit(),
  child: Scaffold(
      backgroundColor: AppColors.background,
      body: BlocConsumer<AuthCubit,AuthState >(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(children:[
           SizedBox(height: 300,child: Image.asset('assets/images/WhatsApp Image 2023-11-19 at 02.00.45_d8031019.png',width: 150,height: 100,)),
          TextFormFieldCustom(labelText: 'Email',controller: AuthCubit.get(context).emailController,),
          const SizedBox(height: 10,),
          TextFormFieldCustom(labelText: 'Password',controller: AuthCubit.get(context).passwordController,),
          const SizedBox(height: 40,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.blue,
                minimumSize: const Size(double.infinity,50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)
                )
            ),
            onPressed: (){
              AuthCubit.get(context).login().then((value){
                Navigation.pushAndRemove(context, const StatisticsTaskScreen());
              });
            },
            child: const TextCustom
              (text: 'Login',color: AppColors.background,fontSize: 20,),),
        const SizedBox(height: 10,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.blue,
                minimumSize: const Size(double.infinity,50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)
                )
            ),
            onPressed: (){
              Navigation.pushAndRemove(context,const TodoRegisterScreen());
            },
            child: const TextCustom
              (text: 'Register',color: AppColors.background,fontSize: 20,),),]),
      );
  },
),
    ),
);
  }
}
