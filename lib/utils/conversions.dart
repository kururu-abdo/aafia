
import 'package:intl/intl.dart' as intl;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
birthDateFormate(DateTime date){
  final f = new DateFormat('yyyy-MM-dd' ,  "en");

  return f.format(date);
}

requestTimeFormat(DateTime date){
  // ignore: unnecessary_new
  final f = new DateFormat('yyyy-MM-dd hh:mm' ,"en"  );

  return f.format(date);
}

getTimeAgo(String date){
  DateTime d =DateTime.parse(date);
  final fifteenAgo = DateTime.now().subtract(  (DateTime.now().difference(d))  );

    print(timeago.format(fifteenAgo)); // 15 minutes ago
    print(timeago.format(fifteenAgo, locale:Get.locale!.languageCode=="en"? 'en_short':
    "ar")); // 15m
    print(timeago.format(fifteenAgo, locale: 'es')); // hac

    return timeago.format(fifteenAgo, locale:Get.locale!.languageCode=="en"? 
    'en_short':"ar_short");
}