
import 'package:flutter/material.dart';
import 'package:weather/model/weather_model.dart';
import 'package:weather/service/api_service.dart';
import 'package:weather/ui/components/todays_weather.dart';

import 'components/future_forcast_listitem.dart';
import 'components/hourly_weather_listitem.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiService apiService = ApiService();
  final _textFieldController = TextEditingController();
  String queryText = "auto:ip";
  _showTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Search Location'),
            content: TextField(
              controller: _textFieldController,
              decoration: const InputDecoration(hintText: "search by city,zip"),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              ),
              ElevatedButton(
                  child: const Text('OK'),
                  onPressed: () {
                    if (_textFieldController.text.isEmpty) {
                      return;
                    }
                    Navigator.pop(context, _textFieldController.text);
                  }),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title:
      const Text("Weather App"),
        actions: [
          IconButton(
              onPressed: () async {
                _textFieldController.clear();
                String text = await _showTextInputDialog(context);
                setState(() {
                  queryText = text;
                });
              },
              icon: const Icon(Icons.search)),
          IconButton(
              onPressed: () {
                setState(() {
                  queryText = "auto:ip";
                });
              },
              icon: const Icon(Icons.my_location)),
        ],
      backgroundColor: Colors.cyan,),
      body: SafeArea(
        child: FutureBuilder(
          builder: (context,snapshot) {
        if (snapshot.hasData) {
          WeatherModel? weatherModel = snapshot.data;
          return SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                TodaysWeather
                  (weatherModel: weatherModel,
                ),

                const SizedBox(width: 10),
                const Text("Weather by Hours",
                  style: TextStyle(color: Colors.white,fontSize: 22),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  height: 150,
                  child: ListView.builder(itemBuilder:(context,index){
                    Hour? hour = weatherModel
                        ?.forecast?.forecastday?[0].hour?[index];
                    return HourlyWeatherListItem(
                      hour: hour,
                    );
                  } ,
                      itemCount:
                    weatherModel?.forecast?.forecastday?[0].hour?.length,
                      scrollDirection: Axis.horizontal
                    ,),
                ),
                const SizedBox(width: 10),
                const Text("Next 7 days Weather",
                  style: TextStyle(color: Colors.indigo,fontSize: 22),
                ),
                const SizedBox(width: 10),
                Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return FutureForcastListItem(
                          forecastday:
                          weatherModel?.forecast?.forecastday?[index],
                        );
                      },
                      itemCount: weatherModel?.forecast?.forecastday?.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                    ))
              ],
            ),
          );
        }
        if (snapshot.hasError){
          return const Center(child: Text("Error has occurred"),
          );
        }
        return const Center(child: CircularProgressIndicator()
        );

      },
        future: apiService.getWeatherData(queryText),
      ),
      ),
      );
  }
}
