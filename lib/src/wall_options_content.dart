import 'package:wall_scaffold/src/wall_item.dart';
import 'package:flutter/material.dart';

typedef OptionSelectedCallback = Function();

final GlobalKey<_WallOptionsContentState> optionsKey = GlobalKey();

class WallOptionsContent extends StatefulWidget {
  final List<WallItem> items;
  final int initialIndex;
  final int currentIndex;
  final Function(int) onItemSelected;
  final Color selectedItemColor;
  final Color itemColor;

  WallOptionsContent({
    @required this.items,
    this.initialIndex,
    @required this.currentIndex,
    @required this.onItemSelected,
    this.itemColor,
    this.selectedItemColor,
  })  : assert(items != null),
        assert(currentIndex != null),
        assert(onItemSelected != null),
        super(key: optionsKey);

  @override
  _WallOptionsContentState createState() => _WallOptionsContentState();
}

class _WallOptionsContentState extends State<WallOptionsContent> {

  int _currentIndex;

  OptionSelectedCallback optionSelectedCallback;

  void _notifyListeners() {
    if (optionSelectedCallback != null) {
      optionSelectedCallback();
    }
  }

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final _selectedColor = widget.selectedItemColor ?? theme.textSelectionColor;
    final _itemColor = widget.itemColor ?? theme.unselectedWidgetColor;

    return SafeArea(
      child: Align(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.items.length,
          itemBuilder: (_, index) {
            final item = widget.items.elementAt(index);
            return GestureDetector(
              onTap: () {
                _currentIndex = index;
                widget.onItemSelected(index);
                _notifyListeners();
              },
              child: _WallItemWidget(
                item: item,
                color: _itemColor,
                selectedColor: _selectedColor,
                isSelected: _currentIndex == index,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _WallItemWidget extends StatelessWidget {
  final bool isSelected;
  final WallItem item;
  final Color selectedColor;
  final Color color;

  const _WallItemWidget({
    @required this.item,
    @required this.isSelected,
    @required this.color,
    @required this.selectedColor,
  })  : assert(item != null),
        assert(isSelected != null),
        assert(selectedColor != null),
        assert(color != null);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final _itemColor = isSelected ? selectedColor : color;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: <Widget>[
          if (item.icon != null)
            Padding(
              padding: EdgeInsets.only(right: 16),
              child: item.icon,
            ),
          DefaultTextStyle.merge(
            child: item.title,
            style: theme.textTheme.title.copyWith(
              color: _itemColor,
            )
          )
        ],
      ),
    );
  }
}
