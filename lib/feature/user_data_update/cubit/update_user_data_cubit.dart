import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:zoo_market/common/services/core_common_constant.dart';
import 'package:zoo_market/common/services/date_utils.dart';
import 'package:zoo_market/common/services/global_pattern_constant.dart';
import 'package:zoo_market/common/services/network/authorized_api_service.dart';
import 'package:zoo_market/di/di_locator.dart';

part 'update_user_data_state.dart';

class UpdateUserDataCubit extends Cubit<UpdateUserDataState> {
  UpdateUserDataCubit()
      : _authorizedApiService = sl(),
        super(UpdateUserDataInitial());

  final AuthorizedApiService _authorizedApiService;

  String _firstName = CoreConstant.empty;
  String _lastName = CoreConstant.empty;
  String _birthDay = CoreConstant.empty;
  String _phoneNumber = CoreConstant.empty;
  bool isMale = false;

  void enterFN(String value) {
    final state = _getCommonState();
    _firstName = value;
    emit(state.copyWith(
      fnError: CoreConstant.empty,
    ));
  }

  void enterLN(String value) {
    final state = _getCommonState();
    _lastName = value;
    emit(state.copyWith(
      lnError: CoreConstant.empty,
    ));
  }

  void enterBD(String value) {
    _birthDay = value;
    final state = _getCommonState();
    emit(state.copyWith(
      bdError: _birthDay.length == 10 ? CoreConstant.empty : 'Введите корректную дату ',
    ));
  }

  void enterPN (String value) {
    _phoneNumber = value;
    emit(_getCommonState());
  }

  void changeGander(bool value) {
    final state = _getCommonState();
    isMale = value;
    emit(state.copyWith(isMale: isMale));
  }

  Future<void> updateUserData({bool isRegState = false}) async {
    final state = _getCommonState();

    try {
      if (isRegState && isValid()) {
        emit(state.copyWith(isLoading: true));
        final data = {
          'phone_number' : _phoneNumber,
          'first_name' : _firstName,
          'last_name' : _lastName,
          'gender' : isMale ? 'male' : 'female',
          'date_of_birth' : convertDate(
            _birthDay.replaceAll('/', '-'),
            PatternContant.ddMMyy,
            PatternContant.yyyyMMdd,
          ),
        };
        final response = await _authorizedApiService.userUpdate(data);
        print(response);
        print(response.data);
        emit(SuccessUpdatedUserDataState());
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  bool isValid() {
    String fnError = CoreConstant.empty;
    String lnError = CoreConstant.empty;
    String bdError = CoreConstant.empty;
    bool valid = true;
    final state = _getCommonState();
    if (_firstName.isEmpty) {
      valid = false;
      fnError = 'Поля обязательные для заполнения';
    }
    if (_lastName.isEmpty) {
      valid = false;
      lnError = 'Поля обязательные для заполнения';
    }
    if (_birthDay.length != 10) {
      valid = false;
      bdError = 'Введите корректную дату ';
    }

    emit(state.copyWith(
      fnError: fnError,
      lnError: lnError,
      bdError: bdError,
    ));
    return valid;
  }


  CommonUpdateUserDataState _getCommonState() {
    if (state is CommonUpdateUserDataState) {
      return state as CommonUpdateUserDataState;
    }
    return CommonUpdateUserDataState(
      isLoading: false,
      isMale: false,
    );
  }
}
