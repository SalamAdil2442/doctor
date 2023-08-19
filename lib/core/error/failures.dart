import 'package:equatable/equatable.dart';
import 'package:tandrustito/core/error/failure_message_model.dart';

abstract class Failure extends Equatable {
  const Failure({required this.error});
  final FailureMessage error;
}

class ServerFailure extends Failure {
  const ServerFailure({required FailureMessage error}) : super(error: error);
  @override
  List<Object?> get props => [error];
}

class NetworkFailure extends Failure {
  const NetworkFailure({required FailureMessage error}) : super(error: error);

  @override
  List<Object?> get props => [FailureMessage];
}

class UnAuthFailure extends Failure {
  const UnAuthFailure({required FailureMessage error}) : super(error: error);

  @override
  List<Object?> get props => [error];
}

class ErrorFailure extends Failure {
  const ErrorFailure({required FailureMessage error}) : super(error: error);

  @override
  List<Object?> get props => [error];
}

class EmptyData extends Failure {
  const EmptyData({required FailureMessage error}) : super(error: error);

  @override
  List<Object?> get props => [error];
}
