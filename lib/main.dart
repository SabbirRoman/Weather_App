import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';


void main() {
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController cityNameController= new TextEditingController();

  var currentCity;
  var temperature;
  var description;
  void getWeather() async
  {
    //print("object");
    String cityName=cityNameController.text;
    final queryparameter={
      "q":cityName,
      "appid":"94027a37366b49280859ae207ac7103f"
    };
    Uri uri=new Uri.https("api.openweathermap.org","/data/2.5/weather",queryparameter);
    final jsonData=await get(uri);
    final json=jsonDecode(jsonData.body);
    print(json);
    setState(() {
      currentCity= json["name"];
      temperature= json["main"]["temp"];
      description=json["weather"][0]["main"];
      print(temperature);
      print(description);
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
        home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            title: Text("Weather App",
            style: TextStyle(
              fontSize: 20
            ),),
          ),
          body: Center(

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Temparature in"+(currentCity == null?"Loading":currentCity).toString()),
                Text((temperature==null?"Loading":(temperature-273.16).toStringAsFixed(2).toString()+"\u00B0 C")),
                Text((description==null? "Loading":description).toString()),
                SizedBox(

                  width: 200,
                  child: TextField(
                    controller: cityNameController,

                    textAlign: TextAlign.center,
                  ),
                ),
             SizedBox(
               height: 5,
             ),
                ElevatedButton(
                    onPressed: getWeather,
                    child: Text("Search"),
                )
              ],
            ),
          ) ,
        ),
    );
  }
}



