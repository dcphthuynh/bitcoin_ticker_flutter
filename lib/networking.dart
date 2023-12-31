import 'package:http/http.dart' as http;
import 'dart:convert';

class Networking {

  final String url;

  Networking({this.url});

  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){
      String data = response.body;
      return jsonDecode(data);
    }else {
      print(response.statusCode);
      throw 'Your data can not be fetched from the Internet!!!';
    }
  }
}