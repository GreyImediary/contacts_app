import 'package:contacts_app/bloc/bloc.dart';
import 'package:contacts_app/bloc/permission_bloc/permission_bloc.dart';
import 'package:contacts_app/screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contacts app',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: MultiBlocProvider(
          providers: [
            BlocProvider<PermissionBloc>(
              builder: (BuildContext context) => PermissionBloc(),
            ),

            BlocProvider<ContactBloc>(
              builder: (BuildContext context) => ContactBloc(),
            )
          ],
          child: MainScreen()
      ),
    );
  }
}