import 'package:aafia/utils/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

enum AlertType {
  INFO ,DELETE
}
class DecisionAlert extends StatefulWidget {
  final Function()? onYes;
  final Function()? onCance;
  final AlertType? alertType;
  final String? title;
  final String? body;
   DecisionAlert({ Key? key, this.onYes, this.onCance, this.alertType=AlertType.INFO, this.title, this.body }) : super(key: key);

  @override
  _DecisionAlertState createState() => _DecisionAlertState();
}

class _DecisionAlertState extends State<DecisionAlert> {
  @override
  Widget build(BuildContext context) {
    return 
    Builder(
builder: (context){
if (widget.alertType==AlertType.DELETE) {
return   Theme(
                                                         data: ThemeData(dialogBackgroundColor: Colors.white),

  child:   AlertDialog( // 
 shape: RoundedRectangleBorder(
   borderRadius: BorderRadius.circular(20)
 ),
  contentPadding: EdgeInsets.symmetric(
    vertical: 27, horizontal: 18
  ),
          title: Container(
  //   padding: EdgeInsets.all(
  // 29
  //   ),
    height: 100,width: 100,

    margin: EdgeInsets.only(
      bottom: 17
    ),
    decoration: BoxDecoration(
      shape: BoxShape.circle,color: 
      AppColors.ONBACKGROUND,
    
  
    ),
    child:Center(
      child: Image.asset('assets/images/png/trash-Filled.png' ,height: 40,width: 40,),
    ) ,
    
    ),
          content: Builder(
            builder: (context) {
  
              var height = MediaQuery.of(context).size.height;
          var width = MediaQuery.of(context).size.width;
  
  
              return Container(
    //  height: 356,
            // width: width - 200,            
              child: SingleChildScrollView(
                  child: ListBody(
                    children:  <Widget>[
                     Text(widget.title!,
              textAlign: TextAlign.center,
              maxLines: 2,
                      overflow: TextOverflow.ellipsis,
              
              style: TextStyle(color: Colors.red ,
              fontWeight: FontWeight.w500,fontSize: 16
              
              ),
              ),    
              
              SizedBox(height: 14,),
              
              
              Text
                      (widget.body!,
                      
                      
                      textAlign: TextAlign.center,
                      // overflow: TextOverflow.ellipsis,
              // maxLines: 2,
              style: TextStyle(color: Colors.black
              
              ),
                      
                      
                      
                      
                      
                      ),
                    ],
                  ),
                ),
              );
            }
          ),
          actionsAlignment: MainAxisAlignment.center,
          actionsOverflowButtonSpacing: 8,
          actionsPadding: EdgeInsets.only(
            bottom: 34
          ),
          actions: <Widget>[
       
  
              Container(
                height: 50,
                width: 124,
                // width: 80,
                child: ElevatedButton(
                  style: ButtonStyle(
                     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(color: Colors.green)
                  )
                ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.green
                    )
                  ),
                  
                  onPressed: () => Navigator.of(context).pop(false),
                   //return false when click on "NO"
                  child:Text('${tr('cancel')}' ,style: TextStyle(
                    color: Colors.white,fontSize: 14,fontWeight: FontWeight.w400
                  ),),
                ),
              ),
  
              Container(
                 height: 50,
                    width: 124,
                child: ElevatedButton(
                  onPressed:(){
                    widget.onYes!();
                    Navigator.pop(context);
                  }, 
                  //return true when click on "Yes"
              
                  style: ButtonStyle( backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.white
                    ),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(color: Color(0xFF979797))
                  )
                ),
                 
                  
                  ),
                  child:Text(
                    widget.alertType==AlertType.DELETE?
                    '${tr('delete_btn')}':'Yes',style: TextStyle(
                    color: Colors.grey, fontSize: 14,fontWeight: FontWeight.w400
                  ),
                  ),
                ),
              ),
  
          ],
        ),
);
}
else if (widget.alertType==AlertType.INFO) {
  return Container();
}
else{
  return Container();
}
},
    );
    
    AlertDialog(
          title:
          AlertType==AlertType.DELETE?

Container(
  padding: EdgeInsets.all(15),
  decoration: BoxDecoration(
    shape: BoxShape.circle,color: AppColors.SPLASH_COLOR,

  ),

  child: Center(
    child: Icon(Icons.delete ,  color: Colors.red,),
  ),
):
          
          
           Text(widget.title!.toString() ,
          
          style: TextStyle( 

          ),
          ),
          content: Column(
            children: [
Text(widget.title!,
textAlign: TextAlign.center,
maxLines: 2,
              overflow: TextOverflow.ellipsis,

style: TextStyle(color: Colors.red

),
),













              Text
              (widget.body!,
              
              
              textAlign: TextAlign.center,
              // overflow: TextOverflow.ellipsis,
// maxLines: 2,
style: TextStyle(color: Colors.black

),
              
              
              
              
              
              ),
          

            Container(
              height: 50,
              width: 80,
              child: ElevatedButton(
                style: ButtonStyle(
                   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(color: Colors.green)
                )
              ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.green
                  )
                ),
                
                onPressed: () => Navigator.of(context).pop(false),
                 //return false when click on "NO"
                child:Text('Cancel' ,style: TextStyle(
                  color: Colors.white
                ),),
              ),
            ),

            Container(
               height: 50,
              width: 80,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true), 
                //return true when click on "Yes"
            
                style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(color: Colors.grey)
                )
              ),
               
                
                ),
                child:Text(
                  widget.alertType==AlertType.DELETE?
                  'Delete':'Yes',style: TextStyle(
                  color: Colors.grey
                ),
                ),
              ),
            ),
  ],
          ),

          actionsAlignment: MainAxisAlignment.center,
          actions:[


            Container(
              height: 50,
              width: 80,
              child: ElevatedButton(
                style: ButtonStyle(
                   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(color: Colors.green)
                )
              ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.green
                  )
                ),
                
                onPressed: () => Navigator.of(context).pop(false),
                 //return false when click on "NO"
                child:Text('Cancel' ,style: TextStyle(
                  color: Colors.white
                ),),
              ),
            ),

            Container(
               height: 50,
              width: 80,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true), 
                //return true when click on "Yes"
            
                style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(color: Colors.grey)
                )
              ),
               
                
                ),
                child:Text(
                  widget.alertType==AlertType.DELETE?
                  'Delete':'Yes',style: TextStyle(
                  color: Colors.grey
                ),
                ),
              ),
            ),

          ],
        );
  }
}