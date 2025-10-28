import 'package:flutter/material.dart';

class CategoryChipsWidget extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onSelect;

  const CategoryChipsWidget({
    required this.selectedCategory,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final categories = [
      'All Services',
      'Hair',
      'Skincare',
      'Nails',
      'Wellness',
      'Hair Removal'
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: categories.map((c) {
        final isSelected = c == selectedCategory;
        return ChoiceChip(
          label: Text(c),
          selected: isSelected,
          onSelected: (_) => onSelect(c),
          selectedColor: Colors.redAccent,
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
          ),
        );
      }).toList(),
    );
  }
}
