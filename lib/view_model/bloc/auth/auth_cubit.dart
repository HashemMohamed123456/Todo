import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoappv2/view_model/data/network/dio_helper.dart';
import 'package:todoappv2/view_model/data/network/end_points.dart';

import '../../data/local/shared_keys.dart';
import '../../data/local/shared_preference.dart';
part 'auth_state.dart';
class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of<AuthCubit>(context);
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Future<void> registerWithApi() async {
    emit(RegisterLoadingState());
    await DioHelper.post(endPoint: EndPoints.register, body: {
      'name': nameController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'password_confirmation': confirmPasswordController.text
    }).then((value) {
      print(value?.data);
      emit(RegisterSuccessState());
    }).catchError((error) {
      if (error is DioException) {
        print(error.response?.data);
      }
      emit(RegisterErrorState());
      throw error;
    });
  }

  Future<void> login() async {
    emit(LoginLoadingState());
    await DioHelper.post(
        endPoint: EndPoints.loginWithApi,
        body: {
          'email': emailController.text,
          'password': passwordController.text,
        }).then((value) {
      print(value?.data);
      saveDataToLocal(value?.data);
      emit(LoginSuccessState());
    }).catchError((error) {
      print(error);
      if (error is DioException) {
        print(error.response?.data);
      }
      emit(LoginErrorState());
      throw error;
    });
  }
void saveDataToLocal(Map<String,dynamic>value){
    LocalData.set(key: SharedKeys.token, value:value['data']['token']);
    LocalData.set(key: SharedKeys.name, value:value['data']['user']['name']);
    LocalData.set(key: SharedKeys.email, value: value['data']['user']['email']);
    LocalData.set(key: SharedKeys.userID, value: value['data']['user']['id']);
}

Future<void>logout()async{
    emit(LogOutLoadingState());
    await DioHelper.post(endPoint: EndPoints.logOut).then((value){
      print(value.data);
      emit(LogOutSuccessState());
    }).catchError((error){
    if(error is DioException){
      print(error.response?.data);
    }
    emit(LogOutErrorState());
    throw error;
    });
}
}
