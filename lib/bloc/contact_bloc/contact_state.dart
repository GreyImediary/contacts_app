import 'package:contacts_service/contacts_service.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ContactState extends Equatable {
  final List<Object> _props;

  ContactState([this._props = const []]) : super();

  @override
  List<Object> get props => _props;
}

class InitialContactState extends ContactState {}

class ContactsChange extends ContactState {
  final List<Contact> contacts;

  ContactsChange(this.contacts)
      : assert(contacts != null),
        super([contacts]);
}
