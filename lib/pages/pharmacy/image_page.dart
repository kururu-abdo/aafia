import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImagePage extends StatelessWidget {
  final String?  title;
  final String? image;
  const ImagePage({ Key? key, this.title, this.image }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        title: Text(title! ,
        
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold ,fontSize: 20
        ),
        ),
        centerTitle: true,
        elevation: 0, 
        backgroundColor: Colors.transparent,

leading: IconButton(onPressed: (){
Get.back();

}, icon: Icon(Icons.arrow_back_ios , color: Colors.black,)),

      ),
body: Center(

  child: Container(

    height: 500,
    decoration: BoxDecoration(

      image: DecorationImage(image: NetworkImage(
        image!
      ),fit: BoxFit.cover)
    ),
  ),
),

      
    );
  }
}