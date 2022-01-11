import 'dart:convert';

import 'package:http/http.dart' as httpClient;
import 'package:mygate_app/src/globals.dart';
import 'db_service_respoance_modal.dart';
import 'overrides.dart';

class DbServices {
  // getapi(api, {headers}) async {
  //   try {
  //     if (Globals.token == null || Globals.token == '') {
  //       // In case of no access token, calling the login API to reset it.
  //       try {
  //         await login();
  //       } catch (e) {}
  //     }
  //     final response =
  //         await httpClient.get(Uri.parse('${Overrides.API_BASE_URL}$api'),
  //             // ignore: prefer_if_null_operators
  //             headers: headers != null
  //                 ? headers
  //                 : {
  //                     'Content-Type': 'application/json',
  //                     'authorization': 'Bearer ${Globals.token}'
  //                   });

  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //       return ResponseModel(statusCode: response.statusCode, data: data);
  //     } else {
  //       if (response.body == 'Unauthorized') {
  //         ResponseModel _res = await getapi(api, headers: headers);
  //         return _res;
  //       }
  //       return ResponseModel(statusCode: response.statusCode, data: null);
  //     }
  //   } catch (e) {
  //     if (e.toString().contains('Failed host lookup')) {
  //       throw ('NO_CONNECTION');
  //     } else {
  //       throw (e);
  //     }
  //   }
  // }

  postapi(api, {body, headers}) async {
    try {
      final response = await httpClient.post(
          Uri.parse('${Overrides.API_BASE_URL}$api'),
          headers: headers ??
              {
                'Content-Type': 'application/json',
                'authorization': 'Bearer ${Globals.token}'
              },
          body: json.encode(body));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return ResponseModel(statusCode: response.statusCode, data: data);
      } else {
        if (response.body == 'Unauthorized') {
          ResponseModel _res = await postapi(api, body: body, headers: headers);
          return _res;
        }
        final data = json.decode(response.body);
        return ResponseModel(statusCode: response.statusCode, data: data);
      }
    } catch (e) {
      if (e.toString().contains('Failed host lookup')) {
        throw ('NO_CONNECTION');
      } else {
        throw (e);
      }
    }
  }

  // get List Object using this method
}
