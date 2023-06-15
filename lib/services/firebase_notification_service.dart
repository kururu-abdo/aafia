import 'dart:developer';

import 'package:aafia/data/models/base/push_notification_model.dart';
import 'package:aafia/services/notification_service.dart';
import 'package:aafia/utils/colors.dart';
import 'package:drop_shadow/drop_shadow.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../main.dart';

class FirebaseNotificationsService {
 

  final _firebaseMessaging = FirebaseMessaging.instance;




init()async{
  log('INIT FIREBASE ');
  FirebaseMessaging.onMessage.listen(handleForgroundNotifiction);
    FirebaseMessaging.onMessageOpenedApp.listen(handleNotification);

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    _firebaseMessaging.onTokenRefresh.listen(updateDeviceToken);
}
updateDeviceToken(String token){
  try {

    //http request to update token
    
    
  } catch (e) {
  }
}
getDeviceToken()async{
 try {
    return _firebaseMessaging.getToken(); 
 } catch (e) {
   print(e); 
 }
}

handleForgroundNotifiction(RemoteMessage message){

log(message.data.toString());

Get.bottomSheet( 
                  Container(
                    height: 462,
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(
                      vertical: 17,horizontal: 29
                    ),
                    
                                        child:Column(
                      children: [
                          Center(
          child: FractionallySizedBox(
            widthFactor: 0.2, // width of top divider bar
            child: Container(
              margin: const EdgeInsets.symmetric( // margin of top divider bar
                vertical: 12.0,
              ),
              child: Container(
                height: 6.0,width: 44,
                decoration: BoxDecoration(
                  color: AppColors.ONBACKGROUND, // color of top divider bar
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                ),
              ),
            ),
              ),
        ),
           SizedBox(height: 7,),
           
                        Text('tit 2', 
                        
                        
                        style: TextStyle(color: AppColors.PRIMARY_COLOR,
                        
                        
                        fontSize: 15,fontWeight: FontWeight.w500
                         ),
                        ),

                                   SizedBox(height: 11,),
Container(
  width: double.infinity,
  height: 75,
  child: Text('sdfsdfds'  ,
  textAlign: TextAlign.justify,
  
  overflow: TextOverflow.ellipsis
  , style: TextStyle(color: Color(0xFF252424),
                        
                        
                        fontSize: 13,fontWeight: FontWeight.w400
                         ),),
),
                                   SizedBox(height: 11,),

DropShadow(
  color: AppColors.SHADOW_COLOR,
  offset: Offset(0, 0),
  blurRadius: 7,
  child: Container(
width: double.infinity,
height: 192,
    padding: EdgeInsets.symmetric(
      vertical: 17,horizontal: 23 ,

    ),
  ),
),



Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [



    Container(

      height: 50,
      width: 152,
      decoration: BoxDecoration(
        color: AppColors.PRIMARY_COLOR ,

        borderRadius: BorderRadius.circular(8)
      ),
      child: Center(child: Text('Confirm' ,style: TextStyle(

        color: Colors.white ,
        fontSize: 15 ,fontWeight: FontWeight.w500
      ),),),
    )
 
 
 
 
 ,
    Container(

      height: 50,
      width: 152,
      decoration: BoxDecoration(
        color: AppColors.ONBACKGROUND ,

        borderRadius: BorderRadius.circular(8)
      ),
      child: Center(child: Text('Cancel' ,style: TextStyle(

        color: Colors.white ,
        fontSize: 15 ,fontWeight: FontWeight.w500
      ),),),
    )
 
 
 
  ],
)
                      ],
                    )
                  ),
                  // barrierColor: Colors.red[50],
                  isDismissible: false,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    // side: BorderSide(
                    //   width: 5,
                    //   color: Colors.black
                    // )
                  ),
                  enableDrag: false,
 
                );


}
handleNotification(RemoteMessage message){
  //   RemoteNotification notification = message.notification!;
  // AndroidNotification android = message.notification!.android!;
// message.notification!.apple;

log(message.data.toString());
     PushNotification pushNotification = PushNotification(
        title: message.notification?.title,
        body: message.notification?.body,
        id:  message.notification.hashCode
      );
NotificationService().showNotifications(pushNotification);
}

}