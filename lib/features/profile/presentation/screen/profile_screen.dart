// import 'package:amino_therapy/features/profile/presentation/widgets/contact_info_widget.dart';
// import 'package:flutter/material.dart';
// import '../../../../core/component/appbar/custom_appbar.dart';
// import '../../../../core/data/constants/app_colors.dart';
// import '../widgets/buttons_widgets.dart';
// import '../widgets/edit_button_widget.dart';
// import '../widgets/loyalty_card_widget.dart';
// import '../widgets/profile_header_widget.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: AppColors.backgroundScreens,
//         appBar: CustomAppBar(
//           title: '  My Profile',
//           isCenterTitle: false,
//           showBackButton: false,
//           actions: [
//             Padding(padding: const EdgeInsets.all(8.0), child: EditButton()),
//           ],
//         ),
//         body:
//             // SingleChildScrollView(
//             //   child: Padding(
//             //     padding: const EdgeInsets.symmetric(horizontal: 16),
//             //     child: Column(
//             //       crossAxisAlignment: CrossAxisAlignment.start,
//             //       children: [
//             //         ProfileHeader(),
//             //         SizedBox(height: 2.h),
//             //         LoyaltyCardWidget(),
//             //         SizedBox(height: 2.h),
//             //         ContactInfo(),
//             //         SizedBox(height: 8.h),
//             //         ButtonsWidgets(),
//             //       ],
//             //     ),
//             //   ),
//             // ),
//             Column(
//               children: [
//                 // Scrollable content
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           ProfileHeader(),
//                           SizedBox(height: 20),
//                           LoyaltyCardWidget(),
//                           SizedBox(height: 20),
//                           ContactInfo(),
//                           SizedBox(height: 20),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),

//                 // Fixed button section at bottom
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 16,
//                     vertical: 16,
//                   ),
//                   child: ButtonsWidgets(isEdit: false),
//                 ),
//               ],
//             ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/component/appbar/custom_appbar.dart';
import '../../../../core/data/constants/app_colors.dart';
import '../bloc/profile_cubit.dart';
import '../widgets/buttons_widgets.dart';
import '../widgets/edit_button_widget.dart';
import '../widgets/loyalty_card_widget.dart';
import '../widgets/profile_header_widget.dart';
import '../widgets/contact_info_widget.dart';
import '../../../../core/global/state/base_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit(),
      child: BlocBuilder<ProfileCubit, BaseState>(
        builder: (context, state) {
          if (state is LoadedState<Map<String, dynamic>>) {
            final data = state.data!;
            final isEdit = data["isEdit"] as bool;

            return SafeArea(
              child: Scaffold(
                backgroundColor: AppColors.backgroundScreens,
                appBar: CustomAppBar(
                  title: '  My Profile',
                  isCenterTitle: false,
                  showBackButton: false,
                  actions: [
                    if (!isEdit)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: EditButton(
                          onTap: () => context.read<ProfileCubit>().toggleEditMode(),
                        ),
                      ),
                  ],
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ProfileHeader(
                                isEdit: isEdit,
                                name: data["name"],
                                onChanged: (value) => context.read<ProfileCubit>().updateField("name", value),
                              ),
                              const SizedBox(height: 20),
                              const LoyaltyCardWidget(),
                              const SizedBox(height: 20),
                              ContactInfo(
                                isEdit: isEdit,
                                email: data["email"],
                                phone: data["phone"],
                                onEmailChanged: (v) =>
                                    context.read<ProfileCubit>().updateField("email", v),
                                onPhoneChanged: (v) =>
                                    context.read<ProfileCubit>().updateField("phone", v),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      child: ButtonsWidgets(
                        isEdit: isEdit,
                        onSave: () => context.read<ProfileCubit>().saveChanges(),
                        onCancel: () => context.read<ProfileCubit>().cancelEdit(),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
