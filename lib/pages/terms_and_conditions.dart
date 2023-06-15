import 'package:aafia/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TermsAndConditionsPage extends StatefulWidget {
  const TermsAndConditionsPage({ Key? key }) : super(key: key);

  @override
  _TermsAndConditionsPageState createState() => _TermsAndConditionsPageState();
}

class _TermsAndConditionsPageState extends State<TermsAndConditionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.SPLASH_COLOR,
      appBar: AppBar(
leading: IconButton(onPressed: (){
  Get.back();
}, icon: Icon(Icons.arrow_back_ios ,color: Colors.black,)),
        elevation: 0,
        backgroundColor: Colors.transparent,
title: Text('Terms and Conditions' ,  style: TextStyle(
  color: Theme.of(context).primaryColor ,  fontWeight: FontWeight.bold ,fontSize: 18
),),
      


      ),

body: SizedBox.expand(
  child:
     Stack(
         alignment: Alignment.center, // <---------
       children: [
         Align(
           alignment: Alignment.bottomCenter,
           child: SizedBox(
             
             child: Stack(
                      
                      alignment: AlignmentDirectional.topCenter,
                      // fit: StackFit.passthrough,
                      children: <Widget>[
                        // Align(

                        //   alignment: Alignment.topCenter,
                        //   child: ,
                        // ),
                        Container(
                          height: MediaQuery.of(context).size.height*.75,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),





                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 60.0,
                                    
                                    left: 10,right: 10 ,bottom: 10
                                    ),
                                    child: Text(
                                      'fsjfksjkldfjksdjfsdjka;fjdsk;ajfkd , iaidsifudspfudpsufd, iauoifsidfuidsfisudfipusdi .fdsofidsiofuisdufiusdifusdifu , ifoidfui   sdkfjdsk kjsdfjdk kjdsfjsdpi kjdjfijds  ,  fkjdkji ijdfipdsjf ksipfusdp psdiufpidsu oiasfiuiad,oiaufiodu iuapidsuf iusidu ,  fsjfksjkldfjksdjfsdjka;fjdsk;ajfkd , iaidsifudspfudpsufd, iauoifsidfuidsfisudfipusdi .fdsofidsiofuisdufiusdifusdifu , ifoidfui   sdkfjdsk kjsdfjdk kjdsfjsdpi kjdjfijds  ,  fkjdkji ijdfipdsjf ksipfusdp psdiufpidsu oiasfiuiad,oiaufiodu iuapidsuf iusidu  ,  fsjfksjkldfjksdjfsdjka;fjdsk;ajfkd , iaidsifudspfudpsufd, iauoifsidfuidsfisudfipusdi .fdsofidsiofuisdufiusdifusdifu , ifoidfui   sdkfjdsk kjsdfjdk kjdsfjsdpi kjdjfijds  ,  fkjdkji ijdfipdsjf ksipfusdp psdiufpidsu oiasfiuiad,oiaufiodu iuapidsuf iusidu ,  fsjfksjkldfjksdjfsdjka;fjdsk;ajfkd , iaidsifudspfudpsufd, iauoifsidfuidsfisudfipusdi .fdsofidsiofuisdufiusdifusdifu , ifoidfui   sdkfjdsk kjsdfjdk kjdsfjsdpi kjdjfijds  ,  fkjdkji ijdfipdsjf ksipfusdp psdiufpidsu oiasfiuiad,oiaufiodu iuapidsuf iusidu',
                                      
                                      maxLines: 9999,
                                      textAlign: TextAlign.justify,
                                      style: Theme.of(context).textTheme.bodyMedium,
                                    ),
                                  ),
                        ),
                        // Positioned(
                        //   top: -100,
                        //   child:
                        // Image.asset('assets/images/png/condations.png')
                          
                        //   //  CircleAvatar(
                        //   //   radius: 50,
                        //   //   backgroundImage:
                        //   //       AssetImage('assets/images/png/condations.png'),
                        //   // ),
                        // )
                      ],
                    ),
           ),
         ),
          Positioned(
                          top:  30,
                          
                         

                          child:
                        Center(child: Image.asset('assets/images/png/condations.png'
                       
                        
                        ))
                          
                          //  CircleAvatar(
                          //   radius: 50,
                          //   backgroundImage:
                          //       AssetImage('assets/images/png/condations.png'),
                          // ),
                        )
       ],
     ),
   
    
),



  //  bottomSheet:   
   
  //  SizedBox(
  //      height: MediaQuery.of(context).size.height/2,
  //    child: 


  //    Stack(
              
  //             alignment: AlignmentDirectional.topCenter,
  //             // fit: StackFit.expand,
  //             children: <Widget>[
  //               // Align(

  //               //   alignment: Alignment.topCenter,
  //               //   child: ,
  //               // ),
  //               Container(
  //                 height: MediaQuery.of(context).size.height/2,
  //                 width: double.infinity,
  //                 decoration: BoxDecoration(
  //                     color: Colors.amberAccent,
  //                     borderRadius: BorderRadius.only(
  //                         topLeft: Radius.circular(20),
  //                         topRight: Radius.circular(20))),

  //                         child: Text(
  //                           'sd',
  //                           maxLines: 9999,
  //                           textAlign: TextAlign.justify,
  //                         ),
  //               ),
  //               Positioned(
  //                 top: -50,
  //                 child:
  //               Image.asset('assets/images/png/condations.png')
                  
  //                 //  CircleAvatar(
  //                 //   radius: 50,
  //                 //   backgroundImage:
  //                 //       AssetImage('assets/images/png/condations.png'),
  //                 // ),
  //               )
  //             ],
  //           ),
   
   
  //  )
   
   
   
    );
  }
}