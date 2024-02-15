import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class OfflineError extends Failure {
  @override
  List<Object?> get props => [];
}

class ServerError extends Failure {
  @override
  List<Object?> get props => [];
}
class EmptyError extends Failure {
  @override
  List<Object?> get props => [];
}
