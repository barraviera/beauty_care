import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

//criamos uma classe abstrata que ja contem os codigos de cada tela
abstract class NavigationTabs {

  static const int home = 0;
  static const int cart = 1;
  static const int orders = 2;
  static const int profile = 3;
}



class NavigationController extends GetxController {

  late PageController _pageController;
  //será o nosso index atual
  late RxInt _currentIndex;

  //criarmos os getters para podermos acessar os atributos privados
  PageController get pageController => _pageController;
  int get currentIndex => _currentIndex.value;

  //Essa classe é sempre a primeira a ser instanciada
  @override
  void onInit() {
    super.onInit();

    initNavigation(
      pageController: PageController(initialPage: NavigationTabs.home),
      currentIndex: NavigationTabs.home,
    );
  }

  //metodo de inicialização da nossa navagação
  void initNavigation({
    required PageController pageController,
    required int currentIndex,
  }){

    _pageController = pageController;
    _currentIndex = currentIndex.obs;
  }

  //metodo responsavel em fazer a paginação
  void navigatePageView( int page ){

    //se na estivermos na pagina, nao queremos que ao clicar no icone seja recarregada novamente
    if( _currentIndex.value == page ) return;

    //passar de pagina
    _pageController.jumpToPage(page);
    _currentIndex.value = page;

  }


}