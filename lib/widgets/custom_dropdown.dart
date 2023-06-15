import 'package:aafia/utils/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatefulWidget   {
  /// the child widget for the button, this will be ignored if text is supplied
  final Widget? child;

  /// onChange is called when the selected option is changed.;
  /// It will pass back the value and the index of the option.
  final void Function(T, int)? onChange;

  /// list of DropdownItems
   List<DropdownItem<T>>? items=[];
  final DropdownStyle? dropdownStyle;

  /// dropdownButtonStyles passes styles to OutlineButton.styleFrom()
  final DropdownButtonStyle dropdownButtonStyle;

  /// dropdown button icon defaults to caret
  final Icon? icon;
  final bool? hideIcon;

  /// if true the dropdown icon will as a leading icon, default to false
  final bool leadingIcon;
  CustomDropdown({
    Key? key,
    this.hideIcon = false,
    @required this.child,
     this.items,
    this.dropdownStyle = const DropdownStyle(),
    this.dropdownButtonStyle = const DropdownButtonStyle(),
    this.icon,
    this.leadingIcon = false,
    this.onChange,
  }) : super(key: key);

  @override
  _CustomDropdownState<T> createState() => _CustomDropdownState<T>();
}

/*

 child: CustomDropdown<int>(
        child: Text(
          'dropdown',
        ),
        onChange: (int value, int index) => print(value),
        dropdownButtonStyle: DropdownButtonStyle(
          width: 170,
          height: 40,
          elevation: 1,
          backgroundColor: Colors.white,
          primaryColor: Colors.black87,
        ),
        dropdownStyle: DropdownStyle(
          borderRadius: BorderRadius.circular(8),
          elevation: 6,
          padding: EdgeInsets.all(5),
        ),
        items: [
          'item 1',
          'item 2',
          'item 3',
          'item 4',
        ]
            .asMap()
            .entries
            .map(
              (item) => DropdownItem<int>(
            value: item.key + 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(item.value),
            ),
          ),
        )
            .toList(),
      ),
    ),

*/
class _CustomDropdownState<T> extends State<CustomDropdown<T>>
    with TickerProviderStateMixin {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;
  int _currentIndex = -1;
  AnimationController? _animationController;
  Animation<double>? _expandAnimation;
  Animation<double>? _rotateAnimation;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _expandAnimation = CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeInOut,
    );
    _rotateAnimation = Tween(begin: 0.0, end: 0.5).animate(CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeInOut,
    ));
  }

  @override
  Widget build(BuildContext context) {
    var style = widget.dropdownButtonStyle;
    // link the overlay to the button
    return CompositedTransformTarget(
      link: this._layerLink,
      child: Container(
        width: style.width,
        height: style.height,
           margin: EdgeInsets.symmetric(vertical: 4),

   padding:  EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          decoration:
           BoxDecoration(
                            borderRadius: BorderRadius.circular(7),

               color:     AppColors.TEXT_FILLED_COLOR,

            boxShadow: [
              // BoxShadow(
              //   color: Color(0xFF00000029),
              //   offset: Offset(0, 0),
              //   blurRadius: 18,blurStyle: BlurStyle.outer
              // )
            ]
          ),

        child:
    
            GestureDetector(
              onTap: _toggleDropdown,
              child: Container(
              // padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                // decoration: BoxDecoration(
                //     border: Border.all(width: 1.0, color: Colors.black26),
                //       borderRadius: BorderRadius.circular(5)
                      
                // ),
                child: Row(
                  mainAxisAlignment:
                      style.mainAxisAlignment ??
                       MainAxisAlignment.spaceBetween,
                  children: [
            Container(  
              // padding: style.padding,
            decoration: BoxDecoration(
              color: style.backgroundColor,
            ),
            child: 
        
        
          //   Row(
          //      mainAxisAlignment:
          //           style.mainAxisAlignment ?? MainAxisAlignment.spaceEvenly,
          //       textDirection:
          //           widget.leadingIcon ? TextDirection.rtl : TextDirection.ltr,
          //           children: [

          // if   (_currentIndex == -1) ...[
          //             widget.child!]
          //        else 
          //            ...[ widget.items![_currentIndex], ]
          //           ],
          //   )
            
                (_currentIndex == -1)?
                      widget.child!
                 : 
                     widget.items![_currentIndex], 
                        
            ),
             Container( 
               
                   padding: style.padding,           
                //  padding: style.padding,
// height: double.infinity,
               width: 50,


//                 decoration: BoxDecoration(
//                     border:
//                       direction==   TextDirection.ltr?
//     const Border(
// left:  BorderSide(
//   color: Colors.black54 ,width: 1
// )
//     ) :
    
//      const Border(
// right:  BorderSide(
//   color: Colors.black54 ,width: 1
// )
//     ) ,
    
                    
                    
//                     //  Border.all(width: 1.0, color: Colors.black26),
//                       // borderRadius: BorderRadius.circular(5)
                      
//                 ),
         
         
         
            child:
            
         
                      RotationTransition(
                        turns: _rotateAnimation!,
                        child: widget.icon ?? Icon(Icons.keyboard_arrow_down),
                      ),
             
             )
                  ],
                ),
              ),
            )
           


        //  OutlinedButton(
        //   style: OutlinedButton.styleFrom(
        //     padding: style.padding,
        //     backgroundColor: Colors.white,
        //     elevation: style.elevation,
        //     primary: style.primaryColor,
        //     side: BorderSide.none,
        //     shape: RoundedRectangleBorder(
        //         // side: BorderSide(width: 5.0, color: Colors.blue),
        //         borderRadius: BorderRadius.circular(7)
        //         ),
        //   ),
        //   onPressed: _toggleDropdown,
        //   child: Row(
        //     mainAxisAlignment:
        //         style.mainAxisAlignment ?? MainAxisAlignment.spaceEvenly,
        //     textDirection:
        //         widget.leadingIcon ? TextDirection.rtl : TextDirection.ltr,
        //     mainAxisSize: MainAxisSize.max,
        //     children: [
        //       if (_currentIndex == -1) ...[
        //         widget.child!,
        //       ] else ...[
        //         widget.items![_currentIndex],
        //       ],
        //       if (!widget.hideIcon!)
        //         RotationTransition(
        //           turns: _rotateAnimation!,
        //           child: Icon(Icons.keyboard_arrow_down)
        //         ),
        //     ],
        //   ),
        // ),
      
      
      
      ),
    );
  }
 OverlayEntry _createOverlayEntry() {
    // find the size and position of the current widget
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;

    var offset = renderBox.localToGlobal(Offset.zero);
    var topOffset = offset.dy + size.height + 5;
    return OverlayEntry(
      // full screen GestureDetector to register when a
      // user has clicked away from the dropdown
      builder: (context) => GestureDetector(
        onTap: () => _toggleDropdown(close: true),
        behavior: HitTestBehavior.translucent,
        // full screen container to register taps anywhere and close drop down
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Positioned(
                left: offset.dx,
                top: topOffset,
                width: widget.dropdownStyle!.width ?? size.width,
                child: CompositedTransformFollower(
                  offset: widget.dropdownStyle!.offset ??
                      Offset(0, size.height + 5),
                  link: this._layerLink,
                  showWhenUnlinked: false,
                  child: Material(
                    elevation: widget.dropdownStyle!.elevation ?? 0,
                    borderRadius:
                        widget.dropdownStyle!.borderRadius ?? BorderRadius.zero,
                    color: widget.dropdownStyle!.color,
                    child: SizeTransition(
                      axisAlignment: 1,
                      sizeFactor: _expandAnimation!,
                      child: ConstrainedBox(
                        constraints: widget.dropdownStyle!.constraints ??
                            BoxConstraints(
                              maxHeight: MediaQuery.of(context).size.height -
                                  topOffset -
                                  15,
                            ),
                        child: ListView(
                          padding:
                              widget.dropdownStyle!.padding ?? EdgeInsets.zero,
                          shrinkWrap: true,
                          children: widget.items!.asMap().entries.map((item) {
                            return InkWell(
                              onTap: () {
                                setState(() => _currentIndex = item.key);
                                widget.onChange!(item.value.value!, item.key);
                                _toggleDropdown();
                              },
                              child: item.value,
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
//   OverlayEntry _createOverlayEntry() {
//     // find the size and position of the current widget
//     RenderBox renderBox = context.findRenderObject() as RenderBox;
//     var size = renderBox.size;

//     var offset = renderBox.localToGlobal(Offset.zero);
//     var topOffset = offset.dy + size.height + 5;
//     return OverlayEntry(
//       // full screen GestureDetector to register when a
//       // user has clicked away from the dropdown
//       builder: (context) => GestureDetector(
//         onTap: () => _toggleDropdown(close: true),
//         behavior: HitTestBehavior.translucent,
//         // full screen container to register taps anywhere and close drop down
//         child: Container(
//           height: MediaQuery.of(context).size.height,
//           width: MediaQuery.of(context).size.width,
         
// padding: EdgeInsets.only(
//   left: 18,right: 18,top: 9
// ),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(12),
//              color: Color(0xFFF2F2F2),
//           ),
//           child: Stack(
//             children: [
//               Positioned(
//                 left: offset.dx,
//                 top: topOffset,
//                 width: widget.dropdownStyle!.width ?? size.width,

//                 child: CompositedTransformFollower(
//                   offset: widget.dropdownStyle!.offset ??
//                       Offset(0, size.height + 5),
//                   link: this._layerLink,
//                   showWhenUnlinked: false,
//                   child: Material(
//                     elevation: widget.dropdownStyle!.elevation ?? 0,
//                         borderRadius: BorderRadius.circular(12),
//                              color: Color(0xFFF2F2F2),

//                     child: SizeTransition(
//                       axisAlignment: 1,
//                       sizeFactor: _expandAnimation!,
//                       child: ConstrainedBox(
//                         constraints: widget.dropdownStyle!.constraints ??
//                             BoxConstraints(
//                               maxHeight: MediaQuery.of(context).size.height -
//                                   topOffset -
//                                   15,
//                             ),
//                         child: ListView(
//                           padding:
//                               widget.dropdownStyle!.padding ?? EdgeInsets.zero,
//                           shrinkWrap: true,
//                           children: widget.items!.asMap().entries.map((item) {
//                             return InkWell(
//                               onTap: () {
//                                 setState(() => _currentIndex = item.key);
//                                 widget.onChange!(item.value.value!
//                                 , item.key);
//                                 _toggleDropdown();
//                               },
//                               child: item.value,
//                             );
//                           }).toList(),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

  void _toggleDropdown({bool close = false}) async {
    if (_isOpen || close) {
      await _animationController!.reverse();
      this._overlayEntry!.remove();
      setState(() {
        _isOpen = false;
      });
    } else {
      this._overlayEntry = this._createOverlayEntry();
      Overlay.of(context).insert(this._overlayEntry!);
      setState(() => _isOpen = true);
      _animationController!.forward();
    }
  }
}

/// DropdownItem is just a wrapper for each child in the dropdown list.\n
/// It holds the value of the item.
class DropdownItem<T> extends StatelessWidget {
  final T? value;
  final Widget? child;

  const DropdownItem({Key? key, this.value, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return child!;
  }
}

class DropdownButtonStyle {
  final MainAxisAlignment? mainAxisAlignment;
  final ShapeBorder? shape;
  final double? elevation;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final BoxConstraints? constraints;
  final double? width;
  final double? height;
  final Color? primaryColor;
  const DropdownButtonStyle({
    this.mainAxisAlignment,
    this.backgroundColor,
    this.primaryColor,
    this.constraints,
    this.height,
    this.width,
    this.elevation,
    this.padding,
    this.shape,
  });
}

class DropdownStyle {
  final BorderRadius? borderRadius;
  final double? elevation;
  final Color? color;
  final EdgeInsets? padding;
  final BoxConstraints? constraints;

  /// position of the top left of the dropdown relative to the top left of the button
  final Offset? offset;

  ///button width must be set for this to take effect
  final double? width;

  const DropdownStyle({
    this.constraints,
    this.offset,
    this.width,
    this.elevation,
    this.color,
    this.padding,
    this.borderRadius,
  });
}