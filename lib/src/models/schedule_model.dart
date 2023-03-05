import 'package:freezed_annotation/freezed_annotation.dart';

part 'schedule_model.g.dart';


//Vamos utilizar este model para quando finalizar o pedido
@JsonSerializable()
class ScheduleModel{

  //Atributos
  String id;
  DateTime date;



  //Construtor
  ScheduleModel({
    required this.id,
    required this.date,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) => _$ScheduleModelFromJson(json);
  Map<String, dynamic> toJson() => _$ScheduleModelToJson(this);

  @override
  String toString() {
    return 'ScheduleModel{id: $id, date: $date}';
  }
}