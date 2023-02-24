import 'package:beauty_care/src/pages/base/controller/navigation_controller.dart';
import 'package:beauty_care/src/pages/profile/profile_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../config/custom_colors.dart';
import '../cart/cart_tab.dart';
import '../home/view/home_tab.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {

  final navigationController = Get.find<NavigationController>();

  //não iremos mais precisar dessas duas variaveis pois estamos usando o navigation_binding para navegar entre telas
  //int currentIndex = 0;
  //PRECISAMOS DE UM CONTROLADOR DO PAGEVIEW PARA PODER TROCAR DE TELA
  //final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    //Para pegarmos o tamanho da tela
    final size = MediaQuery.of(context).size;

    return Scaffold(
      bottomNavigationBar: Obx(() =>

          BottomNavigationBar(

          //INDICA QUAL PAGINA ABRIR 0 (PRIMEIRA), 1 (SEGUNDA)...
          currentIndex: navigationController.currentIndex,
          //TRAZ O INDEX DO BOTAO QUE CLICAMOS
          onTap: (index){

            //vamos usar a reatividade do GetX para podermos mudar a seleção do bottom navigation bar
            //passamos o index que estamos recebendo do bottom navigation bar
            navigationController.navigatePageView( index );

          },
          //PARA OS BOTOES DA BARRA INFERIOR APARECEREM
          type: BottomNavigationBarType.fixed,
          //COR DO FUNDO DA BARRA INFERIOR
          backgroundColor: CustomColors.customContrastColorBottomBar,
          //PARA REMOVER A SOMBRA
          elevation: 0,
          //COR DO BOTAO SELECIONADO
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withAlpha(100),

          items: const [

            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_outlined),
              label: 'Carrinho',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_mall_outlined),
              label: 'Salões',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Perfil',
            ),


          ],
        ),
      ),

      body: PageView(
        controller: navigationController.pageController,
        //PARA BLOQUEAR O SLIDE LATERAL DAS PAGINAS
        physics: const NeverScrollableScrollPhysics(),

        children: [

          const HomeTab(),
          const CartTab(),
          Container(color: Colors.blue,),
          const ProfileTab(),

        ],


      ),

    );
  }
}
