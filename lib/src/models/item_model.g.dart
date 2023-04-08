// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemModel _$ItemModelFromJson(Map<String, dynamic> json) => ItemModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String,
      imgUrl: json['picture'] as String,
      price: (json['price'] as num).toDouble(),
      description: json['description'] as String,
      address: json['address'] as String,
      contact: json['contact'] as String,
      salonName: json['salon_name'] as String,
      distance: (json['distance'] as num).toDouble(),
      status: json['status'] as bool?,
    );

Map<String, dynamic> _$ItemModelToJson(ItemModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'picture': instance.imgUrl,
      'price': instance.price,
      'description': instance.description,
      'address': instance.address,
      'contact': instance.contact,
      'salon_name': instance.salonName,
      'distance': instance.distance,
      'status': instance.status,
    };
