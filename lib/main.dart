import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lime Alarm Clock',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // creating text ediiting controller to take hour
  // and minute as input
  TextEditingController hourController = TextEditingController();
  TextEditingController minuteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lime Alarm Clock'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 40,
                  width: 60,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(11)),
                  child: Center(
                    child: TextField(
                      controller: hourController,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  height: 40,
                  width: 60,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(11)),
                  child: Center(
                    child: TextField(
                      controller: minuteController,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.all(25),
              child: TextButton(
                child: const Text(
                  'Create alarm',
                  style: TextStyle(fontSize: 20.0),
                ),
                onPressed: () {
                  int hour;
                  int minutes;
                  try {
                    hour = int.parse(hourController.text);
                    minutes = int.parse(minuteController.text);

                    // checking if the hours and minutes are in range
                    if (hour < 0 || hour > 23 || minutes < 0 || minutes > 59) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text('Incorrect numbers for hour or minutes'),
                        ),
                      );
                    } else {
                      // creating alarm after converting hour
                      // and minute into integer
                      FlutterAlarmClock.createAlarm(hour, minutes);
                    }
                  } catch (e) {
                    //!bad way to handle exception but it works :)
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Invalid input'),
                      ),
                    );
                  }
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // show alarm
                FlutterAlarmClock.showAlarms();
              },
              child: const Text(
                'Show Alarms',
                style: TextStyle(fontSize: 20.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
