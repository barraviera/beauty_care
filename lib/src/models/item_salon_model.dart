import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_salon_model.g.dart';

@JsonSerializable()
class ItemSalonModel {

  String id;
  String title;
  String address;
  String district;
  String number;
  String city;
  String phone;
  @JsonKey(name: 'picture')
  String imgUrl;
  double distance;
  String description;

  //construtor
  ItemSalonModel({
    this.id = '',
    required this.title,
    required this.address,
    required this.district,
    required this.number,
    required this.city,
    required this.phone,
    required this.imgUrl,
    required this.distance,
    required this.description,
  });


  factory ItemSalonModel.fromJson(Map<String, dynamic> json) => _$ItemSalonModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemSalonModelToJson(this);

  @override
  String toString() {
    return 'ItemSalonModel{id: $id, title: $title, address: $address, district: $district, number: $number, city: $city, phone: $phone, imgUrl: $imgUrl, distance: $distance, description: $description}';
  }

//apos criar criar essas linhas vamos rodar no terminal:
  //flutter pub run build_runner watch



}