import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/global/state/base_state.dart';
import '../../data/service_model.dart';

class ServicesCubit extends Cubit<BaseState> {
  ServicesCubit() : super(const InitialState());

  final List<ServiceModel> _allServices = [
    ServiceModel(
      name: "Facial",
      category: "Skincare",
      description: "Complete facial treatment with premium skincare products",
      price: 45,
      duration: "60 mins",
      rating: 4.9,
      reviewsCount: 98,
    ),
    ServiceModel(
      name: "Haircut",
      category: "Hair",
      description: "Professional haircut and styling service",
      price: 25,
      duration: "45 mins",
      rating: 4.7,
      reviewsCount: 120,
    ),
    ServiceModel(
      name: "Haircut",
      category: "Hair",
      description: "Professional haircut and styling service",
      price: 25,
      duration: "45 mins",
      rating: 4.7,
      reviewsCount: 120,
    ),
    ServiceModel(
      name: "Haircut",
      category: "Hair",
      description: "Professional haircut and styling service",
      price: 25,
      duration: "45 mins",
      rating: 4.7,
      reviewsCount: 120,
    ),
    ServiceModel(
      name: "Haircut",
      category: "Hair",
      description: "Professional haircut and styling service",
      price: 25,
      duration: "45 mins",
      rating: 4.7,
      reviewsCount: 120,
    ),
    // Add more...
  ];

  String _searchQuery = '';
  String _selectedCategory = 'All Services';
  String _sortBy = 'Rating (Highest)';

  void init() {
    _emitFiltered();
  }

  void updateSearch(String query) {
    _searchQuery = query;
    _emitFiltered();
  }

  void selectCategory(String category) {
    _selectedCategory = category;
    _emitFiltered();
  }

  void changeSort(String sort) {
    _sortBy = sort;
    _emitFiltered();
  }

  void _emitFiltered() {
    List<ServiceModel> filtered = _allServices.where((s) {
      final matchesCategory =
          _selectedCategory == 'All Services' ||
          s.category == _selectedCategory;
      final matchesSearch = s.name.toLowerCase().contains(
        _searchQuery.toLowerCase(),
      );
      return matchesCategory && matchesSearch;
    }).toList();

    if (_sortBy == 'Rating (Highest)') {
      filtered.sort((a, b) => b.rating.compareTo(a.rating));
    } else if (_sortBy == 'Price (Lowest)') {
      filtered.sort((a, b) => a.price.compareTo(b.price));
    }

    emit(
      LoadedState<Map<String, dynamic>>({
        'services': filtered,
        'selectedCategory': _selectedCategory,
        'sortBy': _sortBy,
        'searchQuery': _searchQuery,
      }),
    );
  }
}
