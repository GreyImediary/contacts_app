import 'package:contacts_app/bloc/bloc.dart';
import 'package:contacts_app/screen/add_edit_screen.dart';
import 'package:contacts_app/widget/main_list.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Contact contact = await Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddEditScreen(null)));

          if (contact != null) {
            BlocProvider.of<ContactBloc>(context).add(AddContact(contact));
          }
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(child: BlocBuilder<PermissionBloc, PermissionState>(
        builder: (_, state) {
          if (state is InitialPermissionState) {
            BlocProvider.of<PermissionBloc>(context)
                .add(RequestPermission(PermissionGroup.contacts));

            return initialList(context);
          }

          if (state is RequestResult) {
            final result = state.permissionStatus;
            if (result == PermissionStatus.granted) {
              return showContacts(context);
            }
          }

          return initialList(context);
        },
      )),
    );
  }
}
