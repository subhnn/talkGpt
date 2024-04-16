import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:talkgpt/histroryModel.dart';

class SecurityApiService {
  Future<List<Speechs>> getSpeechs(String userId) async{
    var client= http.Client();
    var apiUrl=Uri.parse("http://localhost:3001/api/user/viewspeech");
    var response = await client.post(apiUrl,
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
        body: jsonEncode(<String, String>{
          "userId": userId
        })
    );
    if(response.statusCode==200)
    {
      return speechsFromJson(response.body);
    }
    else
    {
      return [];
    }

  }
  Future<dynamic> addSecurityApi(String name, String phno, String email, String password) async
  {
    var client = http.Client();
    var apiUrl = Uri.parse("http://172.20.10.4:3001/api/user/add");

    var response = await client.post(apiUrl,
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
        body: jsonEncode(<String, String>{
          "name": name,
          "phno": phno,
          "email": email,
          "password": password,
        })
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    else {
      throw Exception("failed to add");
    }
  }
  Future<dynamic> addSpeechApi(String userId, String speech) async
  {
    var client = http.Client();
    var apiUrl = Uri.parse("http://localhost:3001/api/user/addspeech");

    var response = await client.post(apiUrl,
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
        body: jsonEncode(<String, String>{
          "userId": userId,
          "speech": speech,
        })
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    else {
      throw Exception("failed to add");
    }
  }

  Future<dynamic> SecurityloginData(String email, String password) async {
    var client = http.Client();
    var apiUrl = Uri.parse("http://localhost:3001/api/user/login");

    var response = await client.post(apiUrl,
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
        body: jsonEncode(<String, String>{
          "email": email,
          "password": password,
        })
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    else {
      throw Exception("failed to login");
    }
  }
}


