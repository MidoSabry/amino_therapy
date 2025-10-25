import 'package:amino_therapy/core/component/text/p_text.dart';
import 'package:amino_therapy/core/global/enums/global_enum.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/data/constants/app_colors.dart';
import '../widgets/book_appointment_widget.dart';
import '../widgets/features_widget.dart';
import '../widgets/offer_card_widget.dart';
import '../widgets/products_widget.dart';
import '../widgets/promo_banner_widget.dart';
import '../widgets/search_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundScreens,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PText(
                  title: 'Welcome Back!',
                  size: PSize.text24,
                  fontColor: AppColors.black,
                  fontWeight: FontWeight.w800,
                ),
                PText(
                  title: 'Ready to look beautiful?',
                  size: PSize.text14,
                  fontColor: AppColors.grayBeautyColor,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 2.h),
                PromoBanner(),
                SizedBox(height: 2.h),
                SearchWidget(),
                SizedBox(height: 2.h),
                OfferCardWidget(),
                SizedBox(height: 2.h),
                FeaturesWidget(),
                SizedBox(height: 2.h),
                ProductsWidget(),
                SizedBox(height: 2.h),
                BookAppointmentWidget(),
                SizedBox(height: 1.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
