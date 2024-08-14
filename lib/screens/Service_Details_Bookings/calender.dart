import 'package:clientphase/screens/counter_screen/counter_container.dart';
import 'package:clientphase/screens/counter_screen/counter_list.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';


class DateCalender extends StatefulWidget {
  const DateCalender({super.key});

  @override
  State<DateCalender> createState() => _DateCalenderState();
}

class _DateCalenderState extends State<DateCalender> {
  DateTime today = DateTime.now();
  int selectedContainerIndex = 8;

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'تفاصيل الحجز',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ))
        ],
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text('اختر ميعاد الخدمة',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          ),
          Container(
              child: TableCalendar(
                  headerStyle: HeaderStyle(
                      formatButtonVisible: false, titleCentered: true),
                  selectedDayPredicate: (day) => isSameDay(day, today),
                  focusedDay: today,
                  firstDay: DateTime.utc(2024, 1, 1),
                  lastDay: DateTime.utc(2040, 12, 30),
                  onDaySelected: _onDaySelected)),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: CounterContainer('عدد ساعات العمل', 1, 5),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text(
              'اختر وقت بداية الخدمة',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            height: 50,
            width: 300,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                // Define the start time for each container (assuming 1-hour intervals)
                int startHour = 9 + index;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedContainerIndex = index;
                    });
                  },
                  child: Container(
                    width: 130,
                    height: 50,
                    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: selectedContainerIndex == index
                          ? Color.fromARGB(255, 107, 16, 123)
                          : Color(0xFFF2F8FF),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 225, 151, 238),
                          blurRadius: 4,
                          spreadRadius: 2,
                        )
                      ],
                    ),
                    child: Center(
                      child: Row(
                        children: [
                          Text(
                            'صباحا',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "${startHour.toString().padLeft(2, '0')}:00",
                            style: TextStyle(
                              fontSize: 17.0,
                              color: selectedContainerIndex == index
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 40),
              child: ElevatedButton(
                onPressed: () {
                  // Add your book now logic here
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  backgroundColor: Color.fromARGB(255, 107, 16, 123),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'استمر',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
