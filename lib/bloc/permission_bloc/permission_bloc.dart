import 'package:contacts_app/bloc/permission_bloc/permission_event.dart';
import 'package:contacts_app/bloc/permission_bloc/permission_state.dart';
import 'package:bloc/bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionBloc extends Bloc<PermissionEvent, PermissionState> {
  @override
  PermissionState get initialState => InitialPermissionState();

  @override
  Stream<PermissionState> mapEventToState(PermissionEvent event) async* {
    final permissionHandler = PermissionHandler();
    if (event is RequestPermission) {
      final permissionGroup = event.group;
      await permissionHandler.requestPermissions([permissionGroup]);
      final permissionStatus =
          await permissionHandler.checkPermissionStatus(permissionGroup);

      yield RequestResult(permissionStatus);
    }
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    print('Perm: $error');
  }
}
