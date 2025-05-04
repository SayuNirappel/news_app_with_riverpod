import 'package:news_app_with_riverpod/repository/api/api_config/app_config.dart';
import 'package:news_app_with_riverpod/repository/api/api_helper/api_helper.dart';
import 'package:news_app_with_riverpod/repository/news_model/news_model.dart';

class ApiHomeScreenService {
  //fetching news based on country
  Future<CountryHotNewsResModel?> getCountryNews({String? searchKey}) async {
    if (AppConfig.searchStat == false || searchKey == "") {
      final resBody =
          await ApiHelper.getData(endpoint: "/top-headlines?country=us");

      if (resBody != null) {
        final respModel = countryHotNewsResModelFromJson(resBody);
        return respModel;
      } else {
        return null;
      }
    } else {
      final resBody =
          await ApiHelper.getData(endpoint: "/everything?q=$searchKey");

      if (resBody != null) {
        final respModel = countryHotNewsResModelFromJson(resBody);
        return respModel;
      } else {
        return null;
      }
    }
  }
}
