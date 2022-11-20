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
  late String des="";
  var humidity;
  var max_temp;
  var min_temp;
  var sunrise;
  //var currentCity2="Enter Correct City";
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
      humidity=json["main"]["humidity"];
      description=json["weather"][0]["main"];
       des=description.toString();
       sunrise=json["sys"]["sunrise"];
       print(DateTime.parse(sunrise.toString()));
       print(des);
      print(currentCity);
      print(temperature);
      print(description);
    });
  }
   show(){

    if(des=='Clear') return Colors.blue;
     if(des=='Haze') {
       print("ki koro bhai??");
       return Colors.blueGrey;
     }
    else return Colors.white;
  }

  // show2(){
  //   if(des==null) return Image(image: AssetImage('Haze.jpeg'));
  //   else if(des=='Haze') return Image(image: AssetImage('Haze.jpeg'));
  //   else return Image(image: AssetImage('Haze.jpeg'));
  // }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
        home: Scaffold(
            backgroundColor: show(),
            //backgroundColor: Colors.orange,


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


                Text("Temparature in "+(currentCity == null?"CityName":currentCity).toString(),
                style: TextStyle(
                  fontSize: 30
                ),),
                Text((temperature==null?" ":(temperature-273.16).toStringAsFixed(2).toString()+"\u00B0 C /"+(((temperature*9)-2297)/5).toStringAsFixed(2).toString()+"\u00B0 F")),
                Text((des==null? "Loading...":des)),
                Text((humidity==null)?" ":"Humidity          "+(humidity).toString()),
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
                ),

                // Container(
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     crossAxisAlignment: CrossAxisAlignment.end,
                //     children: const <Widget>[
                //       SizedBox(
                //         width: 500,
                //         height: 100,
                //         child: Image(image: AssetImage('Sunrise.jpeg')),
                //       ),
                //       SizedBox(
                //         width: 500,
                //         height: 100,
                //         child: Image(image: AssetImage('Sunset.jpeg')),
                //       ),
                //
                //     ],   ),
                //
                //
                // ),
                // Container(
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     crossAxisAlignment: CrossAxisAlignment.end,
                //     children: const <Widget>[
                //       SizedBox(
                //         width: 500,
                //         height: 100,
                //         child: Image(image: AssetImage('Sunrise.jpeg')),
                //       ),
                //
                //
                //
                //     ],   ),
                //
                //
                // ),
              ],
            ),


          ) ,
        ),
    );
  }
}



