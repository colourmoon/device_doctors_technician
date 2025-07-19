// import 'dart:async';
// import 'package:flutter/material.dart';

// class FormBloc {
//   final _formController = StreamController<List<MyForm>>();

//   Stream<List<MyForm>> get formStream => _formController.stream;

//   List<MyForm> forms = [];

//   void addForm() {
//     forms.add(MyForm());
//     _formController.sink.add(forms);
//   }

//   void removeForm(int index) {
//     forms.removeAt(index);
//     _formController.sink.add(forms);
//   }

//   void submitForms() {
//     for (var form in forms) {
//       form.submitForm();
//     }
//     List<jsonModel> formDataList = forms.map((form) => form.getFormData()).toList();
//     print('List of Form Data: $formDataList');
//   }

//   void dispose() {
//     _formController.close();
//   }
// }