import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:foodieree/api/api_const.dart';
import 'package:foodieree/model/videos_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GetVideoProvider extends ChangeNotifier {
  List<VideosData> videosList = [];
  Future<void> getVideoData() async {
    final perf = await SharedPreferences.getInstance();
    try {
      String? getPerf = perf.getString("videoList");
      if (getPerf != null) {
        log("Internet not called");
        List<dynamic> decodedList = jsonDecode(getPerf);
        videosList =
            (decodedList).map((item) => VideosData.fromJson(item)).toList();
      } else {
        log("Internet called");
        Uri uri = Uri.parse(url);
        final response = await http.get(uri);
        if (response.statusCode == 200) {
          final decoded = jsonDecode(response.body);
          videosList = (decoded as List)
              .map((item) => VideosData.fromJson(item))
              .toList();
          String jsonString = jsonEncode(videosList);
          perf.setString("videoList", jsonString);
          notifyListeners();
        } else {
          log("Failed to load data: ${response.statusCode}");
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void playing() {}
}
