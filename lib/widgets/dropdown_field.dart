import 'package:aafia/utils/colors.dart';
import 'package:flutter/material.dart';

class AppDropdownInput<T> extends StatelessWidget {
  final String? hintText;
  final List<T>? options;
  final T? value;
  final String Function(T)? getLabel;
  final void Function(T?)? onChanged;
  final Widget?  prefix;

  AppDropdownInput({
    this.hintText = 'Please select an Option',
    this.options = const [],
    this.getLabel,
    this.value,
    this.onChanged, this.prefix,
  });

  @override
  Widget build(BuildContext context) {
        TextDirection direction =Directionality.of(context);

    return 
    
          Container(
             
             decoration: BoxDecoration(color: AppColors.TEXT_FILLED_COLOR,
               borderRadius: BorderRadius.circular(10)
             ),
            //  height: 50,
             margin: EdgeInsets.only(bottom: 9),
            child: FormField<T>(
            
              builder: (FormFieldState<T> state) {

                return InputDecorator(
                
                  decoration: InputDecoration(
                    prefixIcon: prefix,
                    hintStyle: TextStyle(
                      fontSize: 14 , fontWeight: FontWeight.w400 ,color: AppColors.HINTCOLOR
                    ),
                    contentPadding:
                    //  EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                    
                     EdgeInsets.symmetric(vertical: 50/3, horizontal: 20),
                    labelStyle:  TextStyle(
                      fontSize: 14 , fontWeight: FontWeight.w400 ,color: AppColors.HINTCOLOR
                    ),
                    errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                    hintText: hintText,


                    // labelText: hintText,

                    
                    border:
                        OutlineInputBorder(
                          
                          borderRadius: BorderRadius.circular(10.0),
                        
                        borderSide: BorderSide.none
                        
                        ),
                  ),
                  isEmpty: value == null || value == '',
                  child: DropdownButtonHideUnderline(
                    child:
                    
                    
                     DropdownButton<T>(
                      value: value,
                      isDense: true,
                    
                      // isExpanded: false,
                    
            
                      icon:
                      
             Center(
             child:  Icon(Icons.keyboard_arrow_down ,
             
             
             color: Theme.of(context).primaryColor,
             )
            ),
            
            
            
                      onChanged: onChanged,
                      items: options!.map((T value) {
                        return DropdownMenuItem<T>(
                          
                          value: value,
                          child: Text(getLabel!(value)),
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            ),
          );
    
    
    
    Container(
        width: double.infinity,
      margin: const EdgeInsets.only(
left: 15  ,right: 15, bottom: 8

      ),
    
      // padding: EdgeInsets.only(left: 44.0),
      // margin: EdgeInsets.only(top: 64.0, left: 16.0, right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, 
        children: [
          Text('sdfsd'),
          SizedBox(height: 5,),

          Container(
            child: FormField<T>(
              builder: (FormFieldState<T> state) {
                return InputDecorator(
                  decoration: InputDecoration(
                    contentPadding:
                    
                     EdgeInsets.symmetric(vertical: 12.0, horizontal: 15),
                    // labelStyle: textStyle,
                    errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                    hintText: hintText,
                    labelText: hintText,

                    
                    border:
                        OutlineInputBorder(borderRadius: BorderRadius.circular(5.0),
                        
                        borderSide: BorderSide(width: 1.0, color: Colors.black26)
                        
                        ),
                  ),
                  isEmpty: value == null || value == '',
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<T>(
                      value: value,
                      isDense: true,
                    
            
                      icon:
                      
             Container(
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
            height: double.infinity,
            decoration:   BoxDecoration(
            
            
              color: Colors.white,
              border:
             
               Border(
            left: 
             direction==TextDirection.ltr  ?
            
            BorderSide(
            color: Colors.black54 ,width: 1
            )
            :BorderSide.none ,
            
            right: 
             direction==TextDirection.ltr  ?
            BorderSide.none:
            BorderSide(
            color: Colors.black54 ,width: 1
            )
             ,
            
            
              )
            ),
            child:   Center(
              child:  Icon(Icons.keyboard_arrow_down )
            )
            
                    
                      
                      
                      
                      
                      ),
            
            
            
                      onChanged: onChanged,
                      items: options!.map((T value) {
                        return DropdownMenuItem<T>(
                          
                          value: value,
                          child: Text(getLabel!(value)),
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            ),
          ),
        
        ],
      ),
      
    );
  }
}
