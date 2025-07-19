part of 'cod_cash_cubit.dart';

class CodCashState {
  final bool dataLoaded;
  final String? currentBalance;
  final String? limit;

  final List<CodCashModel>? codCashList;
  final String payoutError;
  const CodCashState(
      {this.dataLoaded = false,
      required this.codCashList,
      this.currentBalance = "0",
      this.limit = "0",
      this.payoutError = ''});

  CodCashState copyWith(
      {bool? dataLoaded,
      List<CodCashModel>? codCashList,
      String? currentBalance,
      String? limit,
      String? payoutError}) {
    return CodCashState(
        dataLoaded: dataLoaded ?? this.dataLoaded,
        currentBalance: currentBalance ?? this.currentBalance,
        limit: limit ?? this.limit,
        codCashList: codCashList ?? this.codCashList,
        payoutError: payoutError ?? '');
  }
}
