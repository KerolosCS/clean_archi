import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImp implements NetworkInfo {
  final InternetConnectionChecker conChecker;

  NetworkInfoImp(this.conChecker);
  @override
  Future<bool> get isConnected => conChecker.hasConnection ;
}
