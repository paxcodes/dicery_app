import 'package:flutter/material.dart';

class NumberPicker extends StatelessWidget {
  static const double kDefaultItemExtent = 50;
  static const double kDefaultListViewCrossAxisSize = 100;

  final int selectedIntValue;
  final int minValue;
  final int maxValue;
  final double listViewWidth;
  final double listViewHeight = kDefaultListViewCrossAxisSize;
  final double itemExtent;
  final int step;
  final Axis scrollDirection = Axis.horizontal;
  final bool infiniteLoop = false;
  final bool highlightSelectedValue = true;
  final ScrollController intScrollController;
  final Function onChanged;
  final int integerItemCount;

  NumberPicker({
    @required int initialValue,
    @required this.minValue,
    @required this.maxValue,
    @required this.onChanged,
    this.itemExtent = kDefaultItemExtent,
    this.step = 1,
  })  : selectedIntValue = initialValue,
        intScrollController = ScrollController(
          initialScrollOffset: (initialValue - minValue) ~/ step * itemExtent,
        ),
        listViewWidth = 3 * itemExtent,
        integerItemCount = (maxValue - minValue) ~/ step + 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 3 * itemExtent,
      width: 100,
      child: Stack(
        children: [
          ListView.builder(
            scrollDirection: Axis.horizontal,
            // todo `controller` prop
            // todo `cacheExtent`
            itemExtent: itemExtent,
            // todo different from numberpicker. numberpicker has extra 2 items ?
            itemCount: integerItemCount,
            itemBuilder: (context, index) {
              // todo different from numberpicker. numberpicker has
              // to consider `step`
              final int value = index + 1;

              final ThemeData themeData = Theme.of(context);
              TextStyle defaultStyle = themeData.textTheme.bodyText1;
              TextStyle selectedStyle = themeData.textTheme.headline5
                  .copyWith(color: themeData.accentColor);
              final TextStyle itemStyle =
                  value == selectedIntValue ? selectedStyle : defaultStyle;

              return Center(
                child: Text(value.toString(), style: itemStyle),
              );
            },
          ),
        ],
      ),
    );
  }
}
