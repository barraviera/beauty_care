const String baseUrl = 'https://parseapi.back4app.com/functions';

abstract class Endpoints{

  static const String signin = '$baseUrl/login'; //fazer login
  static const String signup = '$baseUrl/signup'; //cadastrar
  static const String validateToken = '$baseUrl/validate-token'; //validar token
  static const String resetPassword = '$baseUrl/reset-password'; //resetar senha
  static const String getAllCategories = '$baseUrl/get-category-list'; //recuperar todas as categorias
  static const String getAllProducts = '$baseUrl/get-product-list'; //recuperar todos os produtos
  static const String getAllSchedules = '$baseUrl/get-schedule-list'; //recuperar os horarios
  static const String getCartItems = '$baseUrl/get-cart-items'; //recuperar produtos da carrinho
  static const String addItemToCart = '$baseUrl/add-item-to-cart'; //adicionar item ao carrinho
  static const String checkout = '$baseUrl/checkout'; //finalizar compra

}