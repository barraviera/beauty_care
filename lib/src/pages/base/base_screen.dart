import 'package:beauty_care/src/pages/calendar/calendar_tab.dart';
import 'package:beauty_care/src/pages/profile/profile_tab.dart';
import 'package:flutter/material.dart';

import '../../config/custom_colors.dart';
import '../home/view/home_tab.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {

  int currentIndex = 0;
  //PRECISAMOS DE UM CONTROLADOR DO PAGEVIEW PARA PODER TROCAR DE TELA
  final pageController = PageController(

  );

  @override
  Widget build(BuildContext context) {
    //Para pegarmos o tamanho da tela
    final size = MediaQuery.of(context).size;

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(

        //INDICA QUAL PAGINA ABRIR 0 (PRIMEIRA), 1 (SEGUNDA)...
        currentIndex: currentIndex,
        //TRAZ O INDEX DO BOTAO QUE CLICAMOS
        onTap: (index){
          //SET STATE PARA MUDAR DE ESTADO OU SELECIONAR O BOTAO QUE CLICAMOS
          setState(() {
            currentIndex = index;
            //INDICAMOS PARA O CONTROLADOR DA PAGEVIEW QUE QUEREMOS FAZER UM PULO PARA A TELA QUE RECEBEMOS NO INDEX
            pageController.jumpToPage(index);
          });
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
            label: 'Agenda',
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

      body: PageView(
        controller: pageController,
        //PARA BLOQUEAR O SLIDE LATERAL DAS PAGINAS
        physics: const NeverScrollableScrollPhysics(),

        children: [

          const HomeTab(),
          const CalendarTab(),
          Container(color: Colors.blue,),
          const ProfileTab(),

        ],


      ),

    );
  }
}
