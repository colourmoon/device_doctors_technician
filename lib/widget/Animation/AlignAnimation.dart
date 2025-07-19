import 'package:flutter/material.dart';

class AlignAnimationWidget extends StatefulWidget {
    AlignAnimationWidget({super.key,required this.childs});
  Widget childs;

  @override
  _AlignAnimationWidgetState createState() => _AlignAnimationWidgetState();
}

class _AlignAnimationWidgetState extends State<AlignAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<Alignment>(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).animate(_controller);
    if (_controller.status == AnimationStatus.completed) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Align(
          alignment: _animation.value,
          child: widget.childs,
        );
      },
    );
  }
}
