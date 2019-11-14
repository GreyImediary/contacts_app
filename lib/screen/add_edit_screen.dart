import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AddEditScreen extends StatefulWidget {
  Contact contact;

  AddEditScreen(this.contact);

  @override
  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  FocusNode _nameFocus;
  FocusNode _surnameFocus;
  FocusNode _patronymicFocus;
  FocusNode _phoneFocus;
  FocusNode _emailFocus;

  String _name;
  String _surname;
  String _patronymic;
  String _phone;
  String _email;

  @override
  void initState() {
    _nameFocus = FocusNode();
    _surnameFocus = FocusNode();
    _patronymicFocus = FocusNode();
    _phoneFocus = FocusNode();
    _emailFocus = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _nameFocus.dispose();
    _surnameFocus.dispose();
    _patronymicFocus.dispose();
    _phoneFocus.dispose();
    _emailFocus.dispose();
    widget.contact = null;
    _formKey = null;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
              widget.contact == null ? "Создание контакта" : "Редактирование"),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.check),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    final contact = Contact(
                        givenName: _name,
                        familyName: _surname,
                        middleName: _patronymic,
                        phones: [Item(value: _phone)],
                        emails: [Item(value: _email)]);


                    Navigator.pop(context, contact);
                  }
                })
          ],
        ),
        body: SafeArea(
            child: Center(
          child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      autofocus: true,
                      focusNode: _nameFocus,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please, enter the name';
                        }

                        return null;
                      },
                      initialValue: widget.contact?.givenName ?? '',
                      decoration: InputDecoration(
                          labelText: 'Name', border: OutlineInputBorder()),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (value) {
                        _focusNextTextField(context, _nameFocus, _surnameFocus);
                        _formKey.currentState.validate();
                      },
                      onSaved: (value) {
                        _name = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      focusNode: _surnameFocus,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please, enter the surname';
                        }

                        return null;
                      },
                      initialValue: widget.contact?.familyName ?? '',
                      decoration: InputDecoration(
                          labelText: 'Surname', border: OutlineInputBorder()),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (value) {
                        _focusNextTextField(
                            context, _surnameFocus, _patronymicFocus);
                        _formKey.currentState.validate();
                      },
                      onSaved: (value) {
                        _surname = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      focusNode: _patronymicFocus,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please, enter the patronymic';
                        }

                        return null;
                      },
                      initialValue: widget.contact?.middleName ?? '',
                      decoration: InputDecoration(
                          labelText: 'Patronymic',
                          border: OutlineInputBorder()),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (value) {
                        _focusNextTextField(
                            context, _patronymicFocus, _phoneFocus);
                        _formKey.currentState.validate();
                      },
                      onSaved: (value) {
                        _patronymic = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      focusNode: _phoneFocus,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please, enter the phone';
                        }

                        return null;
                      },
                      initialValue: widget.contact?.phones != null &&
                              widget.contact.phones.isNotEmpty
                          ? widget.contact.phones.toList()[0].value
                          : '',
                      inputFormatters: [
                        new MaskTextInputFormatter(mask: '+# (###) ###-##-##'),
                      ],
                      decoration: InputDecoration(
                          hintText: '+1 (234) 567-89-00',
                          labelText: 'Phone',
                          border: OutlineInputBorder()),
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (value) {
                        _focusNextTextField(context, _phoneFocus, _emailFocus);
                        _formKey.currentState.validate();
                      },
                      onSaved: (value) {
                        _phone = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      focusNode: _emailFocus,
                      validator: (value) {
                        final reg = RegExp(r'[a-zA-Z]*@[a-zA-Z]*.[a-zA-Z]*');
                        if (value.isEmpty) {
                          return 'Please, enter the email';
                        }

                        if (!reg.hasMatch(value)) {
                          return 'Wrong email form';
                        }

                        return null;
                      },
                      initialValue: widget.contact?.emails != null &&
                              widget.contact.emails.isNotEmpty
                          ? widget.contact.emails.toList()[0].value
                          : '',
                      decoration: InputDecoration(
                          hintText: 'example@mail.com',
                          labelText: 'Email',
                          border: OutlineInputBorder()),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (value) {
                        _formKey.currentState.validate();
                      },
                      onSaved: (value) {
                        _email = value;
                      },
                    ),
                  ),
                ]),
              )),
        )));
  }

  _focusNextTextField(
      BuildContext context, FocusNode oldFocus, FocusNode newFocus) {
    oldFocus.unfocus();
    FocusScope.of(context).requestFocus(newFocus);
  }
}
