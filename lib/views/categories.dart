import 'package:flutter/material.dart';
import 'package:tandrustito/core/shared/halpers.dart';
import 'package:tandrustito/features/specialiests/model/specialiests_model.dart';
import 'package:tandrustito/views/home.dart';

class CategoryWidget extends StatefulWidget {
  final SpecialiestsModel category;
  final bool isSelected;
  final Function(SpecialiestsModel index) onTap;

  const CategoryWidget({
    Key? key,
    required this.category,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap(widget.category);
      },
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        margin: const EdgeInsets.only(left: 8, right: 8),
        height: 30,
        decoration: BoxDecoration(
            color: widget.isSelected ? primaryColor : openColor,
            borderRadius: BorderRadius.circular(30)),
        child: Text(
          getNames(widget.category.name),
          style: TextStyle(
              color: widget.isSelected ? Colors.white : null, height: 1.3),
        ),
      ),
    );
  }
}
