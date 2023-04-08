import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_model.g.dart';

@JsonSerializable()
class ItemModel {

  //ATRIBUTOS
  String id;
  String title;
  @JsonKey(name: 'picture')
  String imgUrl;
  double price;
  String description;
  String address;
  String contact;
  @JsonKey(name: 'salon_name')
  String salonName;
  double distance;
  bool? status;

  //CONSTRUTOR
  ItemModel({
    this.id = '',
    required this.title,
    required this.imgUrl,
    required this.price,
    required this.description,
    required this.address,
    required this.contact,
    required this.salonName,
    required this.distance,
    this.status,
  });


  factory ItemModel.fromJson(Map<String, dynamic> json) => _$ItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemModelToJson(this);

  //apos criar criar essas linhas vamos rodar no terminal:
  //flutter pub run build_runner watch

  @override
  String toString() {
    return 'ItemModel{id: $id, itemName: $title, imgUrl: $imgUrl, price: $price, description: $description, address: $address, distance: $distance, status: $status}';
  }





}