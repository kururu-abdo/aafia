import 'package:aafia/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PhoneTextField extends StatelessWidget {
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
  PhoneTextField(
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

    var _countryCodePrefix =

    Container(
      width: 70,
      margin: EdgeInsets.only(right: 5),
      decoration: new BoxDecoration(
        // color: Colors.white,
        border: Border(
          right: BorderSide(width: 0.5, color: Colors.grey),
        ),
      ),
      child: Center(
        child: Text('+249' ,
        style: TextStyle(
          fontSize: 15,fontWeight: FontWeight.w500
        ),
        ),
      ),

    );
    return Directionality(
      textDirection:
      TextDirection.ltr,
      child: Container(
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
           inputFormatters: [MaskTextInputFormatter(
      mask: '##########', 
      filter: { "#": RegExp(r'[0-9]') },
      type: MaskAutoCompletionType.lazy
    )],
            decoration: InputDecoration(
              errorText: errorText,
              prefixIcon: _countryCodePrefix,
              suffixIcon: suffix,
              filled: true,
              hintTextDirection: direction,
              fillColor: AppColors.TEXT_FILLED_COLOR,
              // labelStyle: TextStyle(fontSize: lableFontSize()),
              hintStyle: TextStyle(
                        fontSize: 14 , fontWeight: FontWeight.w400 ,color: AppColors.HINTCOLOR
                      ),
              hintText: label,
              
              labelStyle:TextStyle(
              fontSize: 14 , fontWeight: FontWeight.w400 ,color: AppColors.HINTCOLOR
              ) ,
              // hintStyle: TextStyle(color: Colors.blueGrey, fontSize: 15),
              contentPadding:
               EdgeInsets.symmetric(vertical: hegiht!/3, horizontal: 15),
              
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
      ),
    );
  }
}
