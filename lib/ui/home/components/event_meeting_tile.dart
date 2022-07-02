import 'package:flutter/material.dart';

import '../../events/detail_page.dart';
import '../../themes.dart';
import '../data/data.dart';

class EventMeetingTile extends StatefulWidget {
  final List<EventMeeting> items;
  const EventMeetingTile({
    Key? key, required this.items,
  }) : super(key: key);

  @override
  State<EventMeetingTile> createState() => _EventMeetingTileState();
}

class _EventMeetingTileState extends State<EventMeetingTile> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: VLTxTheme.padding),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(VLTxTheme.radius),
        child: Container(
          height: 150.0,
          width: double.infinity,
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12, offset: Offset(0, 3), blurRadius: 6)
            ],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              PageView.builder(
                itemCount: widget.items.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => EventDetailPage(item: widget.items[index],)
                      )
                    );
                  },
                  child: Hero(
                    tag: widget.items[index].imgUrl,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(VLTxTheme.radius),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage(widget.items[index].imgUrl),
                        ),
                      ),
                    ),
                  ),
                ),
                onPageChanged: (value) {
                  setState(() {
                    _currentIndex = value;
                  });
                },
              ),
              Positioned(
                top: VLTxTheme.padding,
                left: VLTxTheme.padding,
                child: Row(
                  children: List.generate(
                      widget.items.length,
                      (index) => Padding(
                            padding:
                                const EdgeInsets.only(left: VLTxTheme.padding / 4),
                            child: IndicatorDot(
                              isActive: index == _currentIndex,
                            ),
                          )),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.2),
                  ),
                  padding: const EdgeInsets.all(VLTxTheme.padding),
                  child: Text(
                    widget.items[_currentIndex].name,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IndicatorDot extends StatelessWidget {
  final bool isActive;
  const IndicatorDot({
    Key? key,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4,
      width: 8,
      decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.white38,
          borderRadius: const BorderRadius.all(Radius.circular(VLTxTheme.radius))),
    );
  }
}
