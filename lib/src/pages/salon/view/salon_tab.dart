import 'package:beauty_care/src/pages/salon/controller/salon_controller.dart';
import 'package:beauty_care/src/pages/salon/view/components/item_salon_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../config/custom_colors.dart';
import '../../common_widgets/custom_shimmer.dart';

class SalonTab extends StatefulWidget {
  const SalonTab({Key? key}) : super(key: key);

  @override
  State<SalonTab> createState() => _SalonTabState();
}

class _SalonTabState extends State<SalonTab> {
  @override
  Widget build(BuildContext context) {

    //Para pegarmos o tamanho da tela
    final size = MediaQuery.of(context).size;

    //criamos um controlador para o campo de pesquisa
    final searchController = TextEditingController();

    return Scaffold(

      //APPBAR
      appBar: AppBar(
        backgroundColor: CustomColors.customContrastColorBottomBar,
        //PARA REMOVER A SOMBRA
        elevation: 0,
        centerTitle: true,
        title: const Text.rich(
          TextSpan(
            style: TextStyle(fontSize: 22,),
            children: [
              TextSpan(text: 'Salões', style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),

      body: Column(

        children: [

          GetBuilder<SalonController>(

              builder: (controller) {

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),

                  child: TextFormField(
                    controller: searchController,

                    //no onChange conseguimos pegar o texto digitado no campo de pesquisa
                    onChanged: (value){

                      //vamos pegar o que foi digitado e enviar para a variavel observavel searchTile
                      //que declaramos em salon_controller
                      controller.searchTile.value = value;

                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      isDense: true,
                      hintText: 'Pesquise aqui...',
                      hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 14,
                      ),

                      //caso tenha texto no campo de pesquisa iremos mostrar um icon, senao nao mostraremos nada
                      suffixIcon: controller.searchTile.value.isNotEmpty
                          ?
                      IconButton(
                        onPressed: (){

                          //remover tudo que tem escrito no campo de pesquisa
                          searchController.clear();
                          //vamos zerar o conteudo de searchTile usando o controlador que criamos para o campo de pesquisa
                          controller.searchTile.value = '';
                          //e fechar o teclado
                          FocusScope.of(context).unfocus();

                        },
                        icon: Icon(Icons.close, color: CustomColors.customContrastColor, size: 21,),
                      ) : null,

                      prefixIcon: Icon(Icons.search, color: CustomColors.customContrastColor, size: 21,),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(60),
                        borderSide: const BorderSide(width: 0, style: BorderStyle.none,),
                      ),
                    ),
                  ),
                );
              }
          ),

          //GRID
          GetBuilder<SalonController>(

            builder: (controller){

              return Expanded(

                child: !controller.isLoading ?

                Visibility(
                  visible: (controller.allSalons).isNotEmpty,

                  replacement: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search_off, size: 40, color: CustomColors.customSwatchColor,),
                      const Text('Não há itens para apresentar'),
                    ],
                  ),

                  child: GridView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    physics: const BouncingScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 9 / 11.5,
                    ),
                    //CHAMAMOS A LISTA DE ITENS
                    itemCount: controller.allSalons.length,
                    itemBuilder: (_, index){

                      //se o index + 1 for igual a quantidade apresentada em allSalons quer dizer
                      //que ja estamos apresentando o ultimo item na nossa lista
                      //obs. o index vai começar de 0 a 5, dando 6 itens
                      //entao 5(ultimo item) + 1 = 6 que bateria com o total da lista allSalons.length

                      //!controller.isLastPage se nao estivermos na ultima pagina
                      if((index + 1 == controller.allSalons.length) && !controller.isLastPage){

                        //chamamos o metodo para carregar mais saloes
                        controller.loadMoreSalons();

                      }

                      return ItemSalonTile(
                        itemSalonModel: controller.allSalons[index],
                      );


                    },
                  ),

                )


                : GridView.count(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    physics: const BouncingScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 9 / 11.5,
                    children: List.generate(
                      10,
                          (index) => CustomShimmer(
                        height: double.infinity,
                        width: double.infinity,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),



              );

            },),



        ],

      ),

    );
  }
}
