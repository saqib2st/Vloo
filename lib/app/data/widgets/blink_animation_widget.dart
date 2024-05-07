import 'package:flutter/material.dart';


class BlinkAnimationWidget extends StatefulWidget {
  final Widget inputWidget;

  const BlinkAnimationWidget({super.key, required this.inputWidget});

  @override
  _BlinkAnimationWidgetState createState() => _BlinkAnimationWidgetState();
}

class _BlinkAnimationWidgetState extends State<BlinkAnimationWidget>
    with SingleTickerProviderStateMixin {
  late Animation<Color?> animation;
  late AnimationController controller;

  @override
  initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    final CurvedAnimation curve = CurvedAnimation(parent: controller, curve: Curves.linear);
    animation = ColorTween(begin: Colors.white, end: Colors.blue).animate(curve);
    // Keep the animation going forever once it is started
    animation.addStatusListener((status) {
      // Reverse the animation after it has been completed
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
      setState(() {});
    });
    // Remove this line if you want to start the animation later
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) {
          return widget.inputWidget;
        },
      ),
    );
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }
}