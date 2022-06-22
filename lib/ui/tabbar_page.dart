import 'package:flutter/material.dart';

class SliverWithTabBar extends StatefulWidget {
  const SliverWithTabBar({Key? key}) : super(key: key);

  @override
  _SliverWithTabBarState createState() => _SliverWithTabBarState();
}

class _SliverWithTabBarState extends State<SliverWithTabBar> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: false,
              backgroundColor: Colors.white,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 200.0,
                      width: double.infinity,
                      color: Colors.grey,
                      child: const FlutterLogo(),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Business Office',
                        style: TextStyle(fontSize: 25.0),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Open now\nStreet Address, 299\nCity, State',
                        style: TextStyle(fontSize: 15.0),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Icon(Icons.share),
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Icon(Icons.favorite),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              expandedHeight: 380.0,
              bottom: TabBar(
                indicatorColor: Colors.black,
                labelColor: Colors.black,
                tabs: const [
                  Tab(text: 'POSTS'),
                  Tab(text: 'DETAILS'),
                  Tab(text: 'FOLLOWERS'),
                ],
                controller: tabController,
              ),
            )
          ];
        },
        body: TabBarView(
          controller: tabController,
          children: [
            const Center(child: Text('Thông tin giải thưởng')),
            // Summary
            ListView.builder(
              itemCount: 100,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  color: index % 2 == 0 ? Colors.blue : Colors.green,
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 100.0,
                    child: const Text(
                      'Flutter is awesome',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                );
              },
            ),
            const Center(child: Text('Thú cưng thất lạc')),
          ],
        ),        
      ),
    );
  }
}