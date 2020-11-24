import 'package:shared_preferences/shared_preferences.dart';
import 'package:uzuri/model/Catelogues.dart';
import 'package:uzuri/model/Response.dart';
import 'package:uzuri/ws/Constants.dart';
import 'package:uzuri/ws/api.dart';

class UserRepository {
  Api api;
  SharedPreferences prefs;
  CateloguesList cateloguesList;

  UserRepository() {
    api = Api();
    getPref();
    cateloguesList = CateloguesList();
  }

  getPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<Response> postLogin(Map data) async {
    final res = await api.post("login", data);

    if (res.success) {
      Constants.token = res.value['user_id'];
      await prefs.setInt("token", res.value['user_id']);
    } else {
      Constants.token = 1;
    }

    return res;
  }

  Future<Response> postRegister(Map data) async {
    Response res = await api.post("register", data);
    return res;
  }

  Future<Response> getAllNotify() async {
    var token = Constants.token;
    final res = await api.get("getNotifications/$token");

    return res;
  }

  Future<Response> getNotifDetails(int id) async {
    final res = await api.get("getNotify/$id");

    return res;
  }

  Future<Response> getListPdf() async {
    var token = Constants.token;

    final res = await api.get("getAllPdfs/$token");
    if (res.success) {
      cateloguesList = CateloguesList.fromJson(res.value);
      res.value = cateloguesList;
    } else {
      res.value = [];
    }

    return res;
  }

  Future<Response> getPdf(int id) async {
    final res = await api.get("getPdf/$id");

    return res;
  }
}
