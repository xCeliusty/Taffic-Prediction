import 'package:fastroute/weather/model/current_weather_data.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:fastroute/weather/model/five_days_data.dart';
import 'package:fastroute/weather/service/weather_service.dart';

import '../model/current_weather_data.dart';

class HomeController extends GetxController {
  String? city;
  String? searchText;

  CurrentWeatherData currentWeatherData = CurrentWeatherData();
  //currentWeatherData = data;
  List<CurrentWeatherData> dataList = [];
  List<FiveDayData> fiveDaysData = [];

  HomeController({required this.city});

  @override
  void onInit() {
    initState();
    // getTopFiveCities();
    super.onInit();
  }

  void updateWeather() {
    initState();
  }

  void initState() {
    getCurrentWeatherData();
    getFiveDaysData();
  }

  void getCurrentWeatherData() {
    WeatherService(city: '$city').getCurrentWeatherData(
      onSuccess: (data) {
        currentWeatherData = data;

          update();
      },
      onError: (error) => {
        print(error),
        update(),
      },
    );
  }

  /*void getTopFiveCities() {
   
   cities.forEach((c) {
     WeatherService(city: '$c').getCurrentWeatherData(onSuccess: (data) {
       dataList.add(data);
       update();
     }, onError: (error) {
       print(error);
       update();
      });
    });
  }*/

  void getFiveDaysData() {
    WeatherService(city: '$city').getFiveDaysThreeHoursForcastData(
      onSuccess: (data) {
        fiveDaysData = data;
         update();
      },
      onError: (error) {
        print(error);
        update();
      },
    );
  }
}
