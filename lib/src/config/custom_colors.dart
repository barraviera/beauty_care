import 'package:flutter/material.dart';

//CRIAMOS UM MAP DE INT E COLOR COM O NOME DE _swatchOpacity E UNDELINE PRA SER ATRIBUTO PRIVADO E QUE NAO POSSO ACESSAR FORA DESTA CLASSE
Map<int, Color> _swatchOpacity = {

  50 : const Color.fromRGBO(237, 136, 129, 0.1),
  100 : const Color.fromRGBO(237, 136, 129, 0.2),
  200 : const Color.fromRGBO(237, 136, 129, 0.3),
  300 : const Color.fromRGBO(237, 136, 129, 0.4),
  400 : const Color.fromRGBO(237, 136, 129, 0.5),
  500 : const Color.fromRGBO(237, 136, 129, 0.6),
  600 : const Color.fromRGBO(237, 136, 129, 0.7),
  700 : const Color.fromRGBO(237, 136, 129, 0.8),
  800 : const Color.fromRGBO(237, 136, 129, 0.9),
  900 : const Color.fromRGBO(237, 136, 129, 1),

};

List<Color> _colorsGradient = [
  const Color.fromRGBO(238, 190, 131, 1),
  const Color.fromRGBO(237, 136, 129, 1),
  const Color.fromRGBO(236, 100, 130, 1),
];


//CRIAMOS UMA CLASSE ABSTRATA PARA NAO PODE INSTANCIA-LA, MAS SOMENTE ACESSAR SEUS ATRIBUTOS INTERNOS ESTATICOS
abstract class CustomColors {

  static Color customContrastColor = Colors.red.shade700;

  static Color customContrastColorBottomBar = Color.fromRGBO(208, 96, 116, 1);
  static Color customContrastColorAppBar = Color.fromRGBO(238, 190, 131, 1);


  static MaterialColor customSwatchColor = MaterialColor( 0xFFED8881 , _swatchOpacity);

  static BoxDecoration customGradientColor = BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: _colorsGradient,
      ),
  );

}