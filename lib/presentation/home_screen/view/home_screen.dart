import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app_with_riverpod/presentation/home_screen/controller/home_screnn_controller.dart';
import 'package:news_app_with_riverpod/presentation/home_screen/state/home_screen_state.dart';

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
      ),
      body: screenState.isLoading! || screenState.articles == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: screenState.articles?.length ?? 0,
              itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
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
                  )

              // ListTile(
              //       title: Text(screenState.articles?[index].title.toString() ??
              //           "No new Headlines"),
              //     )

              ),
    );
  }
}
