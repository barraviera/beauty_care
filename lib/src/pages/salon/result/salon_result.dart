import 'package:freezed_annotation/freezed_annotation.dart';

part 'salon_result.freezed.dart';

@freezed
class SalonResult<T> with _$SalonResult<T>{

  factory SalonResult.success(List<T> data) = Success;
  factory SalonResult.error(String message) = Error;


}