import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart'; //formater

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  //const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
// "Confirmed":289233,"Recovered":223437,"Hospitalized":63520,"Deaths":2276,
// "NewConfirmed":6166,"NewRecovered":2534,"NewHospitalized":3582,"NewDeaths":50,"UpdateDate":"05\/07\/2021 22:16"
  var confirmed = TextEditingController(); //ตัวแปลเก็บยอดผู้ติดเชื้อสะสม
  var recovered = TextEditingController();
  var hospitalized = TextEditingController();
  var deaths = TextEditingController();
  var newConfirmed = TextEditingController();
  var newRecovered = TextEditingController();
  var newHospitalized = TextEditingController();
  var newDeaths = TextEditingController();
  var updateDate = TextEditingController();

  @override
  void initState() {
    //TODO: implement initState
    super.initState();
    confirmed.text = '-';
    recovered.text = '-';
    hospitalized.text = '-';
    newConfirmed.text = '-';
    newRecovered.text = '-';
    newHospitalized.text = '-';
    deaths.text = '-';
    updateDate.text = '-';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Covid Stats"),
        actions: [
          IconButton(
              onPressed: () {
                print('Get Data Covid');
                _GetCovidData();
              },
              icon: Icon(Icons.refresh))
        ],
      ),
      body: ListView(
        children: [
          //ช่องว่าง
          SizedBox(
            height: 30,
          ),
          //title1
          Center(
            child: Text(
              'ติดเชื้อสะสม',
              style: TextStyle(fontSize: 30),
            ),
          ),
          //result1
          Center(
            child: Text(
              confirmed.text,
              style: TextStyle(fontSize: 30, color: Colors.orange),
            ),
          ),
          //title2
          Center(
            child: Text(
              'หายแล้ว',
              style: TextStyle(fontSize: 30),
            ),
          ),
          //result2
          Center(
            child: Text(
              recovered.text,
              style: TextStyle(fontSize: 30, color: Colors.green),
            ),
          ),
          //title3
          Center(
            child: Text(
              'รักษาอยู่ใน รพ.',
              style: TextStyle(fontSize: 30),
            ),
          ),
          //result3
          Center(
            child: Text(
              hospitalized.text,
              style: TextStyle(fontSize: 30, color: Colors.blueAccent),
            ),
          ),
          //title4
          Center(
            child: Text(
              'เสียชีวิต',
              style: TextStyle(fontSize: 30),
            ),
          ),
          //result4
          Center(
            child: Text(
              deaths.text,
              style: TextStyle(fontSize: 30, color: Colors.redAccent),
            ),
          ),
          //title5
          Center(
            child: Text(
              'อัพเดทข้อมูลล่าสุด',
              style: TextStyle(fontSize: 30),
            ),
          ),
          //result5
          Center(
            child: Text(
              updateDate.text,
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  /*recovered.text = '-';
    hospitalized.text = '-';
    deaths.text = '-';
    updateDate.text = '-'; */

  //http://covid19.th-stat.com/json/covid19v2/getTodayCases.json
  Future<String?> _GetCovidData() async {
    var url =
        Uri.https('covid19.th-stat.com', '/json/covid19v2/getTodayCases.json');

    var response = await http.get(url);
    print("---DATA---");
    print(response.body);

    var result = json.decode(response.body);

    var v1 = result['Confirmed'];
    var v2 = result['Recovered'];
    var v3 = result['Hospitalized'];
    var v4 = result['Deaths'];
    var v5 = result['UpdateDate'];

    var formatter = NumberFormat('###,###,###');
    //var dateString = DateFormat.yMd('ar');

    setState(() {
      confirmed.text = formatter.format(v1); // int.parse(v1) if v1 is string
      recovered.text = formatter.format(v2);
      hospitalized.text = formatter.format(v3);
      deaths.text = formatter.format(v4);
      updateDate.text = v5;
    });
  }
}
