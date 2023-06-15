

import 'package:aafia/pages/home.dart';
import 'package:aafia/pages/my_requests.dart';
import 'package:aafia/pages/pharmacy/advertisements.dart';
import 'package:aafia/pages/pharmacy/home_pharmacy.dart';
import 'package:aafia/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

class PharmacyDashboardPage extends StatefulWidget {
  const PharmacyDashboardPage({ Key? key }) : super(key: key);

  @override
  _PharmacyDashboardPageState createState() => _PharmacyDashboardPageState();
}

class _PharmacyDashboardPageState extends State<PharmacyDashboardPage> {


@override
  void initState() {
    // TODO: implement initState
    super.initState();
 
 //from ot
 Future.microtask(() {

     MotionToast(
  // icon: Icons.alarm,
  height: 80,
  width: 300,
  position: MotionToastPosition.top,
  backgroundType: BackgroundType.lighter,
  primaryColor: Colors.green,
barrierColor:Colors.grey[500]!,
  description: Text(' \"Your Account has been verified\"'),
).show(context);

 });
  }

  static int _selectedIndex = 0;  


      void _onItemTapped(int index) {  
    setState(() {  
      _selectedIndex = index;  
    });  
  }  


 
final List<Widget> bodyWidgets = <Widget>[  
      HomeParmacy() ,
     AdvertisementsPage(),
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



      onTap: (index){
 
    setState(() {  
      _selectedIndex = index;  
    });  
  
            },  
            elevation: 0  ,


          items: [
            BottomNavigationBarItem(icon: 
            Icon(Icons.home_filled),
            label: 'Home'
            ) ,
              BottomNavigationBarItem(icon: 
            Icon(Icons.article),
            label: 'Requests',
            
            ) ,

              BottomNavigationBarItem(icon: 
            Container(
              height: 30,
              
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle
              ),
              
              child: Center(child: Icon(Icons.more_vert))),
            label: 'More'
            ) ,

          ],
        ),
      ),
    );
  }
}