abstract class MyFormEvent {}

class AddFormEvent extends MyFormEvent {}

class RemoveFormEvent extends MyFormEvent {
  final int index;
  RemoveFormEvent(this.index);
}

class SubmitFormsEvent extends MyFormEvent {}
