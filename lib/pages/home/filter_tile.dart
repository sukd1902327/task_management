import 'package:flutter/material.dart';

class FilterTile extends StatelessWidget {
  const FilterTile({
    super.key,
    required this.categName,
    this.onTap
  });

  final String categName;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
        child: Container(
          decoration: BoxDecoration(
            color:  Colors.green[200],
            borderRadius: BorderRadius.circular(20)
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Text(
              categName, 
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}