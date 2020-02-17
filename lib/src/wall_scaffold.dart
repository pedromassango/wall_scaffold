import 'package:wall_scaffold/src/menu_button.dart';
import 'package:wall_scaffold/src/wall_content.dart';
import 'package:wall_scaffold/src/wall_options_content.dart';
import 'package:flutter/material.dart';

class WallScaffold extends StatefulWidget {
  final WallContent wallContent;
  final Widget mainContent;
  final Color drawerOpenedButtonColor;
  final Color drawerClosedButtonColor;
  final Curve mainContentAnimationCurve;

  const WallScaffold({Key key,
    @required this.wallContent,
    @required this.mainContent,
    this.drawerClosedButtonColor = Colors.white,
    this.drawerOpenedButtonColor = Colors.white,
    this.mainContentAnimationCurve = Curves.easeInOut,
  }) : assert(wallContent != null),
      assert(drawerClosedButtonColor != null),
      assert(drawerOpenedButtonColor != null),
      assert(mainContentAnimationCurve != null),
      assert(mainContent != null);

  @override
  _WallScaffoldState createState() => _WallScaffoldState();
}

class _WallScaffoldState extends State<WallScaffold>
  with SingleTickerProviderStateMixin {

  final animationDuration = Duration(milliseconds: 270);
  bool _isMenuOpened = false;

  AnimationController _animationController;
  Animation<double> _animation;

  void _toggleDrawer() {
    if (_isMenuOpened) {
      _closeDrawer();
    } else {
      _openDrawer();
    }
  }

  void _openDrawer() {
    if (!_animationController.isCompleted &&
        !_animationController.isAnimating) {
      setState(() => _isMenuOpened = !_isMenuOpened);
      _animationController.forward();
    }
  }

  void _closeDrawer() {
    if (_animationController.isCompleted &&
        !_animationController.isAnimating) {
      setState(() => _isMenuOpened = !_isMenuOpened);
      _animationController.reverse();
    }
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this,
        duration: animationDuration
    );

    _animation = Tween<double>(
        begin: 0.0, end: 1.0
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: widget.mainContentAnimationCurve
    ));

    WidgetsBinding.instance.addPostFrameCallback((_){
      optionsKey.currentState.optionSelectedCallback = () {
        _closeDrawer();
      };
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final menuWith = 42.5;
    final buttonBackgroundColor = _isMenuOpened
        ? widget.drawerOpenedButtonColor
        : widget.drawerClosedButtonColor;

    return Scaffold(
      body: Stack(
        alignment: Alignment.centerRight,
        children: <Widget>[
          widget.wallContent,
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, _) {
              final slidePercent = menuWith * _animation.value;
              final scalePercent = 1.0 - (0.01 * slidePercent);

              return Transform(
                transform:
                    Matrix4.translationValues(slidePercent, slidePercent, 0.0)
                      ..scale(scalePercent, scalePercent),
                alignment: Alignment.centerRight,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(_animation.value * 16),
                  child: DecoratedBox(
                      child: widget.mainContent,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 100,
                        )
                      ]
                    ),
                  ),
                ),
              );
            },
          ),
          AnimatedPositioned(
            duration: animationDuration,
            top: _isMenuOpened ? screenSize.height / 2.0 : 16,
            right: _isMenuOpened ? screenSize.width / 2.5 : 0,
            child: AnimatedPadding(
              duration: animationDuration,
              padding: EdgeInsets.all(_isMenuOpened ? 0 : 16),
              child: HamburgerMenuButton(
                  isDrawerOpened: _isMenuOpened,
                  duration: animationDuration,
                  backgroundColor: buttonBackgroundColor,
                  onPressed: _toggleDrawer
              ),
            ),
          ),
        ],
      ),
    );
  }
}
