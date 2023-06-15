import 'package:aafia/businessLogic/controllers/localization_controller.dart';
import 'package:aafia/businessLogic/controllers/theme_controller.dart';
import 'package:aafia/controllers/auth_controller.dart';
import 'package:aafia/firebase_options.dart';
import 'package:aafia/pages/splash_page.dart';
import 'package:aafia/services/navigation_service.dart';
import 'package:aafia/services/notification_service.dart';
import 'package:aafia/utils/routes.dart';
import 'package:aafia/utils/themes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'data/dataSources/remote/chache/app_path_provider.dart';
import './di/di_container.dart' as di;
Future firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}


final AndroidInitializationSettings initializationSettingsAndroid = 
  AndroidInitializationSettings('app_icon');

 final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);
bool isAnimating = true;
 main() async{
   WidgetsFlutterBinding.ensureInitialized();
   await di.init();
    await AppPathProvider.initPath();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
    );
  await NotificationService().init(); // 
  await NotificationService().requestIOSPermissions(); //
    await EasyLocalization.ensureInitialized();
  runApp(MultiProvider(
    providers: [
        ChangeNotifierProvider(create: (context) => di.sl<ThemeController>()),
                ChangeNotifierProvider(create: (context) => di.sl<LocalizationProvider>()),

    ],
    child:    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations', // <-- change the path of the translation files 
      fallbackLocale: Locale('en'),
      
      child: const MyApp()),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      
       builder: (context, child) => ResponsiveWrapper.builder(
          child,
          maxWidth: 1200,
          minWidth: 480,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.resize(480, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.resize(1000, name: DESKTOP),
          ],
            background: Container(color: Color(0xFFF5F5F5))
          
          ),
          localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: tr('app_name'),
      theme: AppTheme.lightTheme(context),
      navigatorKey: di.sl<NavigationService>().navigatorKey,
      home: SplashPage() ,
      initialBinding: RootBinding(),
      // routes: routes,
      // onGenerateRoute: myRoutes,
    );
  }
}
class RootBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(
      AuthController()
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
     
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
