import 'package:http/http.dart' as http;
import './models/all_model.dart';
import 'models/slider_model.dart';


class Services {

 // static const String url ='https://raw.githubusercontent.com/Vantageboxllp/boyapi/master/datas.json';

 static const String mainurl ='https://raw.githubusercontent.com/Vantageboxllp/boyapi/master/datas.json';
 static const String slider_url = 'https://raw.githubusercontent.com/Vantageboxllp/boyapi/master/slider_images.json';
  
  static Future<List<CatData>> getData() async {
    try {

      final response = await http.get(mainurl);
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

static Future<List<SliderModel>> get_sliderimages() async {
    try {

      final response = await http.get(slider_url);

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