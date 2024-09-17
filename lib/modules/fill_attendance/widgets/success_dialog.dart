import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SuccessDialog extends StatefulWidget {
  final String title;
  final Function onComplete;
  const SuccessDialog(
      {required this.title, required this.onComplete, super.key});

  @override
  State<SuccessDialog> createState() => SuccessDialogState();
}

class SuccessDialogState extends State<SuccessDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  Widget build(BuildContext context) {
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pop(); // Close the dialog
        widget.onComplete();
      }
    });
    _controller.forward();
    return AlertDialog(
      title: Text(widget.title, textAlign: TextAlign.center,),
      content: Lottie.asset(
            "assets/lottie/lottie_success.json",
            repeat: false,
            controller: _controller,
            fit: BoxFit.fitHeight,
            width: 150,
            height: 150,
          ),
    );
  }
}
