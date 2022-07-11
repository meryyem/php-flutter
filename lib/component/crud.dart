import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';

String _basicAuth = 'Basic ' + base64Encode(utf8.encode('maryem:maryem'));

Map<String, String> myheaders = {'authorization': _basicAuth};

class Crud {
  getRequest(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        return responsebody;
      } else {
        print("Eror ${response.statusCode}");
      }
    } catch (e) {
      print("Error Catch $e");
    }
  }

  postRequest(String url, Map data) async {
    await Future.delayed(const Duration(seconds: 2));
    try {
      var response =
          await http.post(Uri.parse(url), body: data, headers: myheaders);
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        return responsebody;
      } else {
        print("Eror ${response.statusCode}");
      }
    } catch (e) {
      print("Error Catch $e");
    }
  }

  //to upload files
  postRequestWithFile(String url, Map data, File file) async {
    var request = http.MultipartRequest("POST", Uri.parse(url));

    var length = await file.length();
    var stream = http.ByteStream(file.openRead());
    var multipartFile = http.MultipartFile("file", stream, length,
        filename: basename(file.path));
    request.headers.addAll(myheaders);
    request.files.add(multipartFile);

    ///request.fields['title'] = data['title'];
    //request.fields['content'] = data['content'];
    data.forEach((key, value) {
      request.fields[key] = value;
    });

    var myRequest = await request.send();

    var response = await http.Response.fromStream(myRequest);

    if (myRequest.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print("Error ${myRequest.statusCode}");
    }
  }
}
