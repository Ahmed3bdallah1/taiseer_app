import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:taiseer/core/errors/failure.dart';
import 'package:taiseer/features/shared/verify/data/data_sources/verification_data_source.dart';
import 'package:taiseer/features/shared/verify/domain/repositories/verification_repo.dart';

class ForgetVerificationRepo extends VerificationRepo {
  final VerificationDataSource dataSource;
  @override
  final String sendTo;

  ForgetVerificationRepo({required this.dataSource, required this.sendTo});

  @override
  Future<Either<Failure, bool>> verify(String code) async {
    try {
      final res = await dataSource.verify(code, emailOrPhone: sendTo);
      return Right(res);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(GeneralError(e));
      }
    }
  }

  @override
  Future<Either<Failure, bool>> resend() async {
    return send();
  }

  @override
  Future<Either<Failure, bool>> send() async {
    try {
      final res = await dataSource.resend(emailOrPhone: sendTo);
      return Right(res);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(GeneralError(e));
      }
    }
  }

  @override
  String get title => "Forget Password";

  @override
  String get type => sendTo.isEmail ? "your email" : "your phone";
}

class CheckPhoneRepo extends VerificationRepo {
  final VerificationDataSource dataSource;
  @override
  final String sendTo;
  final Map<String, dynamic> data;

  CheckPhoneRepo(
      {required this.dataSource, required this.sendTo, required this.data});

  @override
  Future<Either<Failure, bool>> verify(String code) async {
    try {
      final res = await dataSource.verify(code, emailOrPhone: sendTo);
      return Right(res);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(GeneralError(e));
      }
    }
  }

  @override
  Future<Either<Failure, bool>> resend() async {
    return send();
  }

  @override
  Future<Either<Failure, bool>> send() async {
    try {
      final res = await dataSource.resend(emailOrPhone: sendTo);
      return Right(res);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(GeneralError(e));
      }
    }
  }

  @override
  String get title => "Forget Password";

  @override
  String get type => sendTo.isEmail ? "your email" : "your phone";
}
