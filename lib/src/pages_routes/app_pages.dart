import 'package:beauty_care/src/pages/auth/view/sign_in_screen.dart';
import 'package:beauty_care/src/pages/base/base_screen.dart';
import 'package:beauty_care/src/pages/cart/binding/cart_binding.dart';
import 'package:get/get.dart';

import '../pages/auth/view/sign_up_screen.dart';
import '../pages/base/binding/navigation_binding.dart';
import '../pages/home/binding/home_binding.dart';

abstract class AppPages{

  //lista do tipo GetPage
  static final pages = <GetPage>[

    //Esta é a primeira pagina que aparece logo que abre o app
    GetPage(
      page: () => SignInScreen(),
      name: PagesRoutes.signInRoute,
    ),

    GetPage(
      page: () => SignUpScreen(),
      name: PagesRoutes.signUpRoute,
    ),

    GetPage(
      page: () => BaseScreen(),
      name: PagesRoutes.baseRoute,
      bindings: [
        HomeBinding(),
        NavigationBinding(),
        CartBinding(),
      ],
    ),

  ];

}

abstract class PagesRoutes{

  static const String signInRoute = '/signin';
  static const String signUpRoute = '/signup';
  static const String baseRoute = '/';

}