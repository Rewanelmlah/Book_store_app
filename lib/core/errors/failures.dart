import 'package:dio/dio.dart';

abstract class Failure {
  final String errMesaage;

  const Failure(this.errMesaage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errMesaage);

  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection Timeout with ApiService');
      case DioExceptionType.sendTimeout:
        return ServerFailure('Send Timeout with ApiService');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive Timeout with ApiService');
      case DioExceptionType.badCertificate:
        return ServerFailure('Bad Certificate with ApiService');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
            dioError.response!.statusCode!, dioError.response!.data);
      case DioExceptionType.cancel:
        return ServerFailure('Request to ApiServer Was canceld');
      case DioExceptionType.connectionError:
        return ServerFailure('Connection Error with ApiService');
      case DioExceptionType.unknown:
        if (dioError.message!.contains('SocketException')) {
          return ServerFailure('No internet Connection');
        }
        return ServerFailure('Unexpected error, please try again');

      default:
        return ServerFailure('Opps there was an error,please try again');
    }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(response['error']['message']);
    } else if (statusCode == 404) {
      return ServerFailure('Your request not found , Please try later!');
    } else if (statusCode == 500) {
      return ServerFailure('Internal server error , Please try later');
    } else {
      return ServerFailure('Opps there was an error,please try again');
    }
  }
}
