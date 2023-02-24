import 'package:beauty_care/src/models/item_model.dart';
import 'package:beauty_care/src/pages/home/repository/home_repository.dart';
import 'package:beauty_care/src/pages/home/result/home_result.dart';
import 'package:beauty_care/src/services/utils_services.dart';
import 'package:get/get.dart';
import '../../../models/category_model.dart';

const int itemsPerPage = 6;

class HomeController extends GetxController {

  final homeRepository = HomeRepository();
  final utilsServices = UtilsServices();

  bool isCategoryLoading = false;
  bool isProductLoading = true;
  //criamos uma lista de categorias que irá começar como vazia
  List<CategoryModel> allCategories = [];
  CategoryModel? currentCategory;
  List<ItemModel> get allProducts => currentCategory?.items ?? [];

  //variavel observavel para campo de pesquisa
  RxString searchTile = ''.obs;

  //vai especificar se ja estamos na ultima pagina de produtos ou nao
  bool get isLastPage {

    //se o tamanho da nossa lista de itens desta categoria for menor que o nosso itemsPerPage que é 6
    //quer dizer que estamos na ultima pagina e nao tem mais produtos pois sao no maximo 6 por pagina
    if(currentCategory!.items.length < itemsPerPage) return true;

    //se currentCategory!.pagination * itemsPerPage for maior que a lista de produtos quer dizer tbm que estamos na ultima pagina
    return currentCategory!.pagination * itemsPerPage > allProducts.length;

  }

  void setLoading(bool value, {bool isProduct = false}){

    //se nao for o carregamento do produto
    if(!isProduct){
      //vamos atribuir um nova valor a essa variavel
      isCategoryLoading = value;
    }else{
      isProductLoading = value;
    }

    //o get builder é acionado sempre quando chamamos o update
    //com o update iremos refletir essa alteração lá na interface
    update();

  }

  @override
  void onInit(){
    super.onInit();

    //debounce é um metodo do GetX
    //o 1º parametro é o listener que vai ficar escutando a nossa variavel observavel e sempre que tiver alteração nela
    //faremos alguma coisa no segundo parametro que é o callbask
    debounce(
      searchTile,
      (_) {
        filterByTitle();
      },
      //apos 600 milesegundos de pausa sem o usuario fazer nada no campo de pesquisa que iremos tomar alguma atitude
      time: const Duration(milliseconds: 600),
    );

    getAllCategories();
  }

  void selectCategory(CategoryModel category){

    currentCategory = category;
    //update para atualizar o estado da interface
    update();

    //se a lista nao tiver vazia quer dizer que ja tem produtos dentro dela, entao nao queremos buscar novamente
    if(currentCategory!.items.isNotEmpty) return;

    getAllProducts();

  }


  //recuperar todas as categorias
  Future<void> getAllCategories() async{

    setLoading(true);

    //HomeResult é basicamente uma classe freezed
    HomeResult<CategoryModel> homeResult = await homeRepository.getAllCategories();

    setLoading(false);

    homeResult.when(
      success: (data)
      {
        //o data seria a listagem de categorias
        allCategories.assignAll(data);

        //se as categorias estiver vazias, ou seja, ainda nao foi cadastrado nada nao retornaremos nada
        if( allCategories.isEmpty ) return;

        //vamos criar um metodo que seleciona a primeira categoria apos a listagem delas
        selectCategory( allCategories.first );

      },
      error: (message){
        utilsServices.showToast(
          message: "message",
          isError: true,
        );
      },
    );
  }

  //pesquisar por título
  void filterByTitle(){

    //Apagar todos os produtos das categorias
    //vamos recuperar cada uma das categorias usando o laço de repetição for
    for(var category in allCategories){
      //vamos remover os items
      category.items.clear();
      category.pagination = 0;
    }

    //se o searchTile está vazio quer dizer que o usuario clicou no X pra remover a pesquisa
    //entao vamos buscar os produtos com base em nenhum nome
    if(searchTile.value.isEmpty){

      //entao podemos remover a categoria Todos
      allCategories.removeAt(0);

    }else{

      //se a cat.id for vazio quer dizer q a categoria Todos ja existe
      CategoryModel? c = allCategories.firstWhereOrNull(( cat ) => cat.id == '');

      //mas se c for igual a nulo quer dizer que Todos ainda nao existe
      if(c == null){

        //mas caso tenha alguma coisa na variavel searchTile quer dizer que o usuario está pesquisando por algo
        //Criar uma nova categoria com todos
        final allProductsCategory = CategoryModel(
          title: 'Todos',
          id: '',
          items: [],
          pagination: 0,
        );

        //vamos inserir a categoria que criamos acima nas ja existentes
        allCategories.insert(0, allProductsCategory);

      }else{

        //mas se c nao for nulo quer dizer que ja tem a categoria Todos entao vamos remover o restante
        c.items.clear();
        c.pagination = 0;

      }
    }

    //faremos a atribuição da categoria atualmente selecionada ser essa de Todos os produtos
    currentCategory = allCategories.first;

    //para atualizar na interface
    update();

    getAllProducts();
  }

  void loadMoreProducts(){

    //se a paginação for 0 ela passará a ser 1 e assim por diante, buscando os proximos 6 produtos
    currentCategory!.pagination++;
    getAllProducts( canLoad: false );
  }

  //recuperar todos os produtos
  Future<void> getAllProducts({bool canLoad = true}) async{

    if(canLoad == true){
      setLoading(true, isProduct: true);
    }

    Map<String, dynamic> body = {
      //currentCategory é a categoria atualmente selecionada
      //usamos o ! para forçar e indicar que ela nao é nula
      'page': currentCategory!.pagination,
      'categoryId': currentCategory!.id,
      'itemsPerPage': itemsPerPage,
    };

    //se a variavel searchTile nao estiver vazia iremos adicionar uma nova chave no body
    //ou seja, no corpo da requisição
    if(searchTile.value.isNotEmpty){

      body['title'] = searchTile.value;

      //se o id da categoria atual for igual a vazio quer dizer que estamos trabalhando com o metodo allProductsCategory
      if(currentCategory!.id == ''){

        //vamos remover a chave categoryId do corpo da requisição body
        body.remove('categoryId');
      }
    }

    HomeResult<ItemModel> result = await homeRepository.getAllProducts(body);

    setLoading(false, isProduct: true);

    result.when(
      success: (data){

        //recuperar a categoria selecionada
        //addAll para caso a gente ja tenha algo nesta lista de items iremos só adicionar a ela
        currentCategory!.items.addAll(data);

      },
      error: (message){
        utilsServices.showToast(message: message, isError: true);
      },
    );

  }




}