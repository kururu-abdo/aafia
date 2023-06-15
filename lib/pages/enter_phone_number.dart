import 'package:aafia/base/base.dart';
import 'package:aafia/pages/forget_password.dart';
import 'package:aafia/pages/otp_page_forgetpassword.dart';
import 'package:aafia/utils/sizes.dart';
import 'package:aafia/utils/validations.dart';
import 'package:aafia/widgets/my_Button.dart';
import 'package:aafia/widgets/my_textfield.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EnterPhoneNumber extends BaseRoute {
   EnterPhoneNumber({ Key? key }) : super(r: 'EnterPhoneNumber');

  @override
  _EnterPhoneNumberState createState() => _EnterPhoneNumberState();
}

class _EnterPhoneNumberState extends BaseRouteState {





var _uPhoneNumberController=TextEditingController();
var _uPhoneFocus=FocusNode();

    _resendOTP() async {
if (_formKey.currentState!.validate()) {
  try {
  showOnlyLoaderDialog();
  await apiHelper.resendOtp(_uPhoneNumberController.text.trim()).then((result) {
hideLoader();
if (result.data!=null) {
  // _cOtp.clear();
  // seconds=30*60;
  //   startTimer();
  //   otpFieldController.clear();
  //           setState(() {});
      Get.offAll(
                  () => OtpPageForgetPassword(
                    phoneNumber: _uPhoneNumberController.text.trim(),
                    onNavigate: (otp ,userId){
                       Get.offAll(
                  () => ForgetPasswordPage(otp ,  _uPhoneNumberController.text.trim() ,userId));
                    },
                        // a: widget.analytics,
                        // o: widget.observer,
                      ),
                  transition: Transition.circularReveal);
   
   
} else {


   showSnackBar(
              key: _scaffoldKey1,
              snackBarMessage:
                 result.message);
}
  });
} catch (e) {
  showSnackBar(
                    key: _scaffoldKey1,
                    
                    snackBarMessage:
                    e.toString() ,   );
}
}else{
 showSnackBar(
                    key: _scaffoldKey1,
                    
                    snackBarMessage:
                   'Please Enter a Phone Number' ,   );

}

    }







  GlobalKey<ScaffoldState>? _scaffoldKey1;

var _formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
  
 appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,

        centerTitle: true,
        title: Text(
       tr('enter_phone_number' ) ,
          style: TextStyle(
            color: Theme.of(context).primaryColor ,fontSize: 15 ,

            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500
          ),
        ),
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: Icon(Icons.arrow_back_ios,color: Colors.black,
        // color: Theme.of(context).primaryColor,
        ))),
      





    body: Padding(padding: EdgeInsets.only(
      left: 30,right: 30,
      
    ),
    child: Form(
      
      key: _formKey,
      child: 
    
    ListView(children: [




SizedBox(height: 21,),
Image.asset(
  "assets/images/png/enter_phone.png",
  width: 200,
  height: 211,
)
,


SizedBox(height:5),


Text(tr('enter_your_phone_number'),

style: Theme.of(context).textTheme.titleMedium!.copyWith(
  color: Theme.of(context).primaryColor ,
  fontSize: Sizes.FontSizeTitle ,
  fontWeight: FontWeight.w500
),
),
SizedBox(height: 10,),
Text('\" ${tr('for_password_recovery')} \"' ,
style: TextStyle(
 fontSize: 13 ,
  fontWeight: FontWeight.w500

),
textAlign: TextAlign.justify,

)
,



SizedBox(height: 20,),


//phone


 BoxTextField(
   
   prefix: Icon(Icons.phone ,color: Theme.of(context).primaryColor,),
   label: tr('phone'),
      validator: validatePhone,
         isPhone: true,
      controller: _uPhoneNumberController,
      keyboardType: TextInputType.number,
      
      ),

// 

SizedBox(height: 35,),

MyButton(
  title: '${tr('continue')}',

  onTap: (){
    //home
 _resendOTP();
// Get.to(()=>DashboardPage());
  },
),







    ],)
    ),
    
    
    ),
    
    );
  }
}