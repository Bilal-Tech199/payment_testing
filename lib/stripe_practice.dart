import 'package:flutter/material.dart';

class StripePractice extends StatefulWidget {
  const StripePractice({super.key});

  @override
  State<StripePractice> createState() => _StripePracticeState();
}

class _StripePracticeState extends State<StripePractice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("stripe"),
      ),
    );
  }
}
