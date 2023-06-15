

import 'package:aafia/pages/home.dart';
import 'package:aafia/pages/my_requests.dart';
import 'package:aafia/pages/profile_page.dart';
import 'package:aafia/widgets/toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

class DashboardPage extends StatefulWidget {
  final bool?  isFromOtp;
  const DashboardPage({ Key? key, this.isFromOtp=false }) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {


@override
  void initState() {
    // TODO: implement initState
    super.initState();
 
 //from ot
 Future.microtask(() {
if (widget.isFromOtp!) {
                     ToastUtils.showCustomToast(context, tr('pass_otp'));

}
//      MotionToast(
//   // icon: Icons.alarm,
//   height: 80,
//   width: 300,
//   position: MotionToastPosition.top,
//   backgroundType: BackgroundType.lighter,
//   primaryColor: Colors.green,
// barrierColor:Colors.grey[500]!,
//   description: Text(' \"Your Account has been verified\"'),
// ).show(context);

 });
  }

  static int _selectedIndex = 0;  


      void _onItemTapped(int index) {  
    setState(() {  
      _selectedIndex = index;  
    });  
  }  


 
final List<Widget> bodyWidgets = <Widget>[  
     const HomePAge() ,
     MyRequestPage(),
     ProfilePage() //change it later


      ];


  void handleBackButton(){
   setState(() {  
      _selectedIndex = 0;  
    });  
}


  @override
  Widget build(BuildContext context) {
    


    return Scaffold(
      
 body: Container(
            
            // padding: const EdgeInsets.all(10),
            child: bodyWidgets[_selectedIndex]),

      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height*.12,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20)
          ),
          color: Theme.of(context).primaryColor
        ),
        padding: EdgeInsets.all(10),
        child: BottomNavigationBar(
backgroundColor: Colors.transparent,
    currentIndex: _selectedIndex,  
            selectedItemColor: Colors.white,
            showUnselectedLabels: true,
            unselectedItemColor: Colors.grey,
unselectedLabelStyle: TextStyle(
  color: Colors.grey,fontWeight: FontWeight.w400
),
selectedLabelStyle: TextStyle(
  color: Colors.white,fontWeight: FontWeight.w400
),

      onTap: (index){
 
    setState(() {  
      _selectedIndex = index;  
    });  
  
            },  
            elevation: 0  ,


          items: [
            BottomNavigationBarItem(icon: 
            Icon(Icons.home_filled ,size: 24),
            label: '${tr('home')}'
            ) ,

              BottomNavigationBarItem(icon: 
            Icon(Icons.article ,size: 24,),
            label: '${tr('my_requests')}',
          
            
            
            ) ,

              BottomNavigationBarItem(icon: 
            Container(
              height:  24,
              
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color:_selectedIndex!=2? Colors.grey:Colors.white,
                shape: BoxShape.circle
              ),
              
              child: Center(child: Icon(Icons.more_vert,    color:_selectedIndex!=2?
               Colors.black:
               Colors.black,))),
            label:  '${tr('more')}'
            ) ,

          ],
        ),
      ),
    );
  }
}