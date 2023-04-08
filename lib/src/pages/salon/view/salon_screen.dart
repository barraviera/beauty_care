import 'package:beauty_care/src/models/item_salon_model.dart';
import 'package:flutter/material.dart';

class SalonScreen extends StatefulWidget {


  SalonScreen({
    Key? key,
    required this.itemSalonModel
  }) : super(key: key);


  final ItemSalonModel itemSalonModel;

  @override
  State<SalonScreen> createState() => _SalonScreenState();
}

class _SalonScreenState extends State<SalonScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
