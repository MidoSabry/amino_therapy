import 'package:amino_therapy/core/component/text/p_text.dart';
import 'package:amino_therapy/core/global/enums/global_enum.dart';
import 'package:flutter/material.dart';

class EditButton extends StatelessWidget {
  final VoidCallback onTap;
  const EditButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: const Color(0xFFF3CBA5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      icon: const Icon(Icons.edit_outlined, color: Colors.black, size: 18),
      label: const PText(
        title: 'Edit',
        size: PSize.text14,
        fontColor: Colors.black,
      ),
    );
  }
}

