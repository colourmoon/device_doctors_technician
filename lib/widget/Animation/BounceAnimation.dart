// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class BouncingWidget extends StatefulWidget {
    BouncingWidget({Key? key, required this.child, required this.add,required this.onTap})
      : super(key: key);
  final Widget child;
  final bool add;
  GestureTapCallback onTap;

  @override
  _BouncingWidgetState createState() => _BouncingWidgetState();
}

class _BouncingWidgetState extends State<BouncingWidget>
    with SingleTickerProviderStateMixin {
  late double _scale;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.add == true) {
      // Scale up when widget.add is true
      _scale = 1 + _controller.value;
    } else {
      // Scale down when widget.add is false
      _scale = 1 - _controller.value;
    }

    return Center(
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: () {
          _controller.reverse();
        },
        child: InkWell(
          onTap: widget.onTap,
          child: Transform.scale(
            scale: _scale,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
