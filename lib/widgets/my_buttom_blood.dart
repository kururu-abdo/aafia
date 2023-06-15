import 'package:aafia/main.dart';
import 'package:aafia/utils/colors.dart';
import 'package:aafia/utils/sizes.dart';
import 'package:flutter/material.dart';
enum ButtonState { init, submitting, completed }
class MyButtonBlood extends StatefulWidget {
  final RichText? title;
  final Function()? onTap;
  final bool? isLoading;
  final Color? color;
   MyButtonBlood({ Key? key, this.title, this.onTap, this.isLoading=false, this.color 
  // ignore: prefer_const_constructors
  = AppColors.PRIMARY_COLOR,
  }) : super(key: key);

  @override
  State<MyButtonBlood> createState() => _MyButtonBloodState();
}

class _MyButtonBloodState extends State<MyButtonBlood> {
ButtonState state = ButtonState.init;

  @override
  Widget build(BuildContext context) {




    final buttonWidth = MediaQuery.of(context).size.width;
    // update the UI depending on below variable values
    final isInit = isAnimating || state == ButtonState.init;
    final isDone = state == ButtonState.completed;









    return GestureDetector(
      onTap: (){
        widget.onTap!();
      },
      child: Container(
        height: 50,
        // width: 315,
        margin: EdgeInsets.only(
          bottom: 6
        ),
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(8)
        ),
        child: Center(child: 
        
        widget.isLoading!?CircularProgressIndicator(
          strokeWidth: 1.3,
        ):
        // Text( 

          widget.title!,
          // style: TextStyle(
          //   color: Colors.white ,fontWeight: FontWeight.w500,

          //   fontSize: Sizes.FontSizeMainButton
          // ),
        // ),
        
        ),
      ),
    );


   return  AnimatedContainer(
            duration: Duration(milliseconds: 300),
            onEnd: () => setState(() {
                  isAnimating = !isAnimating;
                }),
            width: state == ButtonState.init ? buttonWidth : 70,
            height: 50,
            // If Button State is Submiting or Completed  show 'buttonCircular' widget as below
            child: isInit ? buildButton() : circularContainer(isDone));
  }

  Widget buildButton() => ElevatedButton(
        style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)
        ) ,
        
        
        backgroundColor:   widget.color,
        ),
        onPressed: () async {
          // here when button is pressed
          // we are changing the state
          // therefore depending on state our button UI changed.
          setState(() {
            state = ButtonState.submitting;
          });
          //await 2 sec // you need to implement your server response here.
          await Future.delayed(Duration(seconds: 2));
          setState(() {
            state = ButtonState.completed;
          });
          await Future.delayed(Duration(seconds: 2));
          setState(() {
            state = ButtonState.init;
          });
        },
        child:
          // Text( 
          
           widget.title!
          //   ,style: TextStyle(
          //   color: Colors.white ,fontWeight: FontWeight.w500,

          //   fontSize: Sizes.FontSizeMainButton
          // ),
          
          // ),
      );

    Widget circularContainer(bool done) {
    final color = done ? Colors.green : Colors.blue;
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: Center(
        child: done
            ? buildButton()
            : const CircularProgressIndicator(
                color: Colors.white,
              ),
      ),
    );
  }
}