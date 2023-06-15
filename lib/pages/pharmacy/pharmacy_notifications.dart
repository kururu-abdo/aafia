import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PharmcyNotificationsPage extends StatefulWidget {
  const PharmcyNotificationsPage({ Key? key }) : super(key: key);

  @override
  _PharmcyNotificationsPageState createState() => _PharmcyNotificationsPageState();
}

class _PharmcyNotificationsPageState extends State<PharmcyNotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(


      appBar: AppBar(

        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: Icon(Icons.arrow_back_ios ,color: Colors.black,)),
        elevation: 0.0,
        backgroundColor: Colors.transparent,

        title: Text('الاشعارات' ,style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,
        fontSize: Theme.of(context).textTheme.titleMedium!.fontSize
        
        ),),
        centerTitle: true,
      ),

      body: Container(
        margin: EdgeInsets.only(top: 20),
        child: 
        notifications.length<1?

        Column(
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
        ):
        
        
        ListView(
          children: notifications.map((e) => 
          
          NotificationContainer(title: e['title'],
          desc: e['desc'] ,
          duration: e['duration']
          ,)
          ).toList(),
        ),
      ),
    );
  }
}
var notifications= [


{
  'title':'طلبات تبرع بالدم قريبة منك' ,
  'desc':'هنالك طلبات تبرع بالدم قريبة منك يمكنك الطلب ,وو و و و و ' ,
  'duration':'يوم'
},

{
  'title':'طلبات تبرع بالدم قريبة منك' ,
  'desc':'هنالك طلبات تبرع بالدم قريبة منك يمكنك الطلب ,وو و و و و ' ,
  'duration':'ساعة'
},
{
  'title':'طلبات تبرع بالدم قريبة منك' ,
  'desc':'هنالك طلبات تبرع بالدم قريبة منك يمكنك الطلب ,وو و و و و ' ,
  'duration':'5 أيام'
},

{
  'title':'طلبات تبرع بالدم قريبة منك' ,
  'desc':'هنالك طلبات تبرع بالدم قريبة منك يمكنك الطلب ,وو و و و و ' ,
  'duration':'6 ساعات'
},
];

class NotificationContainer extends StatelessWidget {
  final String? title;
  final String? desc;
  final String? duration;
  const NotificationContainer({ Key? key, this.title, this.desc, this.duration }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height/8,
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
      SizedBox(width: 3,),
          Text(title!,
          
          style: TextStyle(
            color:  Theme.of(context).primaryColor,
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
          maxLines: 2,
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







