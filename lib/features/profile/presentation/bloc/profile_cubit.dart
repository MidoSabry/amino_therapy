import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/global/state/base_state.dart';

class ProfileCubit extends Cubit<BaseState> {
  ProfileCubit()
      : super(const LoadedState<Map<String, dynamic>>({
          "isEdit": false,
          "name": "Sarah Johnson",
          "email": "ms259915@gmail.com",
          "phone": "01225699594",
        }));

  void toggleEditMode() {
    final current = (state as LoadedState<Map<String, dynamic>>).data!;
    emit(LoadedState<Map<String, dynamic>>({
      ...current,
      "isEdit": !(current["isEdit"] as bool),
    }));
  }

  void updateField(String key, String value) {
    final current = (state as LoadedState<Map<String, dynamic>>).data!;
    emit(LoadedState<Map<String, dynamic>>({
      ...current,
      key: value,
    }));
  }

  void cancelEdit() {
    final current = (state as LoadedState<Map<String, dynamic>>).data!;
    emit(LoadedState<Map<String, dynamic>>({
      ...current,
      "isEdit": false,
    }));
  }

  void saveChanges() {
    final current = (state as LoadedState<Map<String, dynamic>>).data!;
    // هنا ممكن تبعت داتا للسيرفر بعدين
    emit(LoadedState<Map<String, dynamic>>({
      ...current,
      "isEdit": false,
    }));
  }
}
