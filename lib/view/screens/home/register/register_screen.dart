import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoappv2/view/components/widgets/text_custom.dart';
import 'package:todoappv2/view/components/widgets/text_form_field_widget.dart';
import 'package:todoappv2/view/screens/home/home_screen.dart';
import 'package:todoappv2/view/screens/login_screen/login_screen.dart';
import 'package:todoappv2/view_model/bloc/auth/auth_cubit.dart';
import 'package:todoappv2/view_model/utilis/colors.dart';
import 'package:todoappv2/view_model/utilis/navigation.dart';
class TodoRegisterScreen extends StatelessWidget {
   const TodoRegisterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => AuthCubit(),
  child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(backgroundColor: AppColors.background,
          iconTheme: const IconThemeData(
            color: AppColors.white
          ),
          title:const TextCustom(text: 'Register',color:AppColors.white,),
        ),
        body: BlocConsumer<AuthCubit,AuthState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key:AuthCubit.get(context).formKey,
            child: ListView(children:[
              SizedBox(height: 300,child: Image.asset('assets/images/WhatsApp Image 2023-11-19 at 02.00.45_d8031019.png',width: 150,height: 100,)),
              TextFormFieldCustom(labelText: 'Name',controller: AuthCubit.get(context).nameController,validator: (value){
                if(value!.isEmpty){
                  return'Name must not be Empty';
                }
                return null;
              },autovalidateMode: AutovalidateMode.onUserInteraction,),
              const SizedBox(height: 10,),
              TextFormFieldCustom(labelText: 'Email',controller: AuthCubit.get(context).emailController,validator: (value){if(value!.isEmpty){return'Email must not be empty';}return null;},),
              const SizedBox(height: 10,),
              TextFormFieldCustom(labelText: 'Password',controller: AuthCubit.get(context).passwordController,validator: (value){if(value!.isEmpty){return'Password must not be empty';}return null;},),
              const SizedBox(height: 10,),
              TextFormFieldCustom(labelText: 'Confirm Password',controller: AuthCubit.get(context).confirmPasswordController,validator: (value){
                if(value!=AuthCubit.get(context).passwordController.text){return'Password not match ';}
              return null;},
              autovalidateMode:AutovalidateMode.onUserInteraction ,),
              const SizedBox(height: 40,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.amber,
                    minimumSize: const Size(double.infinity,50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)
                    )
                ),
                onPressed: (){
                  if(AuthCubit.get(context).formKey.currentState!.validate()){
                    AuthCubit.get(context).registerWithApi().then((value) =>Navigator.push(context, MaterialPageRoute(builder: (context)=>TodoLoginScreen())) );
                  }
                },
                child: const TextCustom
                  (text: 'Register',color: AppColors.background,fontSize: 20,),)
            ]),
          ),
        );
  },
),
      ),
);
  }
}
