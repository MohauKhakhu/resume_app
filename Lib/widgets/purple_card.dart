import 'package:flutter/material.dart';

class PurpleCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final VoidCallback? onTap;
  final bool elevated;

  const PurpleCard({
    Key? key,
    required this.child,
    this.margin,
    this.padding,
    this.onTap,
    this.elevated = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin ?? const EdgeInsets.all(8.0),
      elevation: elevated ? 4 : 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.purple.shade50,
              Colors.purple.shade100,
              Colors.purple.shade50,
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.purple.shade200, width: 1),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: padding ?? const EdgeInsets.all(20.0),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}