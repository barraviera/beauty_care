import 'package:beauty_care/src/pages/auth/controller/auth_controller.dart';
import 'package:beauty_care/src/services/validators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../config/custom_colors.dart';
import '../../common_widgets/custom_text_field.dart';

class SignUpScreen extends StatelessWidget {

  SignUpScreen({Key? key}) : super(key: key);

  final cpfFormatter = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {'#': RegExp( r'[0-9]' )},
  );

  final phoneFormatter = MaskTextInputFormatter(
    mask: '## # ####-####',
    filter: {'#': RegExp( r'[0-9]' )},
  );

  //precisamos de uma key para controlar o Form onde tem os campos
  final _formKey = GlobalKey<FormState>();
  final authController = Get.find<AuthController>();

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

              child: Stack(

                children: [
                  Column(

                    children: [

                      const Expanded(
                          child: Center(
                              child: Text('Cadastro', style: TextStyle(color: Colors.white, fontSize: 35),),
                          ),
                      ),

                      // FORMULARIO
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 40,
                        ),

                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(45)
                          ),
                        ),

                        //CAMPOS DE TEXTO DO FORMULARIO
                        child: Form(
                          key: _formKey,

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,

                            children: [

                              CustomTextField(
                                icon: Icons.email,
                                label: 'E-mail',
                                onSaved: (value){

                                  authController.user.email = value;

                                },
                                textInputType: TextInputType.emailAddress,
                                validator: emailValidator,
                              ),

                              CustomTextField(
                                icon: Icons.lock,
                                label: 'Senha',
                                onSaved: (value){

                                  authController.user.password = value;

                                },
                                isSecret: true,
                                validator: passwordValidator,
                              ),

                              CustomTextField(
                                icon: Icons.person,
                                label: 'Nome',
                                validator: nameValidator,
                                onSaved: (value){

                                  authController.user.name = value;

                                },
                              ),

                              CustomTextField(
                                icon: Icons.phone,
                                label: 'Celular',
                                inputFormatters: [phoneFormatter],
                                textInputType: TextInputType.phone,
                                validator: phoneValidator,
                                onSaved: (value){

                                  authController.user.phone = value;

                                },
                              ),
                              CustomTextField(
                                icon: Icons.file_copy,
                                label: 'CPF',
                                inputFormatters: [cpfFormatter],
                                textInputType: TextInputType.number,
                                validator: cpfValidator,
                                onSaved: (value){

                                  authController.user.cpf = value;

                                },
                              ),

                              SizedBox(
                                height: 50,
                                child: Obx((){

                                  return ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                    ),
                                    //se estiver carregando passamos nulo e desabilitamos o botao
                                    onPressed: authController.isLoading.value ? null
                                        : (){

                                      //ocultar teclado
                                      FocusScope.of(context).unfocus();

                                      //se a validação ocorreu com sucesso
                                      if( _formKey.currentState!.validate() ){

                                        //esse metodo save vai acionar o onSaved de campo um dos campos
                                        _formKey.currentState!.save();
                                        //agora iremos chamar o metodo signUp que faz o cadastro
                                        authController.signUp();
                                      }

                                    },
                                    child: authController.isLoading.value
                                        ? CircularProgressIndicator()
                                        : const Text(
                                      'Cadastrar usuário',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),

                                  );

                                }),

                              ),


                            ],
                          ),
                        ),

                      ),


                    ],

                  ),
                  
                  Positioned(
                    left: 10,
                    top: 10,

                    // BOTAO DE VOLTAR
                    child: SafeArea(
                      child: IconButton(
                          onPressed: (){
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.arrow_back_ios, color: Colors.white,),
                      ),
                    ),
                  )
                  
                ],
              ),
            ),
          ),
        ),

    );
  }
}
