import 'package:beauty_care/src/config/custom_colors.dart';
import 'package:beauty_care/src/pages/auth/controller/auth_controller.dart';
import 'package:beauty_care/src/pages_routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() {

  //para ter certeza que tudo o que precisa ja está inicializado
  WidgetsFlutterBinding.ensureInitialized();

  //definimos que a orientação da tela será somente na vertical
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(const MyApp());
  });

  //vamos injetar a classe AuthController na memoria do dispositivo para podermos acessa-la de qualquer lugar do app
  Get.put( AuthController() );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //trocamos o Material pelo GetMaterialApp para o GetX funcionar
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: CustomColors.customSwatchColor,
        //PARA GENERALIZAR A COR PARA TODOS SCAFFOLD
        scaffoldBackgroundColor: Colors.white.withAlpha(190),
      ),
      debugShowCheckedModeBanner: false,

      //home: const SignInScreen(),
      initialRoute: PagesRoutes.signInRoute,

      getPages: AppPages.pages,
    );
  }
}
