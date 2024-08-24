  import 'package:googlemap/core/error/error_strings.dart';
import 'package:googlemap/core/error/failure.dart';

String mapFailutrToMessage(Failure failure) {
    print("t ----${failure.runtimeType}");
    switch (failure.runtimeType) {
      case ServerFailure:
        return ErrorStrings.server_Message;
      case UnDefinedCityFailure:
        return ErrorStrings.unDefinedplace;
      case OfflineFailure:
        return ErrorStrings.offline_message;
      default:
        return 'Un Expected Error';
    }
  }