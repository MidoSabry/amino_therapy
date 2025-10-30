import 'package:amino_therapy/core/component/appbar/custom_appbar.dart';
import 'package:amino_therapy/core/component/text/p_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/data/constants/app_colors.dart';
import '../../../../core/global/enums/global_enum.dart';
import 'appointment_booked_sscreen.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  int currentStep = 0;

  DateTime? selectedDate;
  String? selectedTime;
  List<String> selectedServices = [];
  List<String> selectedProducts = [];

  final times = [
    '9:00 AM',
    '10:00 AM',
    '11:00 AM',
    '2:00 PM',
    '3:00 PM',
    '5:00 PM',
  ];
  final services = [
    {'name': 'Haircut', 'price': 25},
    {'name': 'Facial', 'price': 45},
    {'name': 'Massage', 'price': 60},
    {'name': 'Manicure', 'price': 20},
  ];
  final products = [
    {'name': 'Moisturizer', 'price': 35, 'inStock': true},
    {'name': 'Face Serum', 'price': 45, 'inStock': true},
    {'name': 'Lip Balm', 'price': 15, 'inStock': false},
    {'name': 'Face Mask', 'price': 28, 'inStock': true},
  ];

  void nextStep() {
    if (currentStep < 2) setState(() => currentStep++);
  }

  void previousStep() {
    if (currentStep > 0) setState(() => currentStep--);
  }

  bool get isNextEnabled {
    if (currentStep == 0) return selectedDate != null && selectedTime != null;
    if (currentStep == 1) return selectedServices.isNotEmpty;
    return true; // step 3 optional
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundScreens,
      appBar: CustomAppBar(
        title: 'Booking',
        isCenterTitle: true,
        showBackButton: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(height: 3.h),
            _buildProgressBar(),
            SizedBox(height: 4.h),
            Expanded(child: _buildStepContent()),
            const SizedBox(height: 10),
            Row(
              children: [
                if (currentStep > 0)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade300,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: previousStep,
                        child: const Text("Previous"),
                      ),
                    ),
                  ),
                if (currentStep > 0) const SizedBox(width: 10),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isNextEnabled
                            ? AppColors.primaryColor
                            : Colors.grey.shade400,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      // onPressed: isNextEnabled ? nextStep : null,
                      // onPressed: isNextEnabled
                      //     ? () {
                      //         if (currentStep == 2) {
                      //           setState(
                      //             () => currentStep = 3,
                      //           ); // instead of "Finish"
                      //         } else {
                      //           nextStep();
                      //         }
                      //       }
                      //     : null,
                      onPressed: isNextEnabled
                          ? () {
                              if (currentStep == 3) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        const AppointmentBookedScreen(),
                                  ),
                                ).then((value) {
                                  if (value == true) {
                                    // After it pops (after 5 sec), reset back to step 0
                                    setState(() {
                                      currentStep = 0;
                                      selectedDate = null;
                                      selectedTime = null;
                                      selectedServices.clear();
                                      selectedProducts.clear();
                                    });
                                  }
                                });
                              } else if (currentStep == 2) {
                                setState(() => currentStep = 3);
                              } else {
                                nextStep();
                              }
                            }
                          : null,
                      child: Text(
                        currentStep == 3
                            ? "Confirm Booking"
                            : currentStep == 2
                            ? "Finish"
                            : "Next",
                        style: TextStyle(
                          color: isNextEnabled ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        bool isActive = index <= currentStep;
        return Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: isActive
                  ? AppColors.primaryColor
                  : Colors.grey.shade300,
              child: Text(
                '${index + 1}',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            if (index < 2)
              Container(
                width:
                    MediaQuery.of(context).size.width *
                    0.05.w, // longer line (20% of screen width)
                height: 3,
                color: index < currentStep
                    ? AppColors.primaryColor
                    : Colors.grey.shade300,
              ),
          ],
        );
      }),
    );
  }

  Widget _buildStepContent() {
    switch (currentStep) {
      case 0:
        return _stepSelectDateTime();
      case 1:
        return _stepSelectServices();
      case 2:
        return _stepAddProducts();
      case 3:
        return _bookingSummary();
      default:
        return Container();
    }
  }

  Widget _stepSelectDateTime() {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const PText(
                title: "Select Date & Time",
                fontColor: AppColors.black,
                fontWeight: FontWeight.bold,
                size: PSize.text20,
              ),
              SizedBox(height: 2.h),
              const PText(
                title: "Choose Date",
                fontColor: AppColors.black,
                fontWeight: FontWeight.w700,
                size: PSize.text12,
              ),
              SizedBox(height: 1.h),
              InkWell(
                onTap: () async {
                  final now = DateTime.now();
                  final date = await showDatePicker(
                    context: context,
                    initialDate: selectedDate ?? now,
                    firstDate: now,
                    lastDate: DateTime(2030),
                  );
                  if (date != null) setState(() => selectedDate = date);
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      PText(
                        title: selectedDate != null
                            ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                            : "Select a date",
                        size: PSize.text16,
                      ),
                      const Spacer(),
                      Icon(
                        Icons.calendar_today,
                        color: AppColors.grayBeautyColor,
                        size: 16.sp,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 3.h),
              const PText(
                title: "Choose Time",
                fontColor: AppColors.black,
                fontWeight: FontWeight.w700,
                size: PSize.text12,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: times.map((time) {
                  final isSelected = selectedTime == time;
                  return GestureDetector(
                    onTap: () => setState(() => selectedTime = time),
                    child: Container(
                      // width: 40.w,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primaryColor.withOpacity(.9)
                            : AppColors.grayColor200,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        time,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _stepSelectServices() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PText(
            title: "Select Services",
            fontColor: AppColors.black,
            fontWeight: FontWeight.bold,
            size: PSize.text20,
          ),
          SizedBox(height: 2.h),
          const PText(
            title: "Choose at least one service",
            fontColor: AppColors.black,
            fontWeight: FontWeight.w700,
            size: PSize.text12,
          ),

          SizedBox(height: 2.h),
          ...services.map((service) {
            final name = service['name'] as String;
            final price = service['price'] as int;
            final isSelected = selectedServices.contains(name);
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    selectedServices.remove(name);
                  } else {
                    selectedServices.add(name);
                  }
                });
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.red.shade50
                      : AppColors.backgroundScreens,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? Colors.redAccent : Colors.grey.shade300,
                    width: 2,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "\$$price",
                          style: const TextStyle(color: Colors.redAccent),
                        ),
                      ],
                    ),
                    if (isSelected)
                      const Icon(Icons.check, color: Colors.redAccent),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _stepAddProducts() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PText(
            title: "Add Products (Optional)",
            fontColor: AppColors.black,
            fontWeight: FontWeight.bold,
            size: PSize.text20,
          ),
          SizedBox(height: 3.h),
          ...products.map((product) {
            final name = product['name'] as String;
            final price = product['price'] as int;
            final inStock = product['inStock'] as bool;
            final isSelected = selectedProducts.contains(name);
            return GestureDetector(
              onTap: inStock
                  ? () {
                      setState(() {
                        if (isSelected) {
                          selectedProducts.remove(name);
                        } else {
                          selectedProducts.add(name);
                        }
                      });
                    }
                  : null,
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: inStock
                      ? (isSelected
                            ? Colors.red.shade50
                            : AppColors.backgroundScreens)
                      : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: !inStock
                        ? Colors.grey.shade300
                        : (isSelected
                              ? Colors.redAccent
                              : Colors.grey.shade300),
                    width: 2,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          inStock ? "In Stock" : "Out of Stock",
                          style: TextStyle(
                            color: inStock ? Colors.green : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "\$$price",
                          style: TextStyle(
                            color: inStock ? Colors.redAccent : Colors.grey,
                          ),
                        ),
                        if (isSelected)
                          const Icon(Icons.check, color: Colors.redAccent),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _bookingSummary() {
    final total = _calculateTotal();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const PText(
          title: "Review Your Booking",
          fontColor: AppColors.black,
          fontWeight: FontWeight.bold,
          size: PSize.text20,
        ),

        SizedBox(height: 2.h),

        // Date & Time section
        Text(
          "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year} at $selectedTime",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 1.h),
        //Divider(),
        SizedBox(height: 1.h),

        // Services
        const PText(
          title: "Services",
          fontColor: AppColors.black,
          fontWeight: FontWeight.bold,
          size: PSize.text16,
        ),
        SizedBox(height: 1.h),
        ...selectedServices.map((name) {
          final price =
              services.firstWhere((e) => e['name'] == name)['price'] as int;
          return Column(children: [_priceRow(name, price)]);
        }),

        // Divider(),
        SizedBox(height: 2.h),

        // Products
        if (selectedProducts.isNotEmpty) ...[
          const PText(
            title: "Products",
            fontColor: AppColors.black,
            fontWeight: FontWeight.bold,
            size: PSize.text16,
          ),
          SizedBox(height: 1.h),
          ...selectedProducts.map((name) {
            final price =
                products.firstWhere((e) => e['name'] == name)['price'] as int;
            return _priceRow(name, price);
          }),
          const SizedBox(height: 16),
        ],

        // Total
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "\$$total",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),

        const Spacer(),
      ],
    );
  }

  Widget _priceRow(String name, int price) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name),
          Text("\$$price", style: const TextStyle(color: Colors.redAccent)),
        ],
      ),
    );
  }

  int _calculateTotal() {
    int serviceTotal = selectedServices.fold(
      0,
      (sum, name) =>
          sum + (services.firstWhere((e) => e['name'] == name)['price'] as int),
    );

    int productTotal = selectedProducts.fold(
      0,
      (sum, name) =>
          sum + (products.firstWhere((e) => e['name'] == name)['price'] as int),
    );

    return serviceTotal + productTotal;
  }
}
