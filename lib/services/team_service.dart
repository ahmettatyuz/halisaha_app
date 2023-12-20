import 'package:halisaha_app/global/constants/constants.dart';
import 'package:halisaha_app/models/team.dart';

class TeamsService {
  Future<List<Team>> getAllTeams() async {
    // try {
    final response = await dio.get(
        "$API_BASEURL/api/team/");

    if (response.statusCode != 200) {
      throw (response.data);
    }
    print("gelen veriler");
    print(response.data);

    List<dynamic> json = response.data;
    return json.map((e) => Team.fromJson(e)).toList();
    // } catch (e) {
    //   print(e);
    //   throw (e);
    // }
  }


  Future<Team> createTeam(Team team) async {
    try {
      final response =
          await dio.post("$API_BASEURL/api/team/", data: team.toJson());

      if (response.statusCode != 200) {
        print(team.toJson());
        throw (response.data);
      }
      print(response.data);
      print(response.statusCode);
      return Team.fromJson(response.data);
    } catch (e) {
      print(e);
      throw (e);
    }
  }
}
