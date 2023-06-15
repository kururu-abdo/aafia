import 'dart:convert';

import 'package:aafia/base/base.dart';
import 'package:aafia/data/models/response/current_user.dart';
import 'package:aafia/pages/dashboard.dart';
import 'package:aafia/pages/login_page.dart';
import 'package:aafia/pages/otp_page.dart';
import 'package:aafia/pages/pharmacy_dashboard.dart';
import 'package:aafia/pages/welcome_page.dart';
import 'package:aafia/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../utils/global.dart' as global;
class SplashPage extends BaseRoute {
   SplashPage({ Key? key }) : super(r: 'Splash');

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends BaseRouteState {

 AnimationController? _controller;
  // ..repeat(reverse: false);
  Animation<double>? _animation;
  @override
  void initState() {
    super.initState();

SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
  

});



    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..forward();
    _animation = CurvedAnimation(
      parent: _controller!,
      curve: Curves.fastOutSlowIn,
    );
    _init();
  }

  _getAppconfig()async{
    apiHelper.getConfirg().then((result) {

try {
  if (result!=null) {
  global.configModel=result.data;
}
} catch (e) {
}
    });
  }
_init()async{
   await br.getSharedPreferences();
   _getAppconfig();

  Future.delayed(Duration(seconds: 3),
  (){

      //  Navigator.of(context).push(MaterialPageRoute(builder: (_)=>OtpPage()));

 if (global.sp?.getString('currentUser') != null){

global.currentUser = CurrentUser.fromJson(
            json.decode(global.sp!.getString("currentUser")!));
 
 
 
   if(global.currentUser!.latitude!=null &&  global.currentUser!.latitude !=null){
           global.lat = double.parse(global.currentUser!.latitude.toString());
          global.lng = double.parse(global.currentUser!.longitude.toString());
     }
 var user=global.currentUser;
 
     if (user!.usertype=='client') {
                Get.offAll(
                  () => DashboardPage(
                        // a: widget.analytics,
                        // o: widget.observer,
                      ),
                  transition: Transition.circularReveal);
          }else {
 Get.offAll(
                  () => PharmacyDashboardPage(
                        // a: widget.analytics,
                        // o: widget.observer,
                      ),
                  transition: Transition.circularReveal);

          }
 
 
 
 }else {


    //  Navigator.of(context).push(MaterialPageRoute(builder: (_)=>OtpPage()));

     Navigator.of(context).push(MaterialPageRoute(builder: (_)=>WelcomeScreem()));
 }



  
  }
  );
}
  @override
  dispose() {
    _controller!.dispose();
    super.dispose();
  }









  @override
  Widget build(BuildContext context) {
        var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.SPLASH_COLOR,
      body: 
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
              scale: _animation!,
              alignment: Alignment.center,
              child: Center(
                  child: AnimatedContainer(
                      duration: const Duration(seconds: 3),
                      padding: const EdgeInsets.all(5),
                      width: 265,
                      height: 269,
                      child:
                          
                          // SvgPicture.asset("assets/images/svg/Ambulance2.svg" ,
                          // fit: BoxFit.cover,
                          // )
                          
                          Image.asset("assets/images/png/afia.png", 
                          
                          
                          fit: BoxFit.contain)
                          
                          
                          
                          ))),
    
        ],
      )
      // .center()
      ,
    );
  }
}