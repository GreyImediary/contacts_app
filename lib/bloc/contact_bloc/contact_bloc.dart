import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:contacts_service/contacts_service.dart';
import '../bloc.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  @override
  ContactState get initialState => InitialContactState();

  @override
  Stream<ContactState> mapEventToState(
    ContactEvent event,
  ) async* {

    if (event is InitContacts) {
      final contacts = await ContactsService.getContacts();
      yield ContactsChange(contacts.toList());
    } else if (event is AddContact) {
      await ContactsService.addContact(event.contact);

      final contacts = await ContactsService.getContacts();
      yield ContactsChange(contacts.toList());
    } else if (event is UpdateContact) {
      await ContactsService.updateContact(event.contact);

      final contacts = await ContactsService.getContacts();

      yield ContactsChange(contacts.toList());
    } else if (event is DeleteContact) {
      await ContactsService.deleteContact(event.contact);

      final contacts = await ContactsService.getContacts();

      yield ContactsChange(contacts.toList());
    }
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    print('Cont: $error');
  }
}
