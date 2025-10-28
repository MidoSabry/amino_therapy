import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/component/appbar/custom_appbar.dart';
import '../../../../core/data/constants/app_colors.dart';
import '../../../../core/global/state/base_state.dart';
import '../../data/service_model.dart';
import '../bloc/service_cubit.dart';
import '../widgets/category_chips_widget.dart';
import '../widgets/search_service_widget.dart';
import '../widgets/service_card_widget.dart';
import '../widgets/sort_dropdown_widget.dart';

class AllServicesScreen extends StatelessWidget {
  const AllServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ServicesCubit()..init(),
      child: BlocBuilder<ServicesCubit, BaseState>(
        builder: (context, state) {
          if (state is LoadedState<Map<String, dynamic>>) {
            final data = state.data!;
            final services = data['services'] as List<ServiceModel>;
            final selectedCategory = data['selectedCategory'] as String;
            final sortBy = data['sortBy'] as String;

            return Scaffold(
              backgroundColor: AppColors.backgroundScreens,
              appBar: CustomAppBar(
                title: 'Our Services',
                isCenterTitle: false,
                showBackButton: true,
                hasSubtitle: true,
                subtitle: 'Browse our complete range of beauty services',
              ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 16,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SearchServiceWidget(
                          onChanged: context.read<ServicesCubit>().updateSearch,
                        ),
                        SizedBox(height: 2.h),
                        CategoryChipsWidget(
                          selectedCategory: selectedCategory,
                          onSelect: context
                              .read<ServicesCubit>()
                              .selectCategory,
                        ),
                        const SizedBox(height: 16),
                        SortDropdown(
                          value: sortBy,
                          onChanged: (v) {
                            context.read<ServicesCubit>().changeSort(v);
                          },
                        ),
                        const SizedBox(height: 24),
                        services.isEmpty
                            ? Center(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 10.h),
                                  child: Text(
                                    'No services available',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(color: Colors.grey),
                                  ),
                                ),
                              )
                            : Column(
                                children: services
                                    .map((s) => ServiceCard(service: s))
                                    .toList(),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
