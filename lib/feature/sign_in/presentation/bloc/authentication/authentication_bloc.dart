import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoo_market/common/services/core_common_constant.dart';
import 'package:zoo_market/common/services/network/unauthorized_api_service.dart';
import 'package:zoo_market/di/di_locator.dart';
import 'package:zoo_market/feature/sign_in/data/register_entity.dart';
import 'package:zoo_market/feature/sign_in/data/repository/global_personal_secure_data_repository.dart';

import 'blocs.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

class AuthBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthBloc()
      : _personalSecureDataRepository = sl(),
        _apiService = sl(),
        super(InitialAuthenticationState());

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GlobalPersonalSecureDataRepository _personalSecureDataRepository;
  final UnauthorizedApiService _apiService;

  String? token;

  @override
  Stream<AuthenticationState> mapEventToState(event) async* {
    if (event is LoggedIn) {
      yield SingInStart();
      try {
        await _firebaseAuth.signInWithCredential(event.credential);
        token = await _firebaseAuth.currentUser!.getIdToken();
        _personalSecureDataRepository.setAccessToken(token!);
        yield CredentialSuccess(token: token!);
      } catch (error) {
        yield AuthenticationFail(errorMessage: error.hashCode);
      }
    }

    if (event is LogOut) {
      try {
        await _firebaseAuth.signOut();
        _firebaseAuth.authStateChanges();
        yield AuthenticationFail();
      } catch (error) {
        yield AuthenticationFail(errorMessage: error.hashCode);
      }
    }

    if (event is SignToken) {
      try {
        final response = await _apiService.checkUserStatus(token!);
        final data = RegisterEntity.fromJson(response.data);
        if (data.status ?? false) {
          _personalSecureDataRepository
            ..setAccessToken(data.tokens?.access ?? CoreConstant.empty)
            ..setRefreshToken(data.tokens?.refresh ?? CoreConstant.empty);
          yield LoginSuccessState();
        } else {
          yield SetUserDataState(
            hasUser: false,
            uid: token,
          );
        }
      } catch (error) {
        yield AuthenticationFail(errorMessage: error.hashCode);
      }
    }
  }
}
