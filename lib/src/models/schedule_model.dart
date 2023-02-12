import 'package:freezed_annotation/freezed_annotation.dart';

part 'schedule_model.g.dart';

@JsonSerializable()
class ScheduleModel {

  //ATRIBUTOS
  String id;
  String date;



  //CONSTRUTOR
  ScheduleModel({
    this.id = '',
    required this.date,

  });


  factory ScheduleModel.fromJson(Map<String, dynamic> json) => _$ScheduleModelFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleModelToJson(this);

  @override
  String toString() {
    return 'ScheduleModel{id: $id, date: $date}';
  }

  //apos criar criar essas linhas vamos rodar no terminal:
  //flutter pub run build_runner watch







}