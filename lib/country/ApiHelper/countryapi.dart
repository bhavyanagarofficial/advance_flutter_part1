import 'dart:convert';
import 'package:http/http.dart' as http;

class CountryApi {
  static CountryApi countryApi = CountryApi._();

  CountryApi._();

  Future fetchData() async {
    Uri url = Uri.parse('https://restcountries.com/v3.1/all');

    try {
      final response = await http.get(url).timeout(Duration(seconds: 10));
      if (response.statusCode == 200) {
        final jsonData = response.body;
        final data = jsonDecode(jsonData);
        return data;
      } else {
        return {};
      }
    } catch (e) {
      return {};
    }
  }
}
