import 'package:equatable/equatable.dart';
import 'package:intensivevr_pub/core/models/models.dart';
import 'package:meta/meta.dart';

@immutable
class UserDataState extends Equatable {
  final String username;
  final int points;
  final String hash;
  final List<Coupon> activeCoupons;
  final bool isDemoUser;
  final bool loaded;

  const UserDataState({
    @required this.username,
    @required this.points,
    @required this.hash,
    @required this.activeCoupons,
    @required this.isDemoUser,
    @required this.loaded,
  });

  factory UserDataState.initial({bool demo}) {
    return UserDataState(
        username: "User",
        points: -1,
        hash: "hash",
        activeCoupons: const [],
        isDemoUser: demo,
        loaded: false);
  }

  UserDataState copyWith({
    final String username,
    final int points,
    final String hash,
    final List<Coupon> activeCoupons,
  }) {
    return UserDataState(
      username: username ?? this.username,
      points: points ?? this.points,
      hash: hash ?? this.hash,
      activeCoupons: activeCoupons ?? this.activeCoupons,
      isDemoUser: isDemoUser ?? isDemoUser,
      loaded: loaded ?? loaded,
    );
  }

  @override
  List<Object> get props =>
      [username, points, hash, activeCoupons, isDemoUser, loaded];
}
class UserDataError extends UserDataState{}
