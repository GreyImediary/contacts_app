import 'package:equatable/equatable.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionEvent extends Equatable {
  final List<Object> _props;

  PermissionEvent([this._props = const []]);

  @override
  List<Object> get props => _props;
}

class RequestPermission extends PermissionEvent {
  final PermissionGroup group;

  RequestPermission(this.group)
      : assert(group != null),
        super([group]);
}
