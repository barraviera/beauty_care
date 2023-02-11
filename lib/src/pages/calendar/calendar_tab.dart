import 'package:beauty_care/src/models/calendar_item_model.dart';
import 'package:beauty_care/src/pages/calendar/components/calendar_tile.dart';
import 'package:flutter/material.dart';
import 'package:beauty_care/src/config/app_data.dart' as appData;

class CalendarTab extends StatefulWidget {
  const CalendarTab({Key? key}) : super(key: key);

  @override
  State<CalendarTab> createState() => _CalendarTabState();
}

class _CalendarTabState extends State<CalendarTab> {
  //FUNCAO PARA REMOVER UM ITEM DA AGENDA
  void removeItemFromCalendar(CalendarItemModel calendarItem){

    setState(() {
      appData.calendarItems.remove(calendarItem);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('Minha Agenda'),
      ),

      body: Column(
        children: [

          Expanded(
              child: ListView.builder(
                itemCount: appData.calendarItems.length,
                itemBuilder: (_, index){
                  return CalendarTile(
                    calendarItem: appData.calendarItems[index],
                    remove: removeItemFromCalendar,
                  );
                },
              ),
          ),

        ],
      ),

    );
  }
}
