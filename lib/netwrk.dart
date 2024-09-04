import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

Dio dio = Dio();


void auth() async {
  // Create a Dio instance
  

  // Set the cookieJar option to enable cookie storage and reuse
  //dio.options.cookieJar = CookieJar();
  final cookieJar = CookieJar();
  dio.interceptors.add(CookieManager(cookieJar));
  // Make an HTTP request
  Response response = await dio.get('http://192.168.43.164:8008/');

  if (response.statusCode==200)
  {
     var json_response = json.decode(response.data);
  }
  else
  {

  }
  // Get the cookies from the response
  /*List<Cookie> cookies = response.headers['set-cookie'].map((cookie) {
    return Cookie.fromSetCookieHeader(cookie);
  }).toList();

  // Store the cookies for future requests
  dio.options.cookieJar.save(cookies);
  */
}


Future<dynamic> getData() async {
    final url = 'http://192.168.1.151:8008/';
   // final url = 'http://192.168.43.164:8008/';
    late dynamic json_response = {};
    final cookieJar = CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));
    try {
      final response = await dio.get(
        url,
        options: Options(
          contentType: '*/*', // Set the content type to JSON
        ),
      );

      if ((response.statusCode == 200)||(response.statusCode == 201)) 
      {
        json_response=response.data;
        print("json request is ${json_response['status']}");
      } 
      else 
      {
      
      }
    } catch (error) 
    {
    
    }

    return json_response;
  }

 Future<dynamic> postData(path,data) async {
    final url = 'http://192.168.1.151:8008/$path';
    late dynamic json_response = {};
    
    final cookieJar = CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));

    try {
      final response = await dio.post(
        url,
        data: data,
        options: Options(
          contentType: 'application/json', // Set the content type to JSON
        ),
      );

      if ((response.statusCode == 200)||(response.statusCode == 201)) 
      {
        json_response = response.data;
        print(json_response);
        //json.decode(response.data.toString());  
      } 
      else 
      {
      
      }
    } catch (error) 
    {
    
    }

    return json_response;
  }