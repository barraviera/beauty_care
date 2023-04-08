// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_salon_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemSalonModel _$ItemSalonModelFromJson(Map<String, dynamic> json) =>
    ItemSalonModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String,
      address: json['address'] as String,
      district: json['district'] as String,
      number: json['number'] as String,
      city: json['city'] as String,
      phone: json['phone'] as String,
      imgUrl: json['picture'] as String,
      distance: (json['distance'] as num).toDouble(),
    );

Map<String, dynamic> _$ItemSalonModelToJson(ItemSalonModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'address': instance.address,
      'district': instance.district,
      'number': instance.number,
      'city': instance.city,
      'phone': instance.phone,
      'picture': instance.imgUrl,
      'distance': instance.distance,
    };
