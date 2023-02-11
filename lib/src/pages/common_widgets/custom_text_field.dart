import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//VAMOS CONVERTER ESTA CLASSE PARA UMA STATEFUL POIS PRECISAMOS QUE ELA MUDE DE ESTADO PARA MOSTRAR O ICONE DO OLHO E OCULTAR
class CustomTextField extends StatefulWidget {

  //VAMOS CRIAR VARIAVEIS PARA ISOLAR OS VALORES DE ICONE, LABEL E OBSCURE
  //O TIPO É ICONDATA E O NOME DA VARIAVEL É ICON
  //O FINAL QUER DIZER QUE ELE NAO PODERÁ MAIS RECEBER VALORES
  final IconData icon;
  //O TIPO É STRING E O NOME DA VARIAVEL É LABEL
  final String label;
  //isSecret VAI INDICAR SE QUEREMOS QUE O INPUT SEJA SECRETO OU NAO, SE FOR TRUE IREMOS MOSTRAR O ICONE DO OLHO
  final bool isSecret;
  //lista de TextInputFormatter
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final TextEditingController? controller; //vai ser nullable
  final TextInputType? textInputType;
  final String? initialValue;
  final bool readOnly;
  final GlobalKey<FormFieldState>? formFieldKey;


  //ESTE É O CONSTRUTOR, NELE IREMOS RECEBER O IconData e o Label COMO PARAMETRO PARA OS INPUTS PODEREM SER PERSONALIZADOS
  //OBS O ICON E LABEL VIRÃO DA SIGN_IN_SCREEN DO CAMPO CustomTextField
  const CustomTextField({
    Key? key,
    required this.icon, //REQUIRED QUER DIZER QUE É OBRIGATORIO
    required this.label,
    this.isSecret = false, //POR DEFAULT DIZEMOS QUE ELE É FALSE E NAO PRECISAMOS COLOCAR EM TODOS OS CAMPOS ESSE ISSECRET, MAS SOMENTO NOS CAMPOS QUE ELE SERÁ TRUE(OCULTAR)
    this.inputFormatters,
    this.validator,
    this.onSaved,
    this.controller,
    this.textInputType,
    this.initialValue,
    this.readOnly = false,
    this.formFieldKey,
  }) : super(key: key);


  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {

  //O TIPO É BOOL E O NOME DA VARIAVEL É ISOBSCURE
  //isObscure SE FOR TRUE OCULTA O TEXTO E FALSE MOSTRA O TEXTO
  bool isObscure = false;

  //O initState É EXECUTADO ANTES DO Widget SER APRESENTADO NA TELA
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //VAMOS DIZER O QUE isObscure IRÁ RECEBER O MESMO VALOR DO isSecret
    //OU SEJA QUANDO UM FOR TRUE O OUTRO TAMBEM SERÁ
    isObscure = widget.isSecret;
  }

  //AGORA VAMOS PEGAR ESSES PARAMETROS E PASSAR ABAIXO DENTRO DO TextFormField PARA PERSONALIZA-LO
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),

      child: TextFormField(
        key: widget.formFieldKey,
        readOnly: widget.readOnly,
        initialValue: widget.initialValue,
        controller: widget.controller,
        inputFormatters: widget.inputFormatters,
        obscureText: isObscure, //RECEBE TRUE OU FALSE
        validator: widget.validator,
        onSaved: widget.onSaved,
        keyboardType: widget.textInputType,
        decoration: InputDecoration(prefixIcon: Icon(widget.icon),


          //SE O ISOBSCURE FOR TRUE(OCULTO), IREMOS MOSTRAR O ÍCONE DO OLHO, MAS SE FOR FALSE(NAO OCULTO) IREMOS RETORNAR APENAS NULL
          //DESTA FORMA SOMENTE O CAMPO DE SENHA QUE TERÁ O ICONE DE OLHO, POIS O ISOBSCURE SERA TRUE
          suffixIcon: widget.isSecret ? IconButton( //COM O IconButton PODEMOS TER O BOTAO E O TOQUE AO MESMO TEMPO
            onPressed: (){
              //SET STATE ALTERAR O ESTADO DA TELA
              setState(() {
                //VEJA QUE O ICONE SÓ APARECERÁ SE QUISERMOS UM CAMPO DE SENHA E SETARMOS O isSecrete como true
                //VEJA TAMBEM QUE O ICONE NUNCA SOME NO CAMPO DE SENHA, AO CLICAR SOBRE ELE SOMENTE MUDAMOS O obscureText: isObscure (para true ou false)
                isObscure = !isObscure;
              });
            },
            icon: Icon( isObscure ? Icons.visibility : Icons.visibility_off),
          ) : null, //ICONE DO LADO DIREITO DO INPUT
          labelText: widget.label,
          isDense: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),

    );
  }
}
