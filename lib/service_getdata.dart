import 'package:http/http.dart' as http;
import 'package:pregnancy_tube/models/slider_model.dart';
import './models/all_model.dart';

class Services {

  static const String url ='https://raw.githubusercontent.com/Vantageboxllp/boyapi/master/datas.json';
   static String base_url="https://raw.githubusercontent.com/Vantageboxllp/boyapi/master/";

  static Future<List<CatData>> getData() async {
    try {

      final response = await http.get(url);
      if (200 == response.statusCode){
        final List<CatData> catData = catDataFromJson(response.body);
        return catData;
      }else {
        return  List<CatData>();
      }

    } catch(e) {
      return List<CatData>();
    }

  }
  static Future<List<SliderModel>> get_sliderimages(String url) async {
    try {

      final response = await http.get(base_url+url);

      if (200 == response.statusCode){
        //print(response.toString());
        final List<SliderModel> sliderimages =SliderFromJson(response.body);
        return sliderimages;
      }else {
        return  List<SliderModel>();
      }

    } catch(e) {
      return List<SliderModel>();
    }

  }

}