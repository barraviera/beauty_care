
import 'package:beauty_care/src/models/item_model.dart';

import '../models/calendar_item_model.dart';

ItemModel unha = ItemModel(
    title: 'Pacote de Unhas',
    imgUrl: 'assets/products/apple.png',
    price: 120,
    description: 'Neste pacote você terá um serviço de unha por semana durante o mês.',
    address: 'Rua Silva Jardim, 9-85 - Jardim Bela Vista - Bauru/SP',
    contact: '(14) 98855-7744 / (14) 98144-7733',
    salonName: 'São Lunar',
    distance: 1.5,

    //status: false,
);

ItemModel cabelo = ItemModel(
    title: 'Cabelos',
    imgUrl: 'assets/products/grape.png',
    price: 120,
    description: 'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
    address: 'Rua Silva Jardim, 9-85 - Jardim Bela Vista - Bauru/SP',
    contact: '(14) 98855-7744 / (14) 98144-7733',
    salonName: 'São Maria',
    distance: 5.5,

    //status: true,
);

ItemModel maquiagem = ItemModel(
    title: 'Pacote de Maquiagem',
    imgUrl: 'assets/products/guava.png',
    price: 120,
    description: 'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
    address: 'Rua Silva Jardim, 9-85 - Jardim Bela Vista - Bauru/SP',
    contact: '(14) 98855-7744 / (14) 98144-7733',
    salonName: 'São Luis',
    distance: 10,

    //status: true,
);

ItemModel depilacao = ItemModel(
    title: 'Pacote de Depilação',
    imgUrl: 'assets/products/kiwi.png',
    price: 120,
    description: 'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
    address: 'Rua Silva Jardim, 9-85 - Jardim Bela Vista - Bauru/SP',
    contact: '(14) 98855-7744 / (14) 98144-7733',
    salonName: 'São Lua',
    distance: 31.5,

    //status: false,
);

ItemModel sombrancelha = ItemModel(
    title: 'Pacote de Sombrancelha',
    imgUrl: 'assets/products/mango.png',
    price: 120,
    description: 'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
    address: 'Rua Silva Jardim, 9-85 - Jardim Bela Vista - Bauru/SP',
    contact: '(14) 98855-7744 / (14) 98144-7733',
    salonName: 'São Marte',
    distance: 21.5,

    //status: true,
);



List<ItemModel> items = [

    unha, cabelo, maquiagem, depilacao, sombrancelha,

];

//LISTA DE NOMES QUE FICARAM RANDOMICOS NA TELA INICIAL
List<String> categories = [
    'Unha',
    'Cabelo',
    'Maquiagem',
    'Depilação',
    'Barba',
    'Sobrancelha'
];

//LISTA DE ITENS DA MINHA AGENDA
List<CalendarItemModel> calendarItems = [

    CalendarItemModel(item: unha),
    CalendarItemModel(item: cabelo),
    CalendarItemModel(item: maquiagem),
    CalendarItemModel(item: depilacao),

];