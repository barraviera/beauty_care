import 'package:beauty_care/src/config/custom_colors.dart';
import 'package:beauty_care/src/pages/auth/controller/auth_controller.dart';
import 'package:beauty_care/src/pages/common_widgets/custom_text_field.dart';
import 'package:beauty_care/src/services/validators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {

  //importamos a classe AuthController para usar seus metodos como ex. signOut
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      appBar: AppBar(
        backgroundColor: CustomColors.customContrastColorBottomBar,
        title: const Text('Perfil do usuário', style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(
            onPressed: (){

              //deslogar usuario e sair do app
              authController.signOut();

            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),

      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        children: [

          CustomTextField(
            readOnly: true,
            initialValue: authController.user.email,
            icon: Icons.email,
            label: 'E-mail',
          ),

          CustomTextField(
            readOnly: true,
            initialValue: authController.user.name,
            icon: Icons.person,
            label: 'Nome',
          ),

          CustomTextField(
            readOnly: true,
            initialValue: authController.user.phone,
            icon: Icons.phone,
            label: 'Celular',
          ),

          CustomTextField(
            readOnly: true,
            initialValue: authController.user.cpf,
            icon: Icons.copy,
            label: 'CPF',
            isSecret: true,
          ),

          //Botao para atualizar senha
          SizedBox(
            height: 50,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: CustomColors.customContrastColorBottomBar,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                )
              ),

              onPressed: (){
                updatePassword();
              },
              child: const Text('Atualizar senha'),
            ),
          ),


        ],
      ),

    );
  }

  //Popup para alteração de senha
  Future<bool?> updatePassword(){

    final newPasswordController = TextEditingController();
    final currentPasswordController = TextEditingController();

    //criamos uma chave global para o widget Form para validarmos
    final _formKey = GlobalKey<FormState>();

    return showDialog(
        context: context,
        builder: (context){
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),

            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,

                    child: Column(
                      //para estivar horizontalmente os filhos desta coluna
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      //crescer o minimo possivel no eixo vertical
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Text(
                            'Atualização de senha',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        CustomTextField(
                          controller: currentPasswordController,
                          icon: Icons.lock,
                          label: 'Senha atual',
                          validator: passwordValidator,
                          isSecret: true,
                        ),

                        CustomTextField(
                          //tivemos que criar um controller para a nova senha para podermos conseguir referencia-la
                          //em baixo na verificação se coincidem
                          controller: newPasswordController,
                          icon: Icons.lock_outline,
                          label: 'Nova senha',
                          validator: passwordValidator,
                          isSecret: true,
                        ),

                        CustomTextField(
                          icon: Icons.lock_outline,
                          label: 'Confirmar nova senha',
                          //vamos verificar se a senha nao é nula e se as duas senhas coincidem
                          validator: (password){
                            final result = passwordValidator(password);
                            if(result != null){
                              return result;
                            }
                            if(password != newPasswordController.text){
                              return 'As senhas não são equivalentes';
                            }else{
                              return null;
                            }
                          },
                          isSecret: true,
                        ),

                        //Botao
                        SizedBox(
                          height: 45,
                          child: Obx(() => ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),

                              //se estiver carregando passamos nulo, senao passamos o metodo que faz a validação
                              onPressed: authController.isLoading.value ? null : (){

                              if(_formKey.currentState!.validate()){
                                authController.changePassword(currentPassword: currentPasswordController.text, newPassword: newPasswordController.text);
                              }

                              },
                              child: authController.isLoading.value
                                  ? CircularProgressIndicator()
                                  : Text('Atualizar'),
                          ),
                          ),
                        )

                      ],
                    ),
                  ),
                ),

                Positioned(
                  top: 5,
                  right: 5,
                  child: IconButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close),
                  ),
                ),

              ],
            ),
          );
        },
    );
  }
}
