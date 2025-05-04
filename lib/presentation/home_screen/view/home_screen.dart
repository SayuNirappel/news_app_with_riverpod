import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app_with_riverpod/presentation/home_screen/controller/home_screnn_controller.dart';
import 'package:news_app_with_riverpod/presentation/home_screen/state/home_screen_state.dart';
import 'package:news_app_with_riverpod/presentation/home_screen/view/news_details_screen.dart';
import 'package:news_app_with_riverpod/presentation/home_screen/view/search_screen.dart';
import 'package:news_app_with_riverpod/repository/api/api_config/app_config.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await ref.read(homeScreenProvider.notifier).getHotNews();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenState = ref.watch(homeScreenProvider) as HomescreenState;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent.shade700,
          title: Text(
            "News 360",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          actions: [
            InkWell(
              onTap: () async {
                AppConfig.searchStat = false;
                await ref.read(homeScreenProvider.notifier).getHotNews();
              },
              child: Icon(
                Icons.refresh,
                size: 30,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 15,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchScreen()));
              },
              child: Icon(
                Icons.search,
                size: 30,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 22,
            )
          ],
        ),
        body: screenState.isLoading! || screenState.articles == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : CustomScrollView(
                slivers: [
                  SliverAppBar(
                    floating: true,
                    backgroundColor: Colors.grey.shade100,
                    title: Text(
                      "News Headlines",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  SliverList(
                      delegate: SliverChildBuilderDelegate(
                    (context, index) => Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewsDetailsScreen(
                                        index: index,
                                      )));
                        },
                        child: Column(
                          spacing: 8,
                          children: [
                            Text(
                              screenState.articles?[index].title.toString() ??
                                  "News removed or No Data Found",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: index % 3 == 0
                                      ? Colors.black
                                      : index % 2 == 0
                                          ? Colors.red.shade900
                                          : Colors.purple.shade900,
                                  fontSize: 25),
                            ),
                            Container(
                                width: double.infinity,
                                height: 300,
                                child: Image.network(
                                  screenState.articles?[index].urlToImage ??
                                      "https://images.pexels.com/photos/4439425/pexels-photo-4439425.jpeg?auto=compress&cs=tinysrgb&w=600",
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, StackTrace) {
                                    return Image.network(
                                        "https://images.pexels.com/photos/4439425/pexels-photo-4439425.jpeg?auto=compress&cs=tinysrgb&w=600",
                                        fit: BoxFit.cover);
                                  },
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                        child: CircularProgressIndicator());
                                  },
                                ))
                          ],
                        ),
                      ),
                    ),
                    childCount: screenState.articles?.length ?? 0,
                  ))
                ],
              ));
  }
}
