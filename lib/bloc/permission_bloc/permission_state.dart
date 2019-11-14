import 'package:equatable/equatable.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionState extends Equatable {
  final List<Object> _props;

  PermissionState([this._props = const []]);

  @override
  List<Object> get props => _props;
}

class InitialPermissionState extends PermissionState {}

class RequestResult extends PermissionState {
  final PermissionStatus permissionStatus;

  RequestResult(this.permissionStatus)
      : assert(permissionStatus != null),
        super([permissionStatus]);
}
