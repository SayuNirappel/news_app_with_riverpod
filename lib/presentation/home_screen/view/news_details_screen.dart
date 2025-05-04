import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app_with_riverpod/presentation/home_screen/controller/home_screnn_controller.dart';
import 'package:news_app_with_riverpod/presentation/home_screen/state/home_screen_state.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailsScreen extends ConsumerStatefulWidget {
  final int index;
  const NewsDetailsScreen({super.key, required this.index});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends ConsumerState<NewsDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final screenState = ref.watch(homeScreenProvider) as HomescreenState;
    final article = screenState.articles?[widget.index];

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                article?.title ?? "News removed or No Data Found",
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 25),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                article?.author.toString() ?? "Unknown Author",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey.shade900),
              ),
              Text(
                article?.publishedAt.toString() ?? "Unspecified Time",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey.shade900),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  width: double.infinity,
                  height: 300,
                  child: Image.network(
                    article?.urlToImage ??
                        "https://images.pexels.com/photos/4439425/pexels-photo-4439425.jpeg?auto=compress&cs=tinysrgb&w=600",
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, StackTrace) {
                      return Image.network(
                          "https://images.pexels.com/photos/4439425/pexels-photo-4439425.jpeg?auto=compress&cs=tinysrgb&w=600",
                          fit: BoxFit.cover);
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(child: CircularProgressIndicator());
                    },
                  )),
              Text(
                article?.description.toString() ?? "Description not found",
                style: TextStyle(
                    fontStyle: FontStyle.italic, color: Colors.purple.shade900),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                article?.content.toString() ?? "Content not found",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Read More",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Colors.purple.shade900),
                textAlign: TextAlign.left,
              ),
              InkWell(
                onTap: () async {
                  final Uri newsUrl = Uri.parse(article?.url ?? "");
                  if (await canLaunchUrl(newsUrl)) {
                    await launchUrl(newsUrl,
                        mode: LaunchMode.externalApplication);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.redAccent.shade700,
                        content: Text(
                          "Couldn't find the article",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )));
                  }
                },
                child: Text(
                  article?.url ?? "Url not found",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.purple.shade900),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 200,
                      height: 30,
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.redAccent.shade700),
                      child: Text(
                        "Back",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
