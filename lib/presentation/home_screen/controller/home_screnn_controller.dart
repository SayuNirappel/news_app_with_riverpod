import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:news_app_with_riverpod/presentation/home_screen/state/home_screen_state.dart';
import 'package:news_app_with_riverpod/repository/news_model/news_model.dart';

final homeScreenProvider =
    StateNotifierProvider((ref) => HomeScreenStateNotifier());

class HomeScreenStateNotifier extends StateNotifier<HomescreenState> {
  HomeScreenStateNotifier() : super(HomescreenState());

  Future<void> getHotNews() async {
    state = state.copyWith(isLoading: true);

    try {
      final url = Uri.parse(
          "https://newsapi.org/v2/top-headlines?country=us&apiKey=2eccbd4ec42442ef9448394d1a6f19d9");
      final resp = await http.get(url);

      if (resp.statusCode == 200) {
        CountryHotNewsResModel respModel =
            countryHotNewsResModelFromJson(resp.body);
        state = state.copyWith(articles: respModel.articles, isLoading: false);
      } else {
        log(resp.statusCode.toString());
      }
    } catch (e) {
      log(e.toString());
    }

    state = state.copyWith(isLoading: false);
  }
}

//01:15
