import 'package:halisaha_app/global/constants/constants.dart';
import 'package:halisaha_app/models/owner.dart';

class OwnerService {

  Future<Owner> getOwnerById(String id) async {
    final response = await dio.get("$API_BASEURL/api/owner/$id");
    print(response.statusCode);
    if (response.statusCode == 200) {
      return Owner.fromJson(response.data);
    } else {
      throw (response.data);
    }
  }

  Future<List<String>> register(
      String parola,
      String adSoyad,
      String eposta,
      String telefon,
      String selectedCity,
      String adres,
      String isYeri,
      String webAdres,
      ) async {
    try {
      final response =
          await dio.post("$API_BASEURL/api/owner/register", data: {
        "password": parola,
        "pitchName": isYeri,
        "ownerFirstName": adSoyad,
        "ownerLastName": "string",
        "mail": eposta,
        "web": webAdres,
        "phone": telefon,
        "city": selectedCity,
        "address": adres,
        "point": 0,
        "coordinate1": "string",
        "coordinate2": "string",
        "createDate": "2023-11-14T19:43:21.916Z"
      });
      return [response.statusCode.toString(), response.data.toString()];
    } catch (e) {
      return ["404", e.toString()];
    }
  }

  
}

