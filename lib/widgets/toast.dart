import 'dart:async';

import 'package:flutter/material.dart';
 import 'package:simple_animations/simple_animations.dart';
class ToastUtils {
  static Timer? toastTimer;
  static OverlayEntry? _overlayEntry;

  static void showCustomToast(BuildContext context,
      String message) {

    if (toastTimer == null || !toastTimer!.isActive) {
      _overlayEntry = createOverlayEntry(context, message);
      Overlay.of(context).insert(_overlayEntry!);
      toastTimer = Timer(Duration(seconds: 2), () {
        if (_overlayEntry != null) {
          _overlayEntry!.remove();
        }
      });
    }

  }

  static OverlayEntry createOverlayEntry(BuildContext context,
      String message) {

    return OverlayEntry(
        builder: (context) => Positioned(
              top: 50.0,
              width: MediaQuery.of(context).size.width - 20,
              left: 10,
              child: SlideInToastMessageAnimation(Material(
                elevation: 10.0,
              surfaceTintColor: Colors.grey,
            // shadowColor: Colors.amber,
          clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.circular(10),
                child:
                
                
                
                
                
                
                Stack(
            children: [
              Container(
                width: double.infinity,
                height: 50,
                  padding: const EdgeInsets
                  .symmetric( vertical: 10.0 ,horizontal: 15),
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                
                  ),
                  child:
                      Text(
                        message,
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                        ),
                      ),
               
              ),
    
              Align(alignment: 
              AlignmentDirectional.centerStart ,
              child:  Container(
                width: 10,
                height: 50,
                  padding: const EdgeInsets
                  .symmetric( vertical: 10.0),
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  color: Colors.green[900],
                  ), )
              ,)
            ],
          )
                
                
                
                
                
                
                
                
                //  Container(
                //   // padding:
                //   //     EdgeInsets.only(left: 10, right: 10,
                //   //         top: 13, bottom: 10),
                //   decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.circular(10)),
                //   child: Align(
                //     alignment: Alignment.center,
                //     child: Row(
                //       // mainAxisAlignment: MainAxisAlignment.spaceAround,
                //       children: <Widget>[
                //         // Image.asset('assets/images/ic_done.png', height: 50, width: 50,),
                //        Exp
                //       ],
                //     ),
                //   ),
                // ),
            
            
            
              )),
            ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:simple_animations/simple_animations.dart';

class SlideInToastMessageAnimation extends StatelessWidget {
  final Widget child;

  SlideInToastMessageAnimation(this.child);

  @override
  Widget build(BuildContext context) {
   
 

  

     

      // Specify your tween
    final MovieTween tween = MovieTween()
      ..scene(
             duration: Duration( milliseconds: 2000)
              ,
    curve:  Curves.easeOut,
              )
          .tween('translateY', Tween(begin: -1.0, end: 10.0))
      ..scene(
              // begin: const Duration(milliseconds: 250),
              duration: Duration( milliseconds: 1000))
          .tween('translateY', Tween(begin: 10.0, end: -100.0))
      // ..scene(
      //         // begin: const Duration(milliseconds: 0),
      //         duration: const Duration(milliseconds: 2500))
      //     .tween('translateY', Tween(begin: 0.0, end: 200.0))
      ..scene(
        
              duration: const Duration(milliseconds: 500))
          .tween('opacity', Tween(begin: 0.0, end: 1.0))
          
           ..scene(
              duration: const Duration(seconds: 1))
          .tween('opacity', Tween(begin: 1.0, end: 1.0))
          
           ..scene(
              duration: const Duration(milliseconds: 500))
          .tween('opacity', Tween(begin: 1.0, end: 0.0))
          ;


    return  PlayAnimationBuilder<Movie>(
      duration: tween.duration,
      tween: tween,
      child: child,
      builder: (context, animation, child) => Opacity(
        opacity: animation.get('opacity'),
        child: Transform.translate(
            offset: Offset(0, animation.get("translateY")),
                    child: child),
      ),
    );
  }
  }