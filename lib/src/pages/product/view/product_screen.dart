import 'dart:io';

import 'package:beauty_care/src/config/custom_colors.dart';
import 'package:beauty_care/src/models/item_model.dart';
import 'package:beauty_care/src/models/schedule_model.dart';
import 'package:beauty_care/src/pages/base/controller/navigation_controller.dart';
import 'package:beauty_care/src/pages/cart/controller/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../services/utils_services.dart';
import '../controller/product_controller.dart';

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
  final cartController = Get.find<CartController>();
  final productController = Get.find<ProductController>();

  DateTime? valorEscolhido;
  //String? valorEscolhido;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    productController.getSchedule( productId: widget.item.id );

  }


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






                      //HORARIOS
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10,),
                        child: Column(
                          //PARA ALINHAR OS TEXTOS A ESQUERDA
                          crossAxisAlignment: CrossAxisAlignment.stretch,

                          children: [

                            const Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Text(
                                'Horários disponíveis:',
                                style: TextStyle(
                                  height: 1.8,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            //DROPDOWN HORARIOS
                            /*
                            GetBuilder<ProductController>(
                              builder: (controller){

                                return

                                DropdownButton<DateTime>(

                                  value: (valorEscolhido == null) ? controller.allSchedule.first.date : valorEscolhido,

                                    items: controller.allSchedule.map((e) {

                                    //Lista os horários
                                    return DropdownMenuItem<DateTime>(

                                      value: e.date,
                                      child: Text( utilsServices.formatDateTime( e.date )),

                                    );

                                  }).toList(),

                                  onChanged: (escolha) => setState((){

                                    valorEscolhido = escolha;

                                    print( escolha );

                                  } ),
                                );


                              }
                            ),

                             */

                            //DROPDOWN HORARIOS
                            /*
                            GetBuilder<ProductController>(
                                builder: (controller){

                                  return

                                    DropdownButton<String>(
                                      hint: const Text('Escolha uma opção'),
                                      value: valorEscolhido,

                                      items: controller.allSchedule.map((e) {

                                        //Lista os horários
                                        return DropdownMenuItem<String>(

                                          value: utilsServices.formatDateTime( e.date ),
                                          child: Text( utilsServices.formatDateTime( e.date )),

                                        );

                                      }).toList(),

                                      onChanged: (escolha) => setState((){

                                        valorEscolhido = escolha!;

                                        DateTime.parse( valorEscolhido! );

                                      } ),
                                    );
                                }
                            ),

                             */


                            GetBuilder<ProductController>(
                                builder: (controller){

                                  return

                                    DropdownButton<DateTime>(
                                      hint: const Text('Escolha uma opção'),
                                      value: valorEscolhido,

                                      items: controller.allSchedule.map((e) {

                                        //Lista os horários
                                        return DropdownMenuItem<DateTime>(

                                          value: e.date,
                                          child: Text( utilsServices.formatDateTime( e.date )),

                                        );

                                      }).toList(),

                                      onChanged: (escolha) => setState((){

                                        valorEscolhido = escolha!;

                                        print( valorEscolhido!.toIso8601String() );

                                      } ),
                                    );
                                }
                            ),




                            const Text(
                              'Descrição:',
                              style: TextStyle(
                                height: 1.8,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                          ],
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
                          onPressed: () async{

                            bool? result = await showOrderConfirmation();

                            if( result ?? false ){

                              //fechar a tela
                              Get.back();
                              cartController.addItemToCart(item: widget.item, schedule: valorEscolhido!.toIso8601String() );
                              //abrir o carrinho
                              navigationController.navigatePageView( NavigationTabs.cart );

                            }else{
                              utilsServices.showToast(message: 'Pedido não confirmado');
                            }

                          },
                          child: const Text('Adicionar na agenda'),
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
                  icon: const Icon(Icons.arrow_back_ios),
              ),
            ),
          ),

        ],
      ),
    );

  }

  //Esta função vai retornar um tipo Bool nullable
  Future<bool?> showOrderConfirmation(){
    return showDialog<bool>(
      //precisamos do contexto da aplicação, por isso criamos este metodo dentro da Stateful
      context: context,
      builder: (context){


        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text('Confirmação'),
          content: Text('Deseja realmente agendar para este dia e horário?'),
          actions: [
            TextButton(
              onPressed: (){
                //Caso clique em nao retornaremos um false
                Navigator.of(context).pop(false);
              },
              child: const Text('Não'),
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: (){
                //Caso clique em sim retornaremos um true
                Navigator.of(context).pop(true);
              },
              child: const Text('Sim'),
            ),
          ],
        );



      },
    );
  }

}
