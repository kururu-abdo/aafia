  import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';

Future<Uint8List> getBytesFromCanvas(int width, int height ,ui.Image image , String bloodType) async {
final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
  final Canvas canvas = Canvas(pictureRecorder);
  final Paint paint = Paint();
  
  // ..color = Colors.blue;
  // final Radius radius = Radius.circular(20.0);
 
      canvas.drawImage(image,  const Offset(0, 0), paint);
  TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
  // painter.im
  painter.text = TextSpan(
    text:bloodType,

    style: TextStyle(fontSize: 25.0, color: Colors.white,
    
    fontWeight: FontWeight.bold
    ),
  );
  painter.layout();
  // painter.paint(canvas,
  //  Offset((width * 0.5) - painter.width * 0.5,
  //   (height * 0.5) - painter.height * 0.5));
painter.paint(canvas,  Offset(40 , (height / 3)));

  final img = await pictureRecorder.endRecording().toImage(height, height);
  // .toImage(width, height);
  final data = await img.toByteData(format: ui.ImageByteFormat.png);
  return data!.buffer.asUint8List();
}
Future<ui.Image> loadImage(String imageAssetPath) async {
  final ByteData data = await rootBundle.load(imageAssetPath);
  
  final codec = await ui.instantiateImageCodec(
    data.buffer.asUint8List(),
    targetHeight: 150,
    // targetWidth: 100,
  );
  
  var frame = await codec.getNextFrame();
  return frame.image;
}

// final Uint8List markerIcon = await getBytesFromCanvas(200, 100);
// final Marker marker = Marker(icon: BitmapDescriptor.fromBytes(markerIcon));








/*

 Set<Marker> markers = {};
    Future<BitmapDescriptor> createCustomMarkerBitmapWithNameAndImage(
      String imagePath, Size size, String name) async {

      
    TextSpan span = new TextSpan(
        style: new TextStyle(
          height: 1.2,
          color: Colors.black,
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
        ),
        text: name);

    TextPainter tp = new TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    tp.layout();

    ui.PictureRecorder recorder = new ui.PictureRecorder();
    Canvas canvas = new Canvas(recorder);

    final double shadowWidth = 15.0;
    final double borderWidth = 3.0;
    final double imageOffset = shadowWidth + borderWidth;


    final Radius radius = Radius.circular(size.width / 2);

    final Paint shadowCirclePaint = Paint()
      ..color = MyTheme.primaryColor.withAlpha(180);

    // Add shadow circle
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(
              size.width / 8, size.width / 2, size.width, size.height),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        shadowCirclePaint);

    // TEXT BOX BACKGROUND
    Paint textBgBoxPaint = Paint()..color = MyTheme.primaryColor;
   
    Rect rect = Rect.fromLTWH(
      0,
      0,
      tp.width + 35,
      50,
    );

    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, Radius.circular(10.0)),
      textBgBoxPaint,
    );
    
    //ADD TEXT WITH ALIGN TO CANVAS
    tp.paint(canvas, new Offset(20.0, 5.0)); 

    /* Do your painting of the custom icon here, including drawing text, shapes, etc. */

    Rect oval = Rect.fromLTWH(35, 78, size.width - (imageOffset * 2),
        size.height - (imageOffset * 2));

   
    // ADD  PATH TO OVAL IMAGE
    canvas.clipPath(Path()..addOval(oval));

    ui.Image image = await getImageFromPath(
        imagePath);
    paintImage(canvas: canvas, image: image, rect: oval, fit: BoxFit.fitWidth);

    ui.Picture p = recorder.endRecording();
    ByteData pngBytes = await (await p.toImage(300, 300))
        .toByteData(format: ui.ImageByteFormat.png);

    Uint8List data = Uint8List.view(pngBytes.buffer);

    return BitmapDescriptor.fromBytes(data);
  }

  Future<ui.Image> getImageFromPath(String imagePath) async {
    File imageFile = File(imagePath);

    Uint8List imageBytes = imageFile.readAsBytesSync();

    final Completer<ui.Image> completer = new Completer();

    ui.decodeImageFromList(imageBytes, (ui.Image img) {
      return completer.complete(img);
    });

    return completer.future;
  }


  Future<BitmapDescriptor> getMarkerIcon(String image, String name) async {
    if (image != null) {
      final File markerImageFile =
          await DefaultCacheManager().getSingleFile(image);
      Size s = Size(120, 120);

      var icon = await createCustomMarkerBitmapWithNameAndImage(markerImageFile.path, s, name);
    
      return icon;
    } else {
      return BitmapDescriptor.defaultMarker;
    }
  }

  */




















Future<Uint8List> getMyLocationMarker(int width, int height ) async {
final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
  final Canvas canvas = Canvas(pictureRecorder);
  final Paint paint = Paint();
   TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
 
  // ..color = Colors.blue;
  // final Radius radius = Radius.circular(20.0);
  final Paint circlePaintFill = Paint()
    ..color = Color(0xFF148F46)
    ..style = PaintingStyle.fill;
  final Paint circlePaintStroke = Paint()
    ..color = Color(0xFF148F46).withOpacity(.5)
    ..style = PaintingStyle.fill
    ..strokeWidth = 5;
       // painter.paint(canvas,
    canvas.drawCircle(Offset(width * 0.5, height * 0.5),
     width * 0.5, circlePaintStroke);
 canvas.drawCircle(Offset(width * 0.5, height * 0.5),
      width * .3, circlePaintFill);

// painter.layout();
// painter.paint(canvas, Offset.zero);

  final img = await pictureRecorder.endRecording().toImage(height, height);
  // .toImage(width, height);
  final data = await img.toByteData(format: ui.ImageByteFormat.png);
  return data!.buffer.asUint8List();
}