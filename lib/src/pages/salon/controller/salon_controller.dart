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
  bool isSalonLoading = true;
  List<ItemSalonModel> allSalons = [];
  int pagination = 0;

  //vai nos retornar se ja estamos na ultima pagina da lista de salões
  bool get isLastPage {

    //se a quantidade de itens que está na lista allSalons for menor que 6
    //quer dizer que ja estamos na ultima pagina
    if(allSalons.length < itemsPerPage) return true;

    return pagination * itemsPerPage > allSalons.length;

  }

  @override
  void onInit(){
    super.onInit();

    getAllSalons();

  }

  void setLoading(bool value){

    isLoading = value;

    //o get builder é acionado sempre quando chamamos o update
    //com o update iremos refletir essa alteração lá na interface
    update();
  }

  void loadMoreSalons(){

    pagination++;

    getAllSalons(canLoad: false);

  }


  //recuperar todos os produtos
  Future<void> getAllSalons({String? title, bool canLoad = true}) async{

    if(canLoad){

      //setLoading chama o update para refletir as alterações na tela
      setLoading(true);

    }

    Map<String, dynamic> body = {
      'page': pagination,
      'itemsPerPage': itemsPerPage,
      'title': title,
    };

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