import 'package:flutter/material.dart';

class HamburgerMenuButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Duration duration;
  final bool isDrawerOpened;

  const HamburgerMenuButton({
    @required this.isDrawerOpened,
    @required this.duration,
    @required this.onPressed,
    @required this.backgroundColor
  }) : assert(onPressed != null),
        assert(isDrawerOpened != null),
        assert(duration != null),
        assert(backgroundColor != null);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: duration,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor,
          boxShadow: !isDrawerOpened ? null : [
            BoxShadow(
                blurRadius: 3,
                color: Colors.black12
            )
          ]
      ),
      child: Center(
        child: IconButton(
          icon: AnimatedSwitcher(
            duration: duration,
            child: isDrawerOpened ? Icon(Icons.close): Icon(Icons.menu),
          ),
          onPressed: onPressed,
          color: Colors.black,
        ),
      ),
    );
  }
}