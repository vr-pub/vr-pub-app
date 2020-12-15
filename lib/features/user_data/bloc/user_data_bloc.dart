import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:intensivevr_pub/core/models/models.dart';
import 'package:intensivevr_pub/core/services/data_repository.dart';
import 'package:intensivevr_pub/features/authentication/authentication.dart';

import 'bloc.dart';



class UserDataBloc extends Bloc<UserDataEvent, UserDataState> {
  final AuthenticationBloc authBloc;

  UserDataBloc(this.authBloc) : super(UserDataState.initial());

  @override
  Stream<UserDataState> mapEventToState(UserDataEvent event) async* {
    if (event is GetInitialUserData) {
      User user = await DataRepository.getUserData(authBloc);
      yield UserDataState(
          username: user.name, points: user.points, hash: user.hash);
    }else{
      int points = await DataRepository.getUserPoints(authBloc);
      yield state.copyWith(points: points);
    }
  }
}