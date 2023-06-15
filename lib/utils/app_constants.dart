import 'package:aafia/data/models/languageModel.dart';

class AppConstants {
  
//apis
static const String BASE_URL ='https://afeia.net/';

static const String LOGIN_URI ='api/v1/login';
static const String SIGNUP_URI ='api/v1/singup';



//sharedPrefs
static const String TOKEN ='token';

static const String COUNTRY_CODE ='country_code';
static const String LANG_KEY ='language_key';

static const  String? COUNTRY_PHONE_CODE='+249';
static const String?  GOOGLE_MAP_KEY="AIzaSyCsE5KDJqjPpbTHsQFqSjnJHclQuCBw8c4";
//languages
static  List<LanguageModel> languages = 

[
  LanguageModel(countryCode: 'US',languageCode: 'en' ,
  languageName: 'English'
  
   ) ,

  LanguageModel(countryCode: 'KSA',languageCode: 'ar' ,
  
  languageName: 'العربية'
  )
];


}