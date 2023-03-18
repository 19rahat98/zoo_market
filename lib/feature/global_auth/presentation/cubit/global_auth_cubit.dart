import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:zoo_market/common/services/core_common_constant.dart';
import 'package:zoo_market/common/services/network/authorized_api_service.dart';
import 'package:zoo_market/di/di_locator.dart';
import 'package:zoo_market/feature/sign_in/data/repository/global_personal_secure_data_repository.dart';
import 'package:zoo_market/feature/sign_in/data/user_data_entity.dart';

part 'global_auth_state.dart';

class GlobalAuthCubit extends Cubit<GlobalAuthState> {
  GlobalAuthCubit()
      : _authorizedApiService = sl(),
        _secureDataRepository = sl(),
        super(GlobalAuthInitial());

  final AuthorizedApiService _authorizedApiService;
  final GlobalPersonalSecureDataRepository _secureDataRepository;

  Future<void> getUserData() async {
    try {
      final token = await _secureDataRepository.accessToken;
      if (token?.isNotEmpty ?? false) {
        final response = await _authorizedApiService.getUsersMe();
        final userData = UserDataEntity.fromJson(response.data);
        if (userData.isFill ?? false) {
          emit(SuccessAuthState(userData));
        } else {
          emit(CompleteRegistrationState(true, ''));
        }
      } else {
        emit(LogOutState());
      }
    } catch (e) {
      emit(LogOutState());
    }
  }

  Future<void> logOut() async {
    final refreshToken = await _secureDataRepository.refreshToken;
    await _authorizedApiService.logOut(refreshToken ?? CoreConstant.empty);
    _secureDataRepository
      ..removeAccessToken()
      ..removeRefreshToken();
    emit(LogOutState());
  }

  void setUpdateUserData(String phoneNumber, {bool isCreatedOnDb = true, String? uid}) {
    emit(
      CompleteRegistrationState(
        isCreatedOnDb,
        phoneNumber,
        uid: uid,
      ),
    );
  }
}
