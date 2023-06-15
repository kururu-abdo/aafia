import 'package:aafia/pages/home.dart';
import 'package:get/get.dart';
class Route{

   static String userDashboard = '/dashboard';
 
  getArgument(){
    return {};
  }
}
appRoutes() => [
      GetPage(
        name: '/home',
        page: () => HomePAge(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 500),
      ),
    
    ];
//Get.to(OneScreen(), arguments: {‘someArgument: ‘someInfo’})
//Get.arguments['someArgument'] // someInfo
class MyMiddelware extends GetMiddleware {
  @override
  GetPage? onPageCalled(GetPage? page) {
    print(page?.name);
    return super.onPageCalled(page);
  }
}
