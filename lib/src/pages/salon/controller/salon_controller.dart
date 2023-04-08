import 'package:beauty_care/src/models/item_salon_model.dart';
import 'package:beauty_care/src/pages/salon/repository/salon_repository.dart';
import 'package:beauty_care/src/pages/salon/result/salon_result.dart';
import 'package:get/get.dart';
import '../../../services/utils_services.dart';

const int itemsPerPage = 6;

class SalonController extends GetxController {

  final salonRepository = SalonRepository();
  final utilsServices = UtilsServices();

  //variavel observavel para campo de pesquisa
  RxString searchTile = ''.obs;
  bool isLoading = false;
  List<ItemSalonModel> allSalons = [];
  int pagination = 0;

  //vai nos retornar se ja estamos na ultima pagina da lista de salões
  bool get isLastPage {

    //se a quantidade de itens que está na lista allSalons for menor que 6
    //quer dizer que ja estamos na ultima pagina
    if(allSalons.length < itemsPerPage) return true;

    return pagination * itemsPerPage > allSalons.length;

  }

  //onInit é iniciado sempre quando instaciamos a nossa classe controladora salon_controller.dart
  @override
  void onInit(){
    super.onInit();

    //o debounce vai ficar monitorando a variavel observavel searchTile
    //e fazer uma ação a respeito
    debounce(searchTile, (_) => filterByTitle(),

      //apos recebermos um valor no searchTile podemos indicar um tempo para a ação começar
      time: const Duration(milliseconds: 600),
    );

    getAllSalons();

  }

  void setLoading(bool value){

    isLoading = value;

    //o get builder é acionado sempre quando chamamos o update
    //com o update iremos refletir essa alteração lá na interface
    update();
  }

  //metodo para carregar mais saloes
  void loadMoreSalons(){

    pagination++;
    getAllSalons(canLoad: false);
  }

  //filtrar por titulo do salao
  void filterByTitle(){

    allSalons.clear();
    pagination = 0;

    update();
    getAllSalons();
  }


  //recuperar todos os produtos
  Future<void> getAllSalons({bool canLoad = true}) async{

    if(canLoad){

      //setLoading chama o update para refletir as alterações na tela
      setLoading(true);

    }

    Map<String, dynamic> body = {
      'page': pagination,
      'itemsPerPage': itemsPerPage,
    };

    //se a variavel searchTile nao estiver vazia iremos adicionar a chave title no body
    if(searchTile.value.isNotEmpty){

      body['title'] = searchTile.value;

    }

    SalonResult<ItemSalonModel> result = await salonRepository.getAllSalons(body);

    setLoading(false);

    result.when(
      success: (data){

        allSalons.addAll(data);

      },
      error: (message){
        utilsServices.showToast(message: message, isError: true);
      },
    );

  }


}