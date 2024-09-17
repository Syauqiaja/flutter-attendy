import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FailedDialog extends StatefulWidget {
  final String title;
  final String description;
  const FailedDialog(
      {required this.title, required this.description, super.key});

  @override
  State<FailedDialog> createState() => FailedDialogState();
}

class FailedDialogState extends State<FailedDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  Widget build(BuildContext context) {
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pop(); // Close the dialog
      }
    });
    _controller.forward();
    return AlertDialog(
      title: Text(widget.title, textAlign: TextAlign.center,),
      content: Lottie.asset(
            "assets/lottie/lottie_failed.json",
            repeat: false,
            controller: _controller,
            fit: BoxFit.fitHeight,
            width: 150,
            height: 150,
          ),
    );
  }
}
