import 'package:news_app_with_riverpod/repository/news_model/news_model.dart';

class HomescreenState {
  bool? isLoading;
  List<Article>? articles;
  HomescreenState({this.isLoading = false, this.articles});
  HomescreenState copyWith({bool? isLoading, List<Article>? articles}) {
    return HomescreenState(
        isLoading: isLoading ?? this.isLoading,
        articles: articles ?? this.articles);
  }
}
