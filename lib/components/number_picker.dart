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
  final TextStyle itemStyle;
  final TextStyle selectedStyle;

  NumberPicker({
    @required int initialValue,
    @required this.minValue,
    @required this.maxValue,
    @required this.onChanged,
    this.itemExtent = kDefaultItemExtent,
    this.step = 1,
    this.itemStyle,
    this.selectedStyle,
  })  : selectedIntValue = initialValue,
        intScrollController = ScrollController(
          initialScrollOffset: (initialValue - minValue) ~/ step * itemExtent,
        ),
        listViewWidth = 3 * itemExtent,
        integerItemCount = (maxValue - minValue) ~/ step + 1;

  bool _onScrollNotification(ScrollNotification notification) {
    int intValueInTheMiddle =
        (notification.metrics.pixels / itemExtent).round() + 1;
    if (intValueInTheMiddle != selectedIntValue) {
      onChanged(intValueInTheMiddle);
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    // We need to pad the list so we can "select" the first
    // and last item.
    int theExtraItemsOnTheBeginningAndEnding = 2;
    int listItemCount = integerItemCount + theExtraItemsOnTheBeginningAndEnding;

    return NotificationListener<ScrollNotification>(
      onNotification: _onScrollNotification,
      child: Container(
        height: listViewHeight,
        width: listViewWidth,
        child: Stack(
          children: [
            ListView.builder(
              scrollDirection: Axis.horizontal,
              // todo `controller` prop
              // todo `cacheExtent`
              itemExtent: itemExtent,
              // todo different from numberpicker. numberpicker has extra 2 items ?
              itemCount: listItemCount,
              itemBuilder: (context, index) {
                // todo different from numberpicker. numberpicker has
                // to consider `step`
                final int value = index;

                final ThemeData themeData = Theme.of(context);
                TextStyle defaultStyle =
                    this.itemStyle ?? themeData.textTheme.bodyText1;
                TextStyle selectedStyle = this.selectedStyle ??
                    themeData.textTheme.headline5
                        .copyWith(color: themeData.accentColor);
                final TextStyle itemStyle =
                    value == selectedIntValue ? selectedStyle : defaultStyle;

                final edgeItems = index == 0 || index == listItemCount - 1;

                return edgeItems
                    ? Container()
                    : Center(
                        child: Text(value.toString(), style: itemStyle),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
