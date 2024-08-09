import 'package:flutter/material.dart';

class Responsive extends StatefulWidget {
  const Responsive({super.key, required this.mobileUi, required this.webUi, this.tabletUi});

  final Widget mobileUi;
  final Widget webUi;
  final Widget? tabletUi;

  @override
  State<Responsive> createState() => _ResponsiveState();
}

class _ResponsiveState extends State<Responsive> {


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints){
          if (constraints.maxWidth >= 1100) {
            return widget.webUi;
          }
          // If width it less then 1100 and more then 650 we consider it as tablet
          else if (constraints.maxWidth >= 650) {
            return widget.tabletUi ?? widget.webUi;
          }
          // Or less then that we called it mobile
          else {
            return widget.mobileUi;
          }
        }
    );
  }
}