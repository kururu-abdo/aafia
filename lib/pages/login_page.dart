import 'dart:convert';
import 'dart:developer';

import 'package:aafia/base/base.dart';
import 'package:aafia/controllers/auth_controller.dart';
import 'package:aafia/data/models/response/current_user.dart';
import 'package:aafia/pages/dashboard.dart';
import 'package:aafia/pages/enter_phone_number.dart';
import 'package:aafia/pages/forget_password.dart';
import 'package:aafia/pages/home.dart';
import 'package:aafia/pages/otp_page.dart';
import 'package:aafia/pages/otp_page_forgetpassword.dart';
import 'package:aafia/pages/pharmacy_dashboard.dart';
import 'package:aafia/pages/signup_page.dart';
import 'package:aafia/services/firebase_notification_service.dart';
import 'package:aafia/utils/colors.dart';
import 'package:aafia/utils/validations.dart';
import 'package:aafia/widgets/my_Button.dart';
import 'package:aafia/widgets/my_textfield.dart';
import 'package:aafia/widgets/phone_textfield.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import '../../../utils/global.dart' as global;
class AuthPage extends BaseRoute {
  final String? accountType;  //user or pharmacy
   AuthPage( { Key? key  ,this.accountType ="user" }) : super(
   );

  @override
  _LoginPageState createState() => _LoginPageState(accountType);
}

class _LoginPageState extends BaseRouteState {
  final String? accountType; 
List titles=['${tr('login_txt')}','${tr('sign_up_txt')}'];
List taps=['${tr('login_txt')}','${tr('sign_up_txt')}'];
int selectedTap=0;
int selectedPage=0;

var _uPhoneNumberController=TextEditingController();
var _uPhoneFocus=FocusNode();


var _uPasswordController=TextEditingController();
var _uPasswordFocus=FocusNode();

var  _uFormKey= GlobalKey<FormState>();

bool isLoading=false;

bool _pshowPassword=false;
bool _pshowConfirmPassword=false;
  _LoginPageState(this.accountType);
  GlobalKey<ScaffoldState>? _scaffoldKey1;


@override
void initState() {
  super.initState();
  
}
//forget Password

var authController =Get.find<AuthController>();

forgetPassword()async{
try {

  /*
   Get.offAll(
                  () => OtpPage(
                    phoneNumber: user.phone,
                    isFirstScreen: true,
                    onNavigate: (){
                       Get.offAll(
                  () => DashboardPage());
                    },
                        // a: widget.analytics,
                        // o: widget.observer,
                      ),
*/
} catch (e) {
}

}



 login(String userPhone, String password) async {

   log(userPhone);
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        // var number = _cPhone.text.trim();
        if (userPhone.trim().isNotEmpty &&
            userPhone.trim().length >=9) {
          showOnlyLoaderDialog();
          global.currentUser = new CurrentUser();

          await apiHelper.login(userPhone.trim(), password.trim()).then((result) async {
              hideLoader();

            if (result.data != null) {
              // if (global.appInfo!.firebase != 'off') {
              //   // if firebase is enabled then only we need to send OTP through firebase.
              //   await sendOTP(_cPhone.text.trim());
              // } else {
              //   hideLoader();
              //   Get.to(() => OtpVerificationScreen(
              //       phoneNumber: _cPhone.text.trim(),
              //       a: widget.analytics,
              //       o: widget.observer));
              // }
              // }
              // else {

           
              CurrentUser _currentUser = new CurrentUser();
               CurrentUser user = result.data;
              _currentUser.phone = userPhone.toString().trim();
              // var mapper = ToCurrnerUser();

              // global.currentUser = mapper(result!);
              // var mapper = ToCurrnerUser();
              // global.userProfileController.currentUser = global.currentUser;
   if (user.isVerified) {
     

log('HERE');
       try {

               global.currentUser=  user;
    global.sp!.setString(
                  'currentUser', json.encode(user.toJson()));
                  global.sp!.setString(global.token, user.token!);
       } catch (e) {
         log(e.toString());
       }
var token=await
FirebaseNotificationsService().getDeviceToken();
await 
apiHelper.updteUserDeviceToken(user.id.toString(), token);

      if (user.usertype=='client') {
                Get.offAll(
                  () => DashboardPage(
                        // a: widget.analytics,
                        // o: widget.observer,
                      ),
                  transition: Transition.circularReveal);
          }else {
  showSnackBar(
                  key: _scaffoldKey1,
                  snackBarMessage:
                      'غير مصرح لك بالدخول');

          }
   } else {


     Get.offAll(
                  () => OtpPage(
                    phoneNumber: user.phone,
                    isFirstScreen: true,
                    onNavigate: (){
                       Get.offAll(
                  () => DashboardPage(
                    isFromOtp:true
                  ));
                    },
                        // a: widget.analytics,
                        // o: widget.observer,
                      ),
                  transition: Transition.circularReveal);
   }
   
   
   

    
              // registration required
              // Get.to(() => OtpVerificationScreen(
              //     a: widget.analytics,
              //     o: widget.observer,
              //     phoneNumber: _currentUser.userPhone));
         

              // SignUpScreen(
              //       user: _currentUser,
              //       a: widget.analytics,
              //       o: widget.observer,
              //       loginType: 0,
              //     ));
            } else {
              // hideLoader();
              showSnackBar(
                  key: _scaffoldKey1,
                  snackBarMessage:
                      'لم ينجح تسجيل الدخول. تأكد من رقم الهاتف و كلمة المرور');
            }
          });
        } else if (userPhone.trim().isEmpty) {
          showSnackBar(
              key: _scaffoldKey1,
              snackBarMessage:
                  'user phone required');
        } else if (userPhone.trim().length <
            9) {
          showSnackBar(
              key: _scaffoldKey1,
              snackBarMessage:
                  'invalid phone ');
        }
      } else {
        showNetworkErrorSnackBar(_scaffoldKey1);
      }
    } catch (e) {
      // hideLoader();

      log("Exception - login_screen.dart - login():" + e.toString());
    }
  }



route(bool? isRoute , String message){
  if (isRoute!) {
    
  }else {

    //show error message
  }
}





  @override
  Widget build(BuildContext context) {
    return
     Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120),
        child: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
title:Text( titles[selectedTap] ,style: TextStyle(color: Colors.white ,




fontSize: 15 , fontWeight: FontWeight.w500),),
centerTitle: true,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(18),
        ),
    ),
        ),
      ),

      body: 
      ListView(
        children: [
      
      
      Padding(padding: const EdgeInsets.only(
top: 21,
        left: 30 ,right: 30
      ),
      
      child: Center(
      child:   Container(
        height: 40,
        width: 315,
      
        decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: AppColors.TEXT_FILLED_COLOR,
      ),
        child:
        
         Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: taps.map((e) => 
      GestureDetector(
        onTap: (){
      
      selectedTap=taps.lastIndexOf(e);
      setState(() {
        
      });
        },
        child: AnimatedContainer(
       curve: Curves.easeInCubic,
      height: 40,
        width: 315/2,
      duration: 
        
        Duration(milliseconds: 350),
        
        decoration: BoxDecoration(
      
      color: e==taps[selectedTap]?
      Theme.of(context).primaryColor:Colors.transparent,
      borderRadius:  e==taps[selectedTap]?BorderRadius.circular(10):null
        ),
        child: Center(
      child: Text(e,style: TextStyle(
      
        color:  e==taps[selectedTap]?Colors.white:Colors.black,
      
      ),),
        ),
        ),
      )
      
      
      ).toList(),
      
        )),
      ),
      
      ),
      SizedBox(height: 99,),
      Padding(padding: EdgeInsets.all(20),
      
      child:
      selectedTap==0?
      
       Form(
       
       key: _uFormKey,
       child: 
      
      Column(children: [
        PhoneTextField(
    
    label: tr('phone'),
    //  isPhone: true,
  controller: _uPhoneNumberController,
  validator: validatePhone,
  
  ),
      // BoxTextField(label: tr('phone'),
      // validator: validatePhone,
      // isPhone: true,
      
      // controller: _uPhoneNumberController,
      // keyboardType: TextInputType.number,
      
      // ),
      
        BoxTextField(label: tr('password'),
      
        controller: _uPasswordController,
       obsecure: !_pshowPassword,
       validator: validateRequiredField,
      suffix: IconButton(onPressed: (){
      _pshowPassword= !_pshowPassword;
      setState(() {
        
      });
      
      }, icon:  Icon(
      
      !_pshowPassword?
      Icons.visibility_off :  Icons.visibility  ,
      color: Theme.of(context).primaryColor,
      )
      
      ),
        
        ),
        SizedBox(height: 25,),
        MyButton(
      isLoading: false,
      title: tr('login_txt'),
      onTap: ()async{
      // if (this.accountType=="user") {
      if (_uFormKey.currentState!.validate()) {
               await     
               
                login(_uPhoneNumberController.text, _uPasswordController.text);
        
      }
      // }else {
      // if (.currentState!.validate()) {
      //                await      login(_f.text, _uPasswordController.text);
        
      //   }
      // }
      
      },
        ),
      SizedBox(height: 15,),
      InkWell(
        onTap: ()async{
          // await _resendOTP();

          Get.to(()=> EnterPhoneNumber() );
        },
        child: Center(
          child: Text('${tr('forgot_password')}',
         style:  TextStyle(
           fontWeight: FontWeight.w400,
           fontSize: 14,
          decoration: TextDecoration.underline,
          color: Theme.of(context).primaryColor
           )
          ),
        ),
      )
      ],)
      )
      
      
      
      :SignupScreen(
      accountType:accountType ,
      )
      )
      
      
      
        ],
      )
      
      
      ,
    );
  }
}


