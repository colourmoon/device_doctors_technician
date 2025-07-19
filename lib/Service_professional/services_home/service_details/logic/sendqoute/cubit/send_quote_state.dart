part of 'send_quote_cubit.dart';

class SendQuoteState extends Equatable {
  const SendQuoteState();

  @override
  List<Object> get props => [];
}

class SendQuoteInitial extends SendQuoteState {}

class SendQuoteloading extends SendQuoteState {}

class SendQuotesuccess extends SendQuoteState {}

class SendQuoteerror extends SendQuoteState {}

class AddQuoteloading extends SendQuoteState {}

class AddQuotesuccess extends SendQuoteState {}

class AddQuoteerror extends SendQuoteState {}
