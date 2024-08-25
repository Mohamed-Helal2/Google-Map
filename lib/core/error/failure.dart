import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class OfflineFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class UnDefinedCityFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class LocationServiceFailure extends Failure {
  @override
  List<Object?> get props => [];
}
class LocationPermissionFailure extends Failure {
  @override
  List<Object?> get props => [];
}