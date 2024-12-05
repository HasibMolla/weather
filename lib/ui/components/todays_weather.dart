import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import 'package:intl/intl.dart';
import 'package:weather/model/weather_model.dart';

class TodaysWeather extends StatelessWidget {
  final WeatherModel? weatherModel;

  const TodaysWeather({Key? key, this.weatherModel}) : super(key: key);

  WeatherType getWeatherType(Current? current) {
    if (current?.isDay == 1) {
      if (current?.condition?.text == "Sunny") {
        return WeatherType.sunny;
      } else if (current?.condition?.text == "Overcast") {
        return WeatherType.overcast;
      } else if (current?.condition?.text == "Partly cloudy") {
        return WeatherType.cloudy;
      } else if (current?.condition?.text == "Cloudy") {
        return WeatherType.cloudy;
      } else if (current?.condition?.text == "Clear") {
        return WeatherType.sunny;
      } else if (current?.condition?.text == "Mist") {
        return WeatherType.lightSnow;
      } else if (current!.condition!.text!.contains("thunder")) {
        return WeatherType.thunder;
      } else if (current.condition!.text!.contains("showers")) {
        return WeatherType.middleSnow;
      } else if (current.condition!.text!.contains("rain")) {
        return WeatherType.heavyRainy;
      }
    } else {
      if (current?.condition?.text == "Sunny") {
        return WeatherType.sunny;
      } else if (current?.condition?.text == "Overcast") {
        return WeatherType.overcast;
      } else if (current?.condition?.text == "Partly cloudy") {
        return WeatherType.cloudyNight;
      } else if (current?.condition?.text == "Cloudy") {
        return WeatherType.cloudyNight;
      } else if (current?.condition?.text == "Clear") {
        return WeatherType.sunnyNight;
      } else if (current?.condition?.text == "Mist") {
        return WeatherType.lightSnow;
      } else if (current!.condition!.text!.contains("thunder")) {
        return WeatherType.thunder;
      } else if (current.condition!.text!.contains("showers")) {
        return WeatherType.middleSnow;
      } else if (current.condition!.text!.contains("rain")) {
        return WeatherType.heavyRainy;
      }
    }
    return WeatherType.middleRainy;
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WeatherBg(
          weatherType: WeatherType.cloudyNight,
          width: MediaQuery.of(context).size.width,
          height: 300,
        ),
        SizedBox(
          width: double.infinity,
          height: 300,
          child: SingleChildScrollView( // Added to handle overflow
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Text(
                        weatherModel?.location?.name ?? "",
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white30,
                        ),
                      ),
                      Text(
                        DateFormat.yMMMMEEEEd().format(
                          DateTime.parse(
                            weatherModel?.current?.lastUpdated.toString() ?? "",
                          ),
                        ),
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white30,
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    const SizedBox(width: 10),
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white10,
                      ),
                      child: Image.network(
                        "https:${weatherModel?.current?.condition?.icon ?? ""}",
                      ),
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 2.0),
                              child: Text(
                                weatherModel?.current?.tempC?.round().toString() ?? "",
                                style: const TextStyle(
                                  fontSize: 60,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.brown,
                                ),
                              ),
                            ),
                            const Text(
                              "c",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            )
                          ],
                        ),
                        Text(
                          weatherModel?.current?.condition?.text ?? "",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.blue,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white30,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              const Text(
                                "Feels like",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.pinkAccent,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              Text(
                                weatherModel?.current?.feelslikeC?.round().toString() ?? "",
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.pinkAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const Text(
                                "Wind",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.pinkAccent,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              Text(
                                "${weatherModel?.current?.windKph?.round()} Km/h",
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.pinkAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(width: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              const Text(
                                "Humidity",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.pinkAccent,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              Text(
                                "${weatherModel?.current?.humidity}%",
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.pinkAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const Text(
                                "Visibility",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.pinkAccent,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              Text(
                                "${weatherModel?.current?.visKm?.round()} Km",
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.pinkAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
