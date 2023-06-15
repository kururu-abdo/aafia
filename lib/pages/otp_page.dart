import 'dart:async';
import 'dart:developer';

import 'package:aafia/base/base.dart';
import 'package:aafia/pages/dashboard.dart';
import 'package:aafia/utils/colors.dart';
import 'package:aafia/utils/sizes.dart';
import 'package:aafia/widgets/my_Button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_autofill/otp_autofill.dart';
// import 'package:motion_toast/motion_toast.dart';
// import 'package:motion_toast/resources/arrays.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sms_autofill/sms_autofill.dart';
class SampleStrategy extends OTPStrategy {
  @override
  Future<String> listenForCode() {
    return Future.delayed(
      const Duration(seconds: 2),
      () => 'Your code is 54321',
    );
  }
}
class OtpPage extends BaseRoute {
final String?  phoneNumber;
final Function()? onNavigate;
  final bool? isFirstScreen; // first screen means signup phone verification , otherwise it is change password verification

   OtpPage({ Key? key, this.isFirstScreen  =true, this.phoneNumber, 
  this.onNavigate }) : super(r: 'key');

  @override
  _OtpPageState createState() => _OtpPageState(
    phoneNumber , onNavigate ,isFirstScreen
  );
}

class _OtpPageState extends BaseRouteState {


final String?  phoneNumber;
final Function()? onNavigate;
  final bool? isFirstScreen;









  var onTapRecognizer;
  OtpFieldController otpFieldController =OtpFieldController();

  TextEditingController textEditingController = TextEditingController();
    TextEditingController _cOtp = TextEditingController();

  // ..text = "123456";

  StreamController<ErrorAnimationType>? errorController;
  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  _OtpPageState(this.phoneNumber, this.onNavigate, this.isFirstScreen);
 _init() async {
    try {
// need to change design as well
      // await SmsAutoFill().listenForCode;
var signatrure =await SmsAutoFill().getAppSignature;

// .then((value) {
  log(signatrure);
// } 


// );
      // OTPInteractor!.getAppSignature().then((value) => print('signature - $value'));
      // _cOtp = OTPTextEditController(
      //   codeLength: 6,
      //   onCodeReceive: (code) {
      //     print("code  1 $code");
      //     setState(() {
      //       _cOtp.text = code;
      //     });
      //   },
      // )..startListenUserConsent(
      //     (code) {
      //       print("code   $code");
      //       final exp = RegExp(r'(\d{6})');
      //       return exp.stringMatch(code ?? '') ?? '';
      //     },
      //     strategies: [],
      //   );

      await SmsAutoFill().listenForCode;
    } catch (e) {
      print("Exception - verifyOtpScreen.dart - _init():" + e.toString());
    }
  }






  GlobalKey<ScaffoldState>? _scaffoldKey;





  @override
  void initState() {

    super.initState();
_init();
        onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };
    errorController = StreamController<ErrorAnimationType>();
startTimer();


    // OTPInteractor.getAppSignature()
    //   .then((value) => print('signature - $value'));
  textEditingController = OTPTextEditController(
    codeLength: 5,
    onCodeReceive: (code) => print('Your Application receive code - $code'),
  )..startListenUserConsent(
      (code) {
        final exp = RegExp(r'(\d{5})');
        return exp.stringMatch(code ?? '') ?? '';
      },
      strategies: [
        SampleStrategy(),
      ],
    );
  }
  late Timer _timer;
  @override
  void dispose() {
     _timer.cancel();
    errorController!.close();
otpFieldController.clear();
    super.dispose();
  }
//VERIFY OTP

_onVerifiyOtp()async{
  try {
     showOnlyLoaderDialog();
     log(_cOtp.text.trim());
    await apiHelper.verifyOTP(this.phoneNumber!, _cOtp.text.trim()).then((result) {
hideLoader();

if (result!=null) {
  if (result.data!=null) {
    // if (result.data.containsKey('user_id')) {
    // Get.offAll(
    //   ()=>DashboardPage()
    // );
    onNavigate!();
  // }
  }else {
log('message');
  showSnackBar(
                    key: _scaffoldKey,
                    
                    snackBarMessage:
                    result.message.toString() ,   );
 
}
}else {
log('message');
  showSnackBar(
                    key: _scaffoldKey,
                    
                    snackBarMessage:
                    result.message.toString() ,   );
 
}



    });
  } catch (e) {
 showSnackBar(
                    key: _scaffoldKey,
                    
                    snackBarMessage:
                    e.toString() ,   );

  }
}
//SEND OTP
    _resendOTP() async {
try {
  showOnlyLoaderDialog();
  await apiHelper.resendOtp(phoneNumber!).then((result) {

if (result!=null) {
  _cOtp.clear();
  seconds=30*60;
    startTimer();
    otpFieldController.clear();
            setState(() {});
  
} else {
}
  });
} catch (e) {
  showSnackBar(
                    key: _scaffoldKey,
                    
                    snackBarMessage:
                    e.toString() ,   );
}

    }



  int _seconds = 60*30;
  int _start = 60*30;
  bool isLoading = false;
  late Timer _countDown;
   Future startTimer() async {


         _countDown =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());

    // setState(() {});
    // const oneSec = const Duration(seconds: 1);
    // _countDown = new Timer.periodic(
    //   oneSec,
    //   (timer) {
    //     if (_seconds == 0) {
    //       setState(() {
    //         _countDown.cancel();
    //         timer.cancel();
    //       });
    //     } else {
    //       setState(() {
    //         _seconds--;
    //       });
    //     }
    //   },
    // );

    // setState(() {});
  }
// void startTimer() {
//     const oneSec = Duration(seconds: 1);
//     _timer = Timer.periodic(
//       oneSec,
//       (Timer timer) 
// {        if (_start == 0) {
//           setState(() {
//             timer.cancel();
//             isLoading = false;
//           });
//         } else {
//           setState(() {
//             _start--; 
//          });
//         } 
//      },
//     );
//   }
  Duration myDuration = Duration(minutes: 30);

  // Step 4
  void stopTimer() {
    setState(() => _countDown.cancel());
  }
  // Step 5
  void resetTimer() {
    stopTimer();
    setState(() => myDuration = Duration(minutes: 30));
  }
  var seconds=30*60;
  void setCountDown() {
    final reduceSecondsBy = 1;
    setState(() {
       seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {

         setState(() {
            _countDown.cancel();
            isLoading = false;
            
          });
        _countDown.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }



  @override
  Widget build(BuildContext context) {
        String strDigits(int n) => n.toString().padLeft(2, '0');
 final hours = strDigits(myDuration.inHours);
final minutes = strDigits(myDuration.inMinutes.remainder(60));
            final seconds2 = strDigits(myDuration.inSeconds.remainder(60));

    return Scaffold(key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,

        centerTitle: true,
        title: Text(
          'Verification Code' ,
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
        )),
      
      ),

      body: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
SizedBox(height: 21,),
Image.asset(
  "assets/images/png/undraw_forgot_password_re_hxwm.png",
  width: 200,
  height: 211,
)
,

SizedBox(height:5),


Text('Enter Verification Code',

style: Theme.of(context).textTheme.titleMedium!.copyWith(
  color: Theme.of(context).primaryColor ,
  fontSize: Sizes.FontSizeTitle ,
  fontWeight: FontWeight.w500
),
),
SizedBox(height: 10,),
Text('\"   To access all features of our app , we have sent a verification code to your phone number  please enter code below to verify your account and access all features of our app \"' ,
style: TextStyle(
 fontSize: 13 ,
  fontWeight: FontWeight.w500

),
textAlign: TextAlign.justify,

)
,



SizedBox(height: 20,),
// otp field
// Directionality(
//   textDirection: TextDirection.ltr,
//   child:   OTPTextField(
//     length: 5,
    
//     controller: otpFieldController,
//     width: MediaQuery.of(context).size.width,
//     fieldWidth: 52,
  
//     outlineBorderRadius: 7,
    
//     // isDense: true,
//     otpFieldStyle: OtpFieldStyle(
//       backgroundColor: AppColors.ONBACKGROUND,
//       borderColor: Colors.transparent,
//       focusBorderColor: AppColors.ONBACKGROUND,
//     ),
//     contentPadding: EdgeInsets.symmetric(vertical: 26),
//     style: TextStyle(
//       fontSize: 20 ,fontWeight: FontWeight.w500
//     ),
//     textFieldAlignment: MainAxisAlignment.spaceAround,
//     fieldStyle: FieldStyle.underline,
  
    
//     onCompleted: (pin)async {
//       _cOtp.text=pin;
//       print("Completed: " + pin);
  
//   await
//       _onVerifiyOtp();
//     },
//   ),
// ),


Directionality(
  textDirection: TextDirection.ltr,
  child:   PinCodeTextField(
    length: 5,
  
    obscureText: false,
    keyboardType: TextInputType.number,
  
    animationType: AnimationType.fade,
    textStyle: TextStyle(color: Colors.black),
    pinTheme: PinTheme(
      shape: PinCodeFieldShape.box,
      borderRadius: BorderRadius.circular(7),
      borderWidth: 0.01,
    
  
      fieldHeight: 52,
      fieldWidth: 54,
      activeFillColor: AppColors.ONBACKGROUND,
      inactiveColor: AppColors.ONBACKGROUND,
      disabledColor: AppColors.ONBACKGROUND,
      // selectedColor: AppColors.ONBACKGROUND
      selectedColor:AppColors.ONBACKGROUND,
      selectedFillColor:AppColors.SPLASH_COLOR,
      inactiveFillColor:AppColors.SPLASH_COLOR,
    ),
    
    animationDuration: Duration(milliseconds: 300),
    backgroundColor: Colors.transparent,
    enableActiveFill: true,
    errorAnimationController: errorController,
    controller: textEditingController,
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    onCompleted: (v) async{
      _cOtp.text=v;
     print("Completed: " + v);
    
    await
        _onVerifiyOtp();
    },
    onChanged: (value) {
      print(value);
      setState(() {
        currentText = value;
      });
    },
    beforeTextPaste: (text) {
      print("Allowing to paste $text");
      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
      //but you can show anything you want here, like your pop up saying wrong paste format or etc
      return true;
    }, appContext: context,
  ),
) ,



//  Form(
//                 key: formKey,
//                 child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 8.0, horizontal: 30),
//                     child: PinCodeTextField(
//                       appContext: context,
                    
//                       // pastedTextStyle: TextStyle(
//                       //   color: Colors.green.shade600,
//                       //   fontWeight: FontWeight.bold,
//                       // ),
//                       length: 4,
//                       obscureText: false,
//                       obscuringCharacter: '*',
//                       animationType: AnimationType.fade,
//                       validator: (v) {
//                         if (v!.length < 3) {
//                           return "I'm from validator";
//                         } else {
//                           return null;
//                         }
//                       },
//                       pinTheme: PinTheme(
                      
//                         shape: PinCodeFieldShape.box,
//                         borderRadius: BorderRadius.circular(5),
//                         fieldHeight: 80,
//                         fieldWidth: 70,
//                         activeFillColor:
//                           AppColors.SPLASH_COLOR,
//                       ),
                    
//                       cursorColor: Colors.black,
//                       animationDuration: Duration(milliseconds: 300),
//                       textStyle: TextStyle(fontSize: 20, height: 1.6),
//                       backgroundColor: AppColors.SPLASH_COLOR,
//                       enableActiveFill: true,
//                       errorAnimationController: errorController,
//                       controller: textEditingController,
//                       keyboardType: TextInputType.number,
//                       boxShadows: [
//                         BoxShadow(
//                           offset: Offset(0, 1),
//                           color: Colors.black12,
//                           blurRadius: 10,
//                         )
//                       ],
//                       onCompleted: (v) {
//                         print("Completed");
//                       },
//                       // onTap: () {
//                       //   print("Pressed");
//                       // },
//                       onChanged: (value) {
//                         print(value);
//                         setState(() {
//                           currentText = value;
//                         });
//                       },
//                       beforeTextPaste: (text) {
//                         print("Allowing to paste $text");
//                         //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
//                         //but you can show anything you want here, like your pop up saying wrong paste format or etc
//                         return true;
//                       },
//                     )),
//               ),



//
SizedBox(height: 20,),

MyButton(
  title: 'confirm',

  onTap: (){
    //home
 _onVerifiyOtp();
// Get.to(()=>DashboardPage());
  },
),

SizedBox(height: 10,),
Spacer(),
 seconds > 0
                  ? 
                  Row(
                    mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Resend Code in ",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onBackground,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '${hours}:${minutes}:${seconds2}',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ],
                    )
                  : 
                 RichText(text: TextSpan(
  text: ' didn\'t receive the code ',
  style: TextStyle(
    color: AppColors.BlackColor,
    fontSize: Sizes.FontSizeBody,
    fontWeight: FontWeight.w300
  ),
  children: [
    TextSpan(
      text: 'Resend code',
      style: TextStyle(
        decoration: TextDecoration.underline,
        color: Theme.of(context).primaryColor ,
  fontSize: Sizes.FontSizeBody,
    fontWeight: FontWeight.w500

      )
    )
  ]
)),
      SizedBox(height: 10,),     
              // const SizedBox(height: 10),
              // isLoading
              //     ? const CircularProgressIndicator()
              //     :
              //      SizedBox.shrink()
          
// ,
        





            ],
          ),
        ),
      ),
    );
  }
}
class CustomButton extends StatelessWidget {
  final double minWidth;
  final double maxWidth;
  final double minHeight;
  final Function onPressed;
  final String title;
  final Color color;
  // ignore: prefer_typing_uninitialized_variables
  var icon;

  CustomButton({
    Key? key,
    required this.minWidth,
    required this.maxWidth,
    required this.minHeight,
    required this.onPressed,
    required this.color,
    required this.title,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: minWidth,
            maxWidth: maxWidth,
            minHeight: minHeight,
          ),
          child: Container(
            decoration: BoxDecoration(
                color: color,
                border: Border.all(width: 2.0, color: Colors.white)),
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon != null ? Icon(icon, color: Colors.white) : Container(),
                icon != null ? const SizedBox(width: 10) : Container(),
                Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            )),
          )),
    );
  }
}