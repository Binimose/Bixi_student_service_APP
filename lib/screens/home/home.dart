import 'package:flutter/material.dart';
import 'package:loadmore/loadmore.dart';
import 'package:BIXI/common/colors.dart';
import 'package:BIXI/common/common.dart';
import 'package:BIXI/common/widgets/no_connectivity.dart';
import 'package:BIXI/models/listdata_model.dart';
import 'package:BIXI/models/news_model.dart' as m;
import 'package:BIXI/providers/news_provider.dart';
import 'package:BIXI/screens/home/widgets/CategoryItem.dart';
import 'package:BIXI/screens/home/widgets/newsCard.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _HomeState();
}

class _HomeState extends State<home> {
  List<String> categories = [
    'business',
    'entertainment',
    'general',
    'health',
    'science',
    'sports',
    'technology'
  ];

  int activeCategory = 0;

  int page = 1;
  bool isFinish = false;
  bool data = false;
  List<m.News> articles = [];

  @override
  void initState() {
    super.initState();
    checkConnectivity();
  }

  Future<void> checkConnectivity() async {
    if (await getInternetStatus()) {
      getNewsData();
    } else {
      Navigator.of(
        context,
        rootNavigator: true,
      )
          .push(
            MaterialPageRoute(
              builder: (context) => const NoConnectivity(),
            ),
          )
          .then(
            (value) => checkConnectivity(),
          );
    }
  }

  Future<bool> getNewsData() async {
    ListData listData = await NewsProvider()
        .GetEverything(categories[activeCategory].toString(), page++);

    if (listData.status) {
      List<m.News> items = listData.data as List<m.News>;
      data = true;

      if (mounted) {
        setState(() {});
      }

      if (items.length == listData.totalContent) {
        isFinish = true;
      }

      if (items.isNotEmpty) {
        articles.addAll(items);
        setState(() {});
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        leading: Center(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20,
            ),
          ),
        ),
        backgroundColor: AppColors.black,
        elevation: 5,
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.search,
              size: 34,
              color: AppColors.white,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              width: size.width,
              child: ListView.builder(
                itemCount: categories.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) => CategoryItem(
                  index: index,
                  categoryName: categories[index],
                  activeCategory: activeCategory,
                  onClick: () {
                    setState(() {
                      activeCategory = index;
                      articles = [];
                      page = 1;
                      isFinish = false;
                      data = false;
                    });
                    getNewsData();
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: size.height,
              child: LoadMore(
                isFinish: isFinish,
                onLoadMore: getNewsData,
                whenEmptyLoad: true,
                delegate: const DefaultLoadMoreDelegate(),
                textBuilder: DefaultLoadMoreTextBuilder.english,
                child: ListView.builder(
                  itemCount: articles.length,
                  itemBuilder: (context, index) =>
                      NewsCard(article: articles[index]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
