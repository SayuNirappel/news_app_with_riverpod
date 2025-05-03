import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:news_app_with_riverpod/presentation/home_screen/state/home_screen_state.dart';
import 'package:news_app_with_riverpod/repository/api/api_config/app_config.dart';
//import 'package:news_app_with_riverpod/repository/api/api_config/app_config.dart';
import 'package:news_app_with_riverpod/repository/api/api_home_screen_service/api_home_screen_service.dart';
//import 'package:news_app_with_riverpod/repository/news_model/news_model.dart';

final homeScreenProvider =
    StateNotifierProvider((ref) => HomeScreenStateNotifier());

class HomeScreenStateNotifier extends StateNotifier<HomescreenState> {
  HomeScreenStateNotifier() : super(HomescreenState());

  Future<void> getHotNews({String? searchKey}) async {
    try {
      if (AppConfig.searchStat == false || searchKey == null) {
        final resp = await ApiHomeScreenService().getCountryNews();

        if (resp != null) {
          state = state.copyWith(articles: resp.articles, isLoading: false);
        } else {
          log("No data found");
          state = state.copyWith(isLoading: false);
        }
      } else {
        final resp =
            await ApiHomeScreenService().getCountryNews(searchKey: searchKey);

        if (resp != null) {
          state = state.copyWith(articles: resp.articles, isLoading: false);
        } else {
          log("No data found");
          state = state.copyWith(isLoading: false);
        }
      }
    } catch (e) {
      log(e.toString());
    }

    state = state.copyWith(isLoading: false);
  }
}

//01:15
