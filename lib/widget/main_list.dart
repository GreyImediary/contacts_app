import 'package:contacts_app/bloc/bloc.dart';
import 'package:contacts_app/bloc/permission_bloc/permission_bloc.dart';
import 'package:contacts_app/bloc/permission_bloc/permission_event.dart';
import 'package:contacts_app/screen/add_edit_screen.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

Widget initialList(BuildContext context) => Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Enable contacts, please",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 8),
          ),
          FlatButton(
              child: Text("ALLOW"),
              textTheme: ButtonTextTheme.accent,
              onPressed: () {
                BlocProvider.of<PermissionBloc>(context)
                    .add(RequestPermission(PermissionGroup.contacts));
              })
        ],
      ),
    );

Widget showContacts(BuildContext context) =>
    BlocBuilder<ContactBloc, ContactState>(builder: (_, state) {
      if (state is InitialContactState) {
        BlocProvider.of<ContactBloc>(context).add(InitContacts());
      } else if (state is ContactsChange) {
        final contacts = state.contacts;

        return ListView.separated(
            itemCount: contacts.length,
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemBuilder: (context, index) {
              final contact = contacts[index];

              return ListTile(
                title: Text(contact.givenName ?? 'Empty name'),
                subtitle: Text(contact.familyName ?? "Empty surname"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () async {
                          Contact updatedContact = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AddEditScreen(contact)));
                          if (updatedContact != null) {
                            contact.givenName = updatedContact.givenName;
                            contact.familyName = updatedContact.familyName;
                            contact.middleName = updatedContact.middleName;
                            contact.phones = updatedContact.phones;
                            contact.emails = updatedContact.emails;
                            BlocProvider.of<ContactBloc>(context)
                                .add(UpdateContact(contact));
                          }
                        }),
                    IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          BlocProvider.of<ContactBloc>(context)
                              .add(DeleteContact(contact));
                        }),
                  ],
                ),
              );
            });
      }
      return Center(
        child: CircularProgressIndicator(),
      );
    });
