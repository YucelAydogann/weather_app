import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/utils/consts.dart';
import 'package:weather_app/services/weather_serv.dart';
import 'city_scr.dart';
import 'package:intl/intl.dart';
import 'package:easy_localization/easy_localization.dart';


class LocationScreen extends StatefulWidget {

  const LocationScreen({Key? key, this.locationWeather}) : super(key: key);
  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

late int temperature;
late String weatherIcon;
late String cityName;
late String weatherMessage;
late String date;
late int humidity;
late double feelslike;
late String formattDate;
late String formattDay;
late String dayDuringMessage;
late double windspeed;

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();

  var now = DateTime.now();
  var formatter =  DateFormat('dd/MM/yyyy');
  var dayformatter = DateFormat('EEEEE');



  @override
  void initState() {
    super.initState();
    formattDate = formatter.format(now);
    formattDay = dayformatter.format(now);


    // print(formattDate); // 2016-01-25
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Hata';
        weatherMessage = 'Hava durumu bilgisine ulaşamıyoruz';
        cityName = '';
        humidity = 0;
        feelslike = 0;
        windspeed = 0;
        dayDuringMessage = 'Bilinmiyor';
        return;
      }
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();

      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      dayDuringMessage = weather.getDuringDay(condition);
      cityName = weatherData['name'];
      humidity = weatherData['main']['humidity'];
      feelslike = weatherData['main']['feels_like'];
      windspeed = weatherData['wind']['speed'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage('assets/images/bg2.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.8), BlendMode.dstATop),
            ),
          ),
          constraints: const BoxConstraints.expand(),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Flexible(
                  flex: 4,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 0,horizontal: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[

                        InkWell(
                          splashColor: Colors.red,
                          customBorder: const CircleBorder(),
                          child: const Padding(
                            padding: EdgeInsets.all(0),
                            child: Icon(Icons.location_on_outlined, color:  Colors.yellow,),
                          ),
                          onTap: ()async {var weatherData = await weather.getLocationWeather();
                          updateUI(weatherData);},
                        ),

                        InkWell(
                          splashColor: Colors.red,
                          customBorder: const CircleBorder(),
                          child: const Padding(
                            padding: EdgeInsets.all(0),
                            child: Icon(Icons.search, color:  Colors.yellow,),
                          ),
                          onTap: ()async {
                            var typedName = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return CityScreen();
                                },
                              ),
                            );
                            if (typedName != null) {
                              var weatherData =
                              await weather.getCityWeather(typedName);
                              updateUI(weatherData);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: weatherW(),
                  ),
                ),
                Flexible(
                  flex: 3,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 50),
                      child: weatherInfo()
                    ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


Column weatherW(){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[

      Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(
          weatherIcon,
          style: kConditionTextStyle,
        ),
      ),

      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$temperature°',
            style: kTempTextStyle,
          ),
          const Text(
            'C',
            style: kMessageeTextStyle,
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Hava Durumu: ',
            style: kMessageTextStyle,
          ),
          Text(
            dayDuringMessage,
            style: kMessageTextStyle,
          ),
        ],
      ),

    ],
  );
}

Column weatherInfo(){
  return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Text(
            cityName,
            style: kCityStyle,
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Column(
            children: [
              Text(
                formattDate,
                textAlign: TextAlign.right,
                style: kDateTextStyle,
              ),
              Text(formattDay,style: kAllWeather)
            ],
          ),
        ),
        Padding(padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Nem: %$humidity', style: kMessageTextStyle),
              Text('Rüzgar: $windspeed''km/s', style: kMessageTextStyle),
            ],
          ),
        ),
      ],
  );
}
