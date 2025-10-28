import 'package:flutter/material.dart';
import '../../../../core/component/custom_drop_down/p_drop_down.dart';

class SortDropdown extends StatelessWidget {
  final String value;
  final ValueChanged<String> onChanged;

  const SortDropdown({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    // Convert your string options into maps for PDropDown
    final List<Map<String, dynamic>> options = [
      {"label": "Rating (Highest)", "value": "Rating (Highest)"},
      {"label": "Price (Lowest)", "value": "Price (Lowest)"},
    ];

    // Find the currently selected item (matching by "value")
    final currentOption = options.firstWhere(
      (o) => o["value"] == value,
      orElse: () => options.first,
    );

    return PDropDown(
      label: 'Sort By',
      options: options,
      initialValue: currentOption,
      onChange: (selected) {
        if (selected != null) {
          onChanged(selected["value"]);
        }
      },
    );
  }
}
