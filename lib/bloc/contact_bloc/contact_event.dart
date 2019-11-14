import 'package:contacts_service/contacts_service.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ContactEvent extends Equatable {
  final List<Object> _props;

  ContactEvent([this._props = const []]);

  @override
  List<Object> get props => _props;
}

class InitContacts extends ContactEvent {}

class AddContact extends ContactEvent {
  final Contact contact;

  AddContact(this.contact)
      : assert(contact != null),
        super([contact]);
}

class DeleteContact extends ContactEvent {
  final Contact contact;

  DeleteContact(this.contact)
      : assert(contact != null),
        super([contact]);
}

class UpdateContact extends ContactEvent {
  final Contact contact;

  UpdateContact(this.contact)
      : assert(contact != null),
        super([contact]);
}
