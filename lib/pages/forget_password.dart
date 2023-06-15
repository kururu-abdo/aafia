import 'dart:math';

import 'package:aafia/base/base.dart';
import 'package:aafia/pages/login_page.dart';
import 'package:aafia/pages/welcome_page.dart';
import 'package:aafia/utils/validations.dart';
import 'package:aafia/widgets/my_Button.dart';
import 'package:aafia/widgets/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aafia/utils/global.dart' as global;
class ForgetPasswordPage extends BaseRoute {
  final String?  otp;
    final String?  phone;
    final String?  userId;

   ForgetPasswordPage(this.otp, this.phone , this.userId):super(r: 'ChangePassword');

  @override
 _ForgetPasswordPageState createState() => _ForgetPasswordPageState(otp , phone , userId);
}

class _ForgetPasswordPageState extends BaseRouteState {
  final String?  otp;    final String?  userId;


    final String?  phone;

bool _oldPasswordVisible=false;
bool _newPasswordVisible=false;
bool _confirmPasswordVisible=false;

var _uPasswordController=TextEditingController();
var _uPasswordFocus=FocusNode();


var _uNewPasswordController=TextEditingController();
var _uNewPasswordFocus=FocusNode();



var _uConfirmPasswordController=TextEditingController();
var _uConfirmPasswordFocus=FocusNode();


var _uFormKey=GlobalKey<FormState>();

  GlobalKey<ScaffoldState>? _scaffoldKey;

  _ForgetPasswordPageState(this.otp, this.phone, this.userId);


_onChangePassword()async{

  try {


    showOnlyLoaderDialog();
    print(userId.toString());
    apiHelper.resetPassword(userId! ,otp!, _uNewPasswordController.text.trim(), 
    _uConfirmPasswordController.text.trim()
    ).then((result){
hideLoader();
if (result.data!=null) {
  

  if (result.data !=null) {
      showSnackBar(
                  key: _scaffoldKey,
                isSuccess: true,
                  snackBarMessage:
                      'Password Updated Successfully');


                      Get.offAll(
                        ()=>AuthPage(accountType: 'user',)
                        
                        // WelcomeScreem()
                      );
  }else{
       showSnackBar(
                  key: _scaffoldKey,
                  snackBarMessage:
                     'Something went Wrong , try Again');
  }
} else {

    showSnackBar(
                  key: _scaffoldKey,
                  snackBarMessage:
                     result.message.toString());
}



    });
  } catch (e) {
      showSnackBar(
                  key: _scaffoldKey,
                  snackBarMessage:
                     e.toString());
    print(e.toString()); 
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
          appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,

        title: Text('Forgot Password' , style: TextStyle(color: Theme.of(context).primaryColor),),
centerTitle: true, 

leading: IconButton(onPressed: (){
  Get.back();
}, icon: Icon(Icons.arrow_back_ios ,color: Colors.black,)),



      ),

      body: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal:
            20.0),
          child: Form(
            key: _uFormKey,
            child:  SingleChildScrollView(
        // physics: const NeverScrollableScrollPhysics(),
        padding: MediaQuery.of(context).viewInsets.copyWith(
          left: 15,right: 15
        )  ,
              child:  ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            minHeight: MediaQuery.of(context).size.height,
            // maxHeight: 1009
          ),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                        SizedBox(height: MediaQuery.of(context).size.height/8,),
                      
                      Image.asset('assets/images/png/changepassword.png' ,
                      
                      
                      
                      )
                      ,
                      SizedBox(height: 30,)
                      
                      ,Form(child: 
                      
                      
                      Column(

                  children: [
                      
//                       BoxTextField(label: 
                      
//                       'Old Password' ,
//                              obsecure: !_oldPasswordVisible,

//                       controller: _uPasswordController,
//                     validator: validatePassword,
//                  suffix: IconButton(onPressed: (){
//   _oldPasswordVisible= !_oldPasswordVisible;
//   setState(() {
    
//   });

// }, icon:  Icon(
  
//   !_oldPasswordVisible?
//   Icons.visibility_off :  Icons.visibility  ,
// color: Theme.of(context).primaryColor,
// )

// ),
                  
//                       ) ,
                      
                      
                      
                      BoxTextField(
                  obsecure: !_newPasswordVisible,
                  label: 
                      
                      'New Password' ,
                      controller: _uNewPasswordController,
                         validator: validatePassword,

                           suffix: IconButton(onPressed: (){
  _newPasswordVisible= !_newPasswordVisible;
  setState(() {
    
  });

}, icon:  Icon(
  
  !_newPasswordVisible?
  Icons.visibility_off :  Icons.visibility  ,
color: Theme.of(context).primaryColor,
)

),
        
                      ) ,
                      BoxTextField(
                  obsecure: !_confirmPasswordVisible,
                  label: 
                      
                      'Confirm Password',
                      controller: _uConfirmPasswordController,
                      validator:(str)=> validateConfirmPassword(str,_uNewPasswordController.text  ),

                             suffix: IconButton(onPressed: (){
  _confirmPasswordVisible= !_confirmPasswordVisible;
  setState(() {
    
  });

}, icon:  Icon(
  
  !_confirmPasswordVisible?
  Icons.visibility_off :  Icons.visibility  ,
color: Theme.of(context).primaryColor,
)

),
                      ) ,
                      SizedBox(height: 20),
                      MyButton(
                  title: 'Save',
                  onTap: ()async{
                    await  _onChangePassword();
                  },
                  color: Theme.of(context).primaryColor,
                      )
                      
                  ],
                      )
                      )
                      
                      
                      
                      
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}