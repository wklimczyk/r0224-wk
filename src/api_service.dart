import 'dart:convert';
import 'package:http/http.dart' as http;
import 'data_model.dart';

class ApiService {
  Future<DataModel> fetchData() async {
    final response = await http.get(Uri.parse('http://www.mock.com/example'));

    if (response.statusCode == 200) {
      return DataModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }
}