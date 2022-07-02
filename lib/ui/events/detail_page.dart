import 'package:flutter/material.dart';

import '../../vltx/vltx.dart';
import '../home/data/data.dart';
import 'components/event_info.dart';

class EventDetailPage extends StatefulWidget {
  final EventMeeting item;
  const EventDetailPage({Key? key, required this.item}) : super(key: key);

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                elevation: 0,
                expandedHeight: 200,
                backgroundColor: Colors.transparent,
                leading: Builder(builder: (context) {
                  return IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black38),
                      onPressed: () => Navigator.of(context).pop());
                }),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.home, color: Colors.black38),
                    onPressed: () {
                      
                    },
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: AppBanner(imgUrl: widget.item.imgUrl,),
                ),
                pinned: true,
              ),
              const SliverToBoxAdapter(
                child: EventInfo(),
              ),
            ];
          },
          body: Container(),
        ),
      ),
    );
  }
}
