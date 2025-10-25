import 'package:amino_therapy/core/component/text/p_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/data/constants/app_colors.dart';
import '../../../../core/global/enums/global_enum.dart';

class FeaturesWidget extends StatelessWidget {
  const FeaturesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> services = [
      {
        "emoji": "✂️",
        "name": "Haircut",
        "price": "\$25",
        "color": Color(0xffffe8f5),
      },
      {
        "emoji": "🧖‍♀️",
        "name": "Facial",
        "price": "\$45",
        "color": Color(0xffe3f1ff),
      },
      {
        "emoji": "💆‍♀️",
        "name": "Massage",
        "price": "\$60",
        "color": Color(0xfff2e9ff),
      },
      {
        "emoji": "💅",
        "name": "Manicure",
        "price": "\$20",
        "color": Color(0xffffe9ed),
      },
    ];
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PText(
              title: "Featured Services",
              size: PSize.text18,
              fontColor: AppColors.black,
              fontWeight: FontWeight.w700,
            ),
            PText(
              title: "View All",
              fontColor: AppColors.primaryColor,
              size: PSize.text13,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
        SizedBox(height: 2.h),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: .16.h,
          ),
          itemCount: services.length,
          itemBuilder: (_, index) {
            final item = services[index];
            return Container(
              decoration: BoxDecoration(
                color: item["color"] as Color,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item["emoji"]!, style: TextStyle(fontSize: 30)),
                  // const Spacer(),
                  const SizedBox(height: 4),
                  Text(
                    item["name"]!,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item["price"]!,
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(Icons.chevron_right, size: 20),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
