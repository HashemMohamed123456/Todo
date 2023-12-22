import 'package:flutter/material.dart';
import '../../../view_model/utilis/colors.dart';
class TextFormFieldCustom extends StatelessWidget {
  final void Function()? onTap;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool? readOnly;
  final String? labelText;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;
const TextFormFieldCustom({this.onTap,this.validator ,this.autovalidateMode,this.controller,this.keyboardType=TextInputType.text,this.textInputAction=TextInputAction.next,this.readOnly=false,this.labelText,super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: autovalidateMode,
      validator:validator ,
      controller:controller ,
      textInputAction:textInputAction,
      onTap: onTap,
      keyboardType: keyboardType,
      readOnly: readOnly??false,
      style: const TextStyle(color: AppColors.white),
      cursorColor: AppColors.white,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color:AppColors.blue),
        focusColor: AppColors.white,
        floatingLabelStyle: const TextStyle(color: AppColors.white),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
                color: AppColors.blue,
                width: 2
            )
        ),
        focusedBorder:OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
                color: AppColors.white,
                width: 2
            )
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
                color: AppColors.blue,
                width: 1
            )
        ),
        errorBorder:OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
                color: AppColors.red,
                width: 1
            )
        ),
      ),
    );
  }
}
