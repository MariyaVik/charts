import 'package:flutter/material.dart';

import 'models/my_data.dart';

class CountPeopleCard extends StatefulWidget {
  final MyData data;
  final Color mainColor;
  final Color selectedColor;
  CountPeopleCard(
      {required this.data,
      this.mainColor = Colors.black12,
      this.selectedColor = Colors.yellow,
      super.key});

  @override
  State<CountPeopleCard> createState() => _CountPeopleCardState();
}

class _CountPeopleCardState extends State<CountPeopleCard> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    double size = (widget.data.percent < 20
            ? 65
            : widget.data.percent > 59
                ? 210
                : 350 * widget.data.percent / 100) *
        2;
    return MouseRegion(
      onEnter: (event) {
        isSelected = true;
        setState(() {});
      },
      onExit: (event) {
        isSelected = false;
        setState(() {});
      },
      child: Container(
        height: size,
        width: size,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(20),
            color: isSelected ? widget.selectedColor : widget.mainColor,
            shape: BoxShape.circle),
        child: AspectRatio(
          aspectRatio: 1.85,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              widget.data.category,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Text('${widget.data.percent.round()}%'),
          ]),
        ),
      ),
    );
  }
}
