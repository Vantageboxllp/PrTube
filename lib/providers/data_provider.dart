import 'package:flutter/foundation.dart';
import 'package:pregnancy_tube/models/all_model.dart';

class DataProvider with ChangeNotifier{
  CatData catData;
List<Video> get itemes{
  return [...catData.videos];
}


}