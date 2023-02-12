import 'package:beauty_care/src/config/custom_colors.dart';
import 'package:beauty_care/src/models/item_model.dart';
import 'package:beauty_care/src/models/schedule_model.dart';
import 'package:beauty_care/src/pages/base/controller/navigation_controller.dart';
import 'package:beauty_care/src/pages/product/view/components/schedule_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../services/utils_services.dart';

class ProductScreen extends StatefulWidget {


  ProductScreen({
    Key? key,
    required this.item,
  }) : super(key: key);

  final ItemModel item;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  final UtilsServices utilsServices = UtilsServices();

  final navigationController = Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white.withAlpha(230),

      body: Stack(

        children: [

          //CONTEUDO
          Column(
            children: [

              Expanded(child:
                Hero(
                  tag: widget.item.imgUrl,
                    child: Image.network(widget.item.imgUrl),
                ),
              ),

              Expanded(
                flex: 3,
                child:
                Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(50),
                    ),
                    boxShadow: [

                      BoxShadow(
                        color: Colors.grey.shade600,
                        offset: const Offset(0, 2),
                      ),

                    ]
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,

                    children: [

                      //TITULO
                      Text(
                        widget.item.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      //SALAO
                      Text(
                        widget.item.salonName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),

                      //PREÇO
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          utilsServices.priceToCurrency( widget.item.price ),
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: CustomColors.customSwatchColor,
                          ),
                        ),
                      ),




                      //DESCRICAO
                      Expanded(

                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10,),
                          child: SingleChildScrollView(

                            child: Column(
                              //PARA ALINHAR OS TEXTOS A ESQUERDA
                              crossAxisAlignment: CrossAxisAlignment.stretch,

                              children: const [

                                Padding(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    'Horários disponíveis:',
                                    style: TextStyle(
                                      height: 1.8,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),



                              ],
                            ),
                          ),
                        ),
                      ),

                      //DESCRICAO
                      Expanded(

                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10,),
                          child: SingleChildScrollView(

                            child: Column(
                              //PARA ALINHAR OS TEXTOS A ESQUERDA
                              crossAxisAlignment: CrossAxisAlignment.stretch,

                              children: [

                                const Padding(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    'Descrição:',
                                    style: TextStyle(
                                      height: 1.8,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),

                                Text(
                                  widget.item.description * 3,
                                  style: const TextStyle(
                                    height: 1.5,
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),





                      //BOTAO
                      ElevatedButton(
                          onPressed: (){

                            //fechar a tela
                            Get.back();
                            //abrir o carrinho
                            navigationController.navigatePageView( NavigationTabs.cart );

                          },
                          child: Text('Agendar'),
                      ),

                    ],



                  ),

                ),
              ),

            ],
          ),

          //BOTAO DE VOLTAR
          Positioned(
            top: 10,
            left: 10,
            child: SafeArea(
              child: IconButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back_ios),
              ),
            ),
          ),

        ],
      ),
    );

  }
}
