import 'package:googlemap/core/error/error_strings.dart';
import 'package:googlemap/core/error/failure.dart';

String mapFailutrToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return ErrorStrings.server_Message;
    case UnDefinedCityFailure:
      return ErrorStrings.unDefinedplace;
    case OfflineFailure:
      return ErrorStrings.offline_message;
    case LocationServiceFailure:
      return ErrorStrings.service_failure_message;
    case LocationPermissionFailure:
      return ErrorStrings.service_failure_message;
    case RoutesFailure:
      return ErrorStrings.routes_failure_message;
    default:
      return 'Un Expected Error';
  }
}
