import 'package:http/http.dart' as http;
import './models/all_model.dart';

class Services {

  static const String url ='https://raw.githubusercontent.com/Vantageboxllp/boyapi/master/datas.json';
  
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
}