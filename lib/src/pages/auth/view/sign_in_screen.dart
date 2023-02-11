import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:beauty_care/src/pages/auth/controller/auth_controller.dart';
import 'package:beauty_care/src/pages/auth/view/components/forgot_password_dialog.dart';
import 'package:beauty_care/src/pages_routes/app_pages.dart';
import 'package:beauty_care/src/services/utils_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../config/custom_colors.dart';
import '../../../services/validators.dart';
import '../../common_widgets/custom_text_field.dart';



class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  //Controlador de campos
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {

    //Para pegarmos o tamanho da tela
    final size = MediaQuery.of(context).size;

    return Scaffold(

      body: Container(
        decoration: CustomColors.customGradientColor,
        
        child: SingleChildScrollView(

          child: SizedBox(
            width: size.width,
            height: size.height,

            child: Column(

              children: [
                Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        //---NOME DO APLICATIVO
                        Text.rich(
                          TextSpan(
                            style: const TextStyle(
                                fontSize: 40,
                            ),
                            children: [

                              const TextSpan(
                                text: 'Beauty',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              TextSpan(
                                text: 'Care',
                                style: TextStyle(
                                  color: CustomColors.customContrastColor,
                                ),
                              ),

                            ],
                          ),
                        ),

                        //---ANIMAÇÃO DAS CATEGORIAS
                        //VAMOS ENVOLVER O DefaultTextStyle DENTRO DE UM SizedBox PARA QUE TENHA UMA ALTURA DEFINIDA E NAO FIQUE SUBINDO E DESCENDO
                        SizedBox(
                          height: 30,
                          child: DefaultTextStyle(
                            style: const TextStyle(
                              fontSize: 25,
                            ),
                            child: AnimatedTextKit(
                              pause: Duration.zero,
                              repeatForever: true,
                                animatedTexts: [
                                  FadeAnimatedText('Unha'),
                                  FadeAnimatedText('Cabelo'),
                                  FadeAnimatedText('Maquiagem'),
                                  FadeAnimatedText('Depilação'),
                                ],
                            ),
                          ),
                        ),
                      ],
                    ),
                ),

                //---FORMULARIO
                Container(
                  //ESPAÇAMENTO DENTRO DO CONTAINER
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 40,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(45),
                    ),
                  ),
                  child: Form(
                    key: _formKey,

                    child: Column(

                      //NA COLUNA TEMOS O EIXO CRUZADO QUE É NA HORIZONTAL
                      //USAMOS O stretch PARA ESTICAR AO MAXIMO SEUS FILHOS MAS NO EIXO CRUZADO(HORIZONTAL)
                      crossAxisAlignment: CrossAxisAlignment.stretch,

                      children: [
                        //---CAMPO DE EMAIL
                        //EXTRAÍMOS PARA O CUSTOM_TEXT_FIELD E AGORA AQUI CHAMAMOS ELE
                        CustomTextField(
                          controller: emailController,
                          icon: Icons.email,
                          label: 'E-mail',
                          validator: emailValidator,
                        ),

                        //---CAMPO DE SENHA
                        CustomTextField(
                          controller: passwordController,
                          icon: Icons.lock,
                          label: 'Senha',
                          isSecret: true,
                          validator: passwordValidator,
                        ),

                        //---BOTAO DE ENTRAR
                        //ENVOLVEMOS O ElevatedButton EM UM SizedBox PARA PODERMOS DAR UMA ALTURA PRO BOTAO
                        SizedBox(
                          height: 50,
                          child: GetX<AuthController>(

                            builder: (authController){

                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                ),
                                onPressed: authController.isLoading.value
                                //se tiver carregando iremos passar nulo para o onpressed para desabilitar o botao de entrar
                                  ? null
                                  :

                                  (){

                                  //fechar o teclado
                                  FocusScope.of(context).unfocus();

                                  if(_formKey.currentState!.validate()){

                                    String email = emailController.text;
                                    String password = passwordController.text;

                                    authController.signIn(email: email, password: password);

                                  }

                                },
                                child: authController.isLoading.value
                                  ? CircularProgressIndicator()
                                  : const Text(
                                    'Entrar',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                    ),
                                ),
                              );
                            }

                          ),
                        ),

                        //---ESQUECEU A SENHA
                        //PARA DEIXAR O ESQUECEU A SENHA A DIREITA O ENVOLVEMOS EM UM ALIGN
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () async{

                                //chamamos o dialog forgot_password_dialog
                                final bool? result = await showDialog(
                                    context: context,
                                    builder: (_){
                                      return ForgotPasswordDialog(
                                          email: emailController.text,
                                      );
                                    },
                                );

                                if(result ?? false){

                                  utilsServices.showToast(message: 'Um link de recuperação foi enviado para o seu e-mail');

                                }

                              },

                              child: Text(
                                'Esqueceu a senha?',
                                style: TextStyle(color: CustomColors.customContrastColor),
                              ),
                          ),
                        ),

                        //---DIVISOR
                        //PARA COLOCAR UM DIVIDER AO LADO DE OUTRO TEMOS QUE USA UMA ROW
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [

                              Expanded(
                                child: Divider(
                                  color: Colors.grey.withAlpha(90),
                                  thickness: 2,
                                ),
                              ),

                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Text('Ou'),
                              ),

                              Expanded(
                                child: Divider(
                                  color: Colors.grey.withAlpha(90),
                                  thickness: 2,
                                ),
                              ),

                            ],
                          ),
                        ),

                        //---BOTAO DE CRIAR NOVA CONTA
                        SizedBox(
                          height: 50,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              side: BorderSide(
                                width: 2,
                                color: CustomColors.customSwatchColor,
                              ),
                            ),
                            onPressed: (){

                              /*
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (c){
                                    return SignUpScreen();
                                  },
                                ),
                              ); */

                              //Esta linha faz a mesma coisa que o trecho acima faz, porem usando o GetX
                              Get.toNamed(PagesRoutes.signUpRoute);

                            },

                            child: const Text('Criar conta', style: TextStyle(fontSize: 18),),
                          ),
                        ),





                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
