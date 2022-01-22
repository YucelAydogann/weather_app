import 'package:flutter/material.dart';
import 'package:weather_app/utils/consts.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  late String cityName;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.8), BlendMode.dstATop),
            ),
          ),
          constraints: const BoxConstraints.expand(),
          child: SafeArea(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Flexible(
                  flex: 1,

                  child: InkWell(
                    splashColor: Colors.red,
                    customBorder: const CircleBorder(),
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(0, 50, 230, 20),
                      child: Icon(Icons.keyboard_backspace_sharp, color:  Colors.yellow,size: 40,),
                    ),
                    onTap: ()async {Navigator.pop(context);},
                  ),

                ),
                Container(
                  margin: const EdgeInsets.all(60),
                  //alignment: Alignment.tpLeft,
                  height: 50,
                  alignment: Alignment.center,
                  child: TextField(
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    decoration: kTextFieldInputDecoration,
                    onChanged: (value) {
                      cityName = value;
                    },
                  ),
                ),
                Column(
                  children: [
                    InkWell(
                      splashColor: Colors.red,
                      customBorder: const CircleBorder(),
                      child: const Padding(
                        padding: EdgeInsets.all(0),
                        child: Icon(Icons.location_on, color:  Colors.yellow,),
                      ),
                      onTap: ()async {Navigator.pop(context, cityName);},
                    ),
                    InkWell(
                      splashColor: Colors.red,
                      customBorder: const CircleBorder(),
                      child: const Padding(
                        padding: EdgeInsets.all(0),
                        child: Text(
                          'Konumu Bul',
                          style: kButtonTextStyle,
                        ),
                      ),
                      onTap: ()async { Navigator.pop(context, cityName);},
                    ),
                  ],
                ),
              ],
            ),

          ),
        ),
      ),
    );
  }
}
