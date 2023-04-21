import 'package:beauty_care/src/models/item_salon_model.dart';
import 'package:beauty_care/src/pages/salon/controller/salon_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class SalonScreen extends StatefulWidget {


  SalonScreen({
    Key? key,
    required this.itemSalonModel
  }) : super(key: key);


  final ItemSalonModel itemSalonModel;

  @override
  State<SalonScreen> createState() => _SalonScreenState();
}

class _SalonScreenState extends State<SalonScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Stack(

          children: [

            //CONTEUDO
            Column(
              children: [

                Expanded(child:
                Hero(
                  tag: widget.itemSalonModel.imgUrl,
                  child: Image.network(widget.itemSalonModel.imgUrl),
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
                          widget.itemSalonModel.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                          ),
                        ),


                        Text(
                          'Endereço: ${widget.itemSalonModel.address}, ${widget.itemSalonModel.number}, ${widget.itemSalonModel.district} - ${widget.itemSalonModel.city}',
                          style: const TextStyle(
                            height: 1.8,
                          ),
                        ),

                        Text(
                          'Fone: ${widget.itemSalonModel.phone}',
                          style: const TextStyle(
                            height: 1.8,
                          ),
                        ),


                        const Text(
                          'Descrição:',
                          style: TextStyle(
                            height: 1.8,
                            fontWeight: FontWeight.bold,
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
                                    widget.itemSalonModel.description * 3,
                                    style: const TextStyle(
                                      height: 1.5,
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ),

                        Expanded(
                          child: Container(
                            color: Colors.red,
                            child: Text('Veja no mapa'),
                          ),
                        ),

                        //BOTAO
                        ElevatedButton(
                          onPressed: (){},
                          child: const Text('Contato'),
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
}
