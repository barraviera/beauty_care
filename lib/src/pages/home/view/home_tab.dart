import 'package:beauty_care/src/config/custom_colors.dart';
import 'package:beauty_care/src/pages/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common_widgets/custom_shimmer.dart';
import 'components/category_tile.dart';
import 'components/item_tile.dart';

class HomeTab extends StatefulWidget {


  const HomeTab({
    Key? key,

  }) : super(key: key);



  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {


  @override
  Widget build(BuildContext context) {

    //Para pegarmos o tamanho da tela
    final size = MediaQuery.of(context).size;

    //criamos um controlador para o campo de pesquisa
    final searchController = TextEditingController();


    return Scaffold(

      //APPBAR
      appBar: AppBar(
        //DEIXAR A APPBAR TRANSPARENTE
        backgroundColor: Colors.transparent,
        //PARA REMOVER A SOMBRA
        elevation: 0,
        centerTitle: true,
        title: Text.rich(
            TextSpan(
              style: const TextStyle(fontSize: 30,),
              children: [
                TextSpan(text: 'Beauty', style: TextStyle(color: CustomColors.customSwatchColor.shade600)),
                TextSpan(text: 'Care', style: TextStyle(color: CustomColors.customContrastColor)),
              ],
            ),
        ),
      ),


      //CAMPO PESQUISA
      body: Column(
        children: [

          GetBuilder<HomeController>(

            builder: (controller) {

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),

                child: TextFormField(
                  controller: searchController,

                  //no onChange conseguimos pegar o texto digitado no campo de pesquisa
                  onChanged: (value){

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
                        ? IconButton(
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

          //CATEGORIAS
          GetBuilder<HomeController>(builder: (controller){

            return           Container(
            padding: const EdgeInsets.only(left: 25),
            height: 40,
            child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index){

            return CategoryTile(
            onPressed: (){
              controller.selectCategory( controller.allCategories[index] );
            },
            category: controller.allCategories[index].title,
              isSelected: controller.allCategories[index] == controller.currentCategory,
            );

            },
            separatorBuilder: (_, index){
            return const SizedBox(width: 10,);
            },
            //PARA PEGAR O TAMANHO DA LISTA
            itemCount: controller.allCategories.length,
            ),
            );

          }),

          //GRID
          GetBuilder<HomeController>(

            builder: (controller){

              return Expanded(
                child: !controller.isProductLoading ?
                
                Visibility(

                  //se o currentCategory for nulo vamos dizer que temos uma lista vazia
                  //mas se essa lista nao for vazia iremos apresentar o gridview com os itens
                  visible: ( controller.currentCategory?.items ?? [] ).isNotEmpty,

                  replacement: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search_off, size: 40, color: CustomColors.customSwatchColor,),
                      const Text('Não há itens para apresentar'),
                    ],
                  ),
                  
                  child: GridView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    physics: BouncingScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 9 / 11.5,
                    ),
                    //CHAMAMOS A LISTA DE ITENS QUE CRIAMOS EM APP_DATA
                    itemCount: controller.allProducts.length,
                    itemBuilder: (_, index){

                      //pra sabermos se ja estamos mostrando o ultimo item
                      //o index começa de 0 a 5, como definimos a quantidade de itens como 6 entao 5+1=6 que bateria com o tamanho total de controller.allProducts.length
                      if( index + 1 == controller.allProducts.length ){

                        //se nós nao estamos na ultima pagina
                        if( !controller.isLastPage ){
                          //chamaremos um metodo para carregar mais produtos
                          controller.loadMoreProducts();
                        }

                      }

                      return ItemTile(
                        item: controller.allProducts[index],
                      ); Container();

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
