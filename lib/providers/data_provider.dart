import 'package:flutter/foundation.dart';
import 'package:pregnancy_tube/models/all_model.dart';
import 'package:http/http.dart' as http;

class UserProvider with ChangeNotifier {
  CatData user;
  String errorMessage;
  bool loading = false;

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

  void setLoading(value) {
    loading = value;
    notifyListeners();
  }

  bool isLoading() {
    return loading;
  }

  void setUser(value) {
    user = value;
    notifyListeners();
  }

  CatData getUSer() {
    return user;
  }

  void setMessage(value) {
    errorMessage = value;
  }
}