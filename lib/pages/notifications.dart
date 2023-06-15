import 'dart:convert';
import 'dart:developer';

import 'package:aafia/utils/colors.dart';
import 'package:aafia/utils/conversions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';
import 'package:skeletons/skeletons.dart';
import '../.././utils/global.dart' as global;
import 'package:aafia/data/models/response/notification.dart' as notification;
class NotificationsPage extends StatefulWidget {
  const NotificationsPage({ Key? key }) : super(key: key);

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {














   ScrollController _scrollController = new ScrollController();

var notificationUrl='${global.url}user/notifications';




  var notificaitonLoadCompleted = false;
    List<notification.Data> notificationList = [];






Future<List<notification.Data>>?  notificationData;
Future<List<notification.Data>>
   getNotificationData(uri) async {
    final response = await http.get(Uri.parse(uri) ,
    
    headers: {
      'Authorization':'Bearer ${global.currentUser!.token}',
      'Content-Type':'application/json',
      'Accept':'application/json'
    }
    ).timeout(Duration(seconds: 15))
    
    ;
    if (response.statusCode == 200  ||  response.statusCode == 201) {
      var testJson = json.decode(response.body);
      // log(testJson.toString());
      var data = testJson['data'];
      log(response.body);
      if (testJson['next_page_url'] != null) {
        nextNotificationUrl = testJson['next_page_url'];
      } else {
        notificaitonLoadCompleted = true;
        
      }
      for (var item in data) {
        try {
          notification.Data test =
             notification.Data.fromJson(item);
            
        notificationList.add(test);
        } catch (e) {
          log(e.toString());
        }
      }
      setState(() {
        
      });
      return notificationList;
    } else {
      throw Exception('Failed to load Test');
    }
  }

void startController() {
    _scrollController.addListener(
      () {
        if (_scrollController.offset >=
                _scrollController.position.maxScrollExtent &&
            !_scrollController.position.outOfRange) {
          print('reach to bottom botton');
          if (!notificaitonLoadCompleted) {
            setState(() {
              //add more data to list
              notificationData = getNotificationData(nextNotificationUrl);
            });
          }
        }
      },
    );
  }


  
  
  var nextNotificationUrl;





@override
void initState() { 
  super.initState();
  notificationData=  getNotificationData(notificationUrl);
startController();
}
@override
void dispose() { 
  _scrollController.dispose();
  super.dispose();
  
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(

backgroundColor: AppColors.SPLASH_COLOR,
      appBar: AppBar(

        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: Icon(Icons.arrow_back_ios ,color: Colors.black,)),
        elevation: 0.0,
        backgroundColor: Colors.transparent,

        title: Text(
          
        Get.locale!.languageCode=="ar"?
          
          'الاشعارات':"Notifications" ,style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,
        fontSize: Theme.of(context).textTheme.titleMedium!.fontSize
        
        ),),
        centerTitle: true,
      ),

      body: Container(
        margin: EdgeInsets.only(top: 20),
        child: 

FutureBuilder(
  future: notificationData,
  builder: (BuildContext context, AsyncSnapshot snapshot) {
    if (!snapshot.hasData) {
      
    return 
    
    ListView.builder(
                            physics: ScrollPhysics(),
                              shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return    
               Container(
      // height: MediaQuery.of(context).size.height/6.5,
      margin: EdgeInsets.only(
        left: 15,right: 15 ,bottom: 15
      ),
      padding: EdgeInsets.all(10),
      alignment: Alignment.center,
      decoration: BoxDecoration(

        color: Colors.white,borderRadius: BorderRadius.circular(20)
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
      
          children: [

Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [

          Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.notifications ,
      
      color:  Theme.of(context).primaryColor,
      ),
      SizedBox(width: 10,),

  SkeletonLine(
             style: SkeletonLineStyle(
               width: 50 ,height: 10 ,borderRadius: BorderRadius.circular(10)
             ),
           )
      
      
        ],
          ),
         SkeletonLine(
             style: SkeletonLineStyle(
               width: 50 ,height: 10 ,borderRadius: BorderRadius.circular(10)
             ),
           )
  ],
)



,

     SkeletonParagraph(

       style: SkeletonParagraphStyle(

         lines: 5
       ),
     )
          
          
           ,
      
     
      
      
      
          ],
        ),
      ),
    );
 return
            Container
            (
          margin: EdgeInsets.all(10),
            // margin: EdgeInsets.only(right: 30),
              height: MediaQuery.of(context).size.height/6,
              width: double.infinity,
              padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
          BoxShadow(
            color: Colors.grey[300]!,
            blurRadius: 5,
            spreadRadius: 1,
            offset: Offset(-0.5 ,0)
          )
              ]
          ),
              
              
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              
              Row(
          children: [
             SkeletonAvatar(
              style: SkeletonAvatarStyle(
                    width: 25,height: 25
              ),
            ),
          SizedBox(
            width: 5,
          ) ,
              
          SkeletonLine(
             style: SkeletonLineStyle(
               width: 50 ,height: 10 ,borderRadius: BorderRadius.circular(10)
             ),
           ) ,
              
              
          SizedBox(
            width: 5,
          ) ,
              
              
              
           SkeletonLine(
             style: SkeletonLineStyle(
               width: 70 ,height: 50 ,borderRadius: BorderRadius.circular(50)
             ),
           ) ,
              
               SizedBox(
            width: 5,
          ) ,
              
              
              
              
              SkeletonLine(
             style: SkeletonLineStyle(
               width: 70 ,height: 50 ,borderRadius: BorderRadius.circular(50)
             ),
           ) ,
          ],
              )
              
              ,
              SizedBox(height: 15,),
              Row(
          children: [
              
              
            SkeletonAvatar(
              style: SkeletonAvatarStyle(
                    width: 25,height: 25
              ),
            )
          
          
          ,
              SizedBox(width: 5,),
              
               SkeletonLine(
             style: SkeletonLineStyle(
               width: 50 ,height: 10 ,borderRadius: BorderRadius.circular(10)
             ),
           ) ,
          
          ])
          ,
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
              
          SizedBox(height: 15,),
           
           
           
              Row(
          children: [
              
          SkeletonAvatar(
              style: SkeletonAvatarStyle(
                    width: 25,height: 25
              ),
            ),
              SizedBox(width: 5,),
              
               
           SkeletonLine(
             style: SkeletonLineStyle(
               width: 50 ,height: 10 ,borderRadius: BorderRadius.circular(10)
             ),
           ) ,
          ])
              
              
              
              
              ,
              
          SizedBox(height: 15,),
              
           
              Row(
          children: [
              
          SkeletonAvatar(
              style: SkeletonAvatarStyle(
                    width: 25,height: 25
              ),
            ),
              SizedBox(width: 5,),
              
               
           SkeletonLine(
             style: SkeletonLineStyle(
               width: 50 ,height: 10 ,borderRadius: BorderRadius.circular(10)
             ),
           ) ,
          ])
              
              
              
              
            ]),
            )
            
            ;
          },
              );
     
     
            
                        } else {
        
        
                          if (
                          notificationList.isEmpty) {
                              log('DATA ${snapshot.data}');
                     return        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(40),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle
              ),
              child: Center(
                child: Icon(Icons.notifications ,
                color: Theme.of(context).primaryColor,
                ),
              ),
            ),

            Text('لا توجد اشعاارات بعد' ,
            
            style: TextStyle(color: Colors.black,fontSize: 20 ,fontWeight: FontWeight.bold),
            )
          ],
        );
        
                          }
                          //if (snapshot.connectionState == ConnectionState.done) {
                          return 
                           
        ListView(
          children: notificationList   .map((e) => 
          
          NotificationContainer(title:  
          Get.locale!.languageCode=="ar"?  
      
             "اشعار" :  
             
               "Notification" 
             
             
                ,
          desc:
            e.data!.messages!=null?
           Get.locale!.languageCode=="ar"?
          
           e.data!.messages!.ar!=null? 
           e.data!.messages!.ar!.toString():"التفاصيل" :
               e.data!.messages!.en!=null? 
               
               e.data!.messages!.en!.toString():"Details" 
           
           :''
           ,
          duration:

          getTimeAgo( e.createdAt.toString())
          
          ,
          isRead:e.readAt !=null
          ,)
          ).toList(),
        );
     
     
                        
                        
                        }
  },
),


        // notifications.length<1?

        // Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: [
        //     Container(
        //       padding: EdgeInsets.all(40),
        //       margin: EdgeInsets.all(10),
        //       decoration: BoxDecoration(
        //         color: Colors.white,
        //         shape: BoxShape.circle
        //       ),
        //       child: Center(
        //         child: Icon(Icons.notifications ,
        //         color: Theme.of(context).primaryColor,
        //         ),
        //       ),
        //     ),

        //     Text('لا توجد اشعاارات بعد' ,
            
        //     style: TextStyle(color: Colors.black,fontSize: 20 ,fontWeight: FontWeight.bold),
        //     )
        //   ],
        // ):
        
        
        // ListView(
        //   children: notifications.map((e) => 
          
        //   NotificationContainer(title: e['title'].toString(),
        //   desc: e['desc'].toString() ,
        //   duration: e['duration'].toString(),
        //   isRead: e['read'].toString()=='1'
        //   ,)
        //   ).toList(),
        // ),
     
     
     
     
     
      ),
    );
  }

  var notifications= [


{
  'title':'طلبات تبرع بالدم قريبة منك' ,
  'desc':'هنالك طلبات تبرع بالدم قريبة منك يمكنك الطلب ,وو و و و و  هنالك طلبات تبرع بالدم قريبة منك يمكنك الطلب ,وو و و و و' ,
  'duration':'يوم',
  'read':0
},

{
  'title':'طلبات تبرع بالدم قريبة منك' ,
  'desc':'هنالك طلبات تبرع بالدم قريبة منك يمكنك الطلب ,وو و و و و ' ,
  'duration':'ساعة' 
  ,
  'read':1
},
{
  'title':'طلبات تبرع بالدم قريبة منك' ,
  'desc':'هنالك طلبات تبرع بالدم قريبة منك يمكنك الطلب ,وو و و و و ' ,
  'duration':'5 أيام' 
  ,
  'read':1
},

{
  'title':'طلبات تبرع بالدم قريبة منك' ,
  'desc':'هنالك طلبات تبرع بالدم قريبة منك يمكنك الطلب ,وو و و و و   هنالك طلبات تبرع بالدم قريبة منك يمكنك الطلب ,وو و و و و هنالك طلبات تبرع بالدم قريبة منك يمكنك الطلب ,وو و و و و' ,
  'duration':'6 ساعات' ,
   'read':1
},
];

}

class NotificationContainer extends StatelessWidget {
  final String? title;
  final String? desc;
  final String? duration;
  final bool? isRead;
  const NotificationContainer({ Key? key, this.title, this.desc, this.duration, this.isRead }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    
    return Container(
      height: MediaQuery.of(context).size.height/6.5,
      margin: EdgeInsets.only(
        left: 15,right: 15 ,bottom: 15
      ),
      padding: EdgeInsets.all(10),
      alignment: Alignment.center,
      decoration: BoxDecoration(

        color: 
        isRead!? Colors.green[400]
:        
        Colors.white
        
        
        ,borderRadius: BorderRadius.circular(20)
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
      
          children: [

Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [

          Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.notifications ,
      
      color:  Theme.of(context).primaryColor,
      ),
      SizedBox(width: 10,),
          Text(title!,
          
          style: TextStyle(
            color: isRead! ?Colors.black:
             Theme.of(context).primaryColor,
            fontSize: Theme.of(context).textTheme.titleMedium!.fontSize
          ),
          ),
        ],
          ),
       Text(
        duration!,
        style: TextStyle(
          color: Colors.black,
          fontSize: Theme.of(context).textTheme.bodySmall!.fontSize
        ),
      )
  ],
)



,

      Text(desc!,
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
          textAlign: TextAlign.justify,
          style: TextStyle(
        color: Colors.black,
        fontSize: Theme.of(context).textTheme.bodySmall!.fontSize
          ),
          
          ) ,
      
     
      
      
      
          ],
        ),
      ),
    );
 
 
 
  }
}







