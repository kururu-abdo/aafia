import 'package:aafia/utils/colors.dart';
import 'package:flutter/material.dart';

class BoxTextField extends StatelessWidget {
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final bool? obsecure;
  final bool? readOnly;
  final VoidCallback? onTap;
  final VoidCallback? onEditingCompleted;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final bool? isMulti;
  final bool? autofocus;
  final bool? enabled;
  final String? errorText;
  final String? label;
  final Widget? suffix;
  final Widget? prefix;
final double? hegiht;
final bool?  isPhone;
  BoxTextField(
      {Key? key,
      this.controller,
      this.validator,
      this.keyboardType = TextInputType.text,
      this.obsecure = false,
      this.onTap,
      this.isMulti = false,
      this.readOnly = false,
      this.autofocus = false,
      this.errorText,
      @required this.label,
      this.suffix,
      this.prefix,
      this.hegiht=50,
      this.enabled = true,
      this.onEditingCompleted,
      this.onChanged, this.isPhone=false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    TextDirection direction =Directionality.of(context);
    return Container(
      // height: hegiht,
      margin: EdgeInsets.only(bottom: 9),
      child: TextFormField(
          onChanged: onChanged,
          onEditingComplete: onEditingCompleted,
          autofocus: autofocus!,
          minLines: isMulti! ? 4 : 1,
          maxLines: isMulti! ? null : 1,
          onTap: onTap,
          enabled: enabled,
          readOnly: readOnly!,
          obscureText: obsecure!,
          keyboardType: keyboardType,
          controller: controller,
          textDirection: isPhone! ?TextDirection.ltr:null,
         
          decoration: InputDecoration(
            errorText: errorText,
            prefixIcon: prefix,
            suffixIcon: suffix,
            filled: true,
            hintTextDirection: direction,
            fillColor: AppColors.TEXT_FILLED_COLOR,
            // labelStyle: TextStyle(fontSize: lableFontSize()),
            // hintStyle: TextStyle(
            //           fontSize: 14 , fontWeight: FontWeight.w400 ,color: AppColors.HINTCOLOR
            //         ),
            labelText: label,
            labelStyle:TextStyle(
              color: Colors.black
            ) ,
            hintStyle:TextStyle(
              color: Colors.black
            ) ,
            // hintStyle: TextStyle(color: Colors.blueGrey, fontSize: 15),
            contentPadding:
             EdgeInsets.symmetric(vertical: hegiht!/3, horizontal: 20),
            
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                style: BorderStyle.none
              )
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                style: BorderStyle.none
              )
            ),
            focusedErrorBorder:OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                style: BorderStyle.none
              )
            ) ,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                style: BorderStyle.none
              )
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                style: BorderStyle.none
              )
            ),
            disabledBorder: 
           OutlineInputBorder(
             
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                style: BorderStyle.none
              )
            ),
            // errorBorder: errorrTextFieldBorder(),
            // focusedErrorBorder: errorrTextFieldBorder(),
          ),
          validator: validator),
    );
  }
}
