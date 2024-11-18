import 'dart:convert';

import 'package:http/http.dart'as http;
import 'package:http/http.dart';
class ApiServices
{
  Future<Map<String,dynamic>> fetchdata({String query=""})
  async {
    String api="https://saavn.dev/api/search/songs?query=$query";
    Uri uri=Uri.parse(api);
    Response response =await http.get(uri);
    if(response.statusCode==200)
      {
        String json= response.body;
        Map<String,dynamic> songs=jsonDecode(json);
        return songs;
      }
    return{};

  }


}