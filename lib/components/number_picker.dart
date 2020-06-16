import 'package:flutter/material.dart';

class NumberPicker extends StatelessWidget {
  static const double kDefaultItemExtent = 50;
  static const double kDefaultListViewCrossAxisSize = 100;

  final int selectedIntValue;
  final int minValue;
  final int maxValue;
  final double listViewHeight;
  final double itemExtent;
  final int step;
  final Axis scrollDirection = Axis.horizontal;
  final bool infiniteLoop = false;
  final bool highlightSelectedValue = true;
  final ScrollController intScrollController;
  final Function onChanged;
  final int integerItemCount;
  final int visibleItemCount;
  final TextStyle itemStyle;
  final TextStyle selectedStyle;
  final Decoration decoration;

  NumberPicker({
    @required int initialValue,
    @required this.minValue,
    @required this.maxValue,
    @required this.onChanged,
    this.itemExtent = kDefaultItemExtent,
    this.step = 1,
    this.itemStyle,
    this.selectedStyle,
    this.listViewHeight = kDefaultListViewCrossAxisSize,
    this.visibleItemCount = 3,
    this.decoration,
  })  : selectedIntValue = initialValue,
        intScrollController = ScrollController(
          initialScrollOffset: (initialValue - minValue) ~/ step * itemExtent,
        ),
        integerItemCount = (maxValue - minValue) ~/ step + 1;

  bool _onScrollNotification(ScrollNotification notification) {
    final intValueInTheMiddle =
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
    final theExtraItemsOnTheBeginningAndEnding = 2;
    final listItemCount =
        integerItemCount + theExtraItemsOnTheBeginningAndEnding;

    return NotificationListener<ScrollNotification>(
      onNotification: _onScrollNotification,
      child: Container(
        decoration: decoration,
        height: listViewHeight,
        width: visibleItemCount * itemExtent,
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
                final value = index;

                final themeData = Theme.of(context);
                final defaultStyle =
                    this.itemStyle ?? themeData.textTheme.bodyText1;
                final selectedStyle = this.selectedStyle ??
                    themeData.textTheme.headline5
                        .copyWith(color: themeData.accentColor);
                final itemStyle =
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
