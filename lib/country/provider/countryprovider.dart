import 'package:advance_flutter_exam_part_1/country/ApiHelper/countryapi.dart';
import 'package:advance_flutter_exam_part_1/country/model/countrymodel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CountryProvider extends ChangeNotifier {
  List<CountryModel> dataList = [];
  List<String> favList = [];

  Future<List<CountryModel>> fromList() async {
    final data = await CountryApi.countryApi.fetchData();
    dataList = (data as List).map((e) => CountryModel.fromJson(e)).toList();
    return dataList;
  }

  Future<void> addToFavorites(int index, List<CountryModel> dataList) async {
    String data =
        '${dataList[index].name.common}_${dataList[index].region}_${dataList[index].flags.png}';
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool check = false;
    for (int i = 0; i < favList.length; i++) {
      if (favList[i] == data) {
        check = true;
      }
    }
    if (!check) {
      favList.add(data);
      sharedPreferences.setStringList('favList', favList);
      Fluttertoast.showToast(
        msg: 'Country Add To Favorites',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16,
      );
    } else {
      Fluttertoast.showToast(
        msg: 'Country Already Add To Favorites',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16,
      );
    }
    notifyListeners();
  }

  void removeFromLikePage(int index) {}
}
