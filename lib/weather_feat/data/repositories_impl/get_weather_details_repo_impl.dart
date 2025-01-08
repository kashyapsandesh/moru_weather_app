import 'dart:convert';

import 'package:moru_weather_app/core/configs/strings/constants.dart';
import 'package:moru_weather_app/core/network/network_request.dart';
import 'package:moru_weather_app/weather_feat/data/model/weather_response_byplace_model.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';

class GetWeatherDetailsRepoImpl {
Future<WeatherResponseByPlaceModal> getWeatherDetailsByPlaceName(String placeName) async {
  try {
    NetworkRequest networkRequest = NetworkRequest();
    dynamic response = await networkRequest.get(
        baseUrl + "/current.json?key=$weatherApiKey&q=$placeName");

    Map<String, dynamic> jsonResponse = jsonDecode(response);

    // Check for the specific error code in the response
    if (jsonResponse.containsKey('error') &&
        jsonResponse['error']['code'] == 1006) {
      throw Exception('No matching location found for the name: $placeName');
    }

    WeatherResponseByPlaceModal weatherResponseByPlaceModal =
        WeatherResponseByPlaceModal.fromJson(jsonResponse);
    return weatherResponseByPlaceModal;
  } catch (e) {
    throw e; // Rethrow the error for the caller to handle
  }
}


  Future<WeatherResponseByPlaceModal> getWeatherDetailsByLatLong(String Lat, String Long) async {
    try {
      //instance of NetworkRequest
      NetworkRequest networkRequest = NetworkRequest();
      //api call
      dynamic response = await networkRequest
          .get(baseUrl + "/current.json?key=$weatherApiKey&q=$Lat,$Long");

      //parsing the response
      // Parse the response (decode JSON string to Map)
      Map<String, dynamic> jsonResponse = jsonDecode(response);

      WeatherResponseByPlaceModal weatherResponseByPlaceModal =
          WeatherResponseByPlaceModal.fromJson(jsonResponse);
      return weatherResponseByPlaceModal;
    } catch (e) {

      
      throw e;
    }
  }
}
