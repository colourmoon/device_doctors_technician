part of 'cusomer_tips_cubit.dart';

class CusomerTipsState {
  final bool dataLoaded;
  final String? totalAmount;

  final List<TipsListModel>? tipsList;
  final String payoutError;
  const CusomerTipsState(
      {this.dataLoaded = false,
      required this.tipsList,
      this.totalAmount = "0",
      this.payoutError = ''});

  CusomerTipsState copyWith(
      {bool? dataLoaded,
      List<TipsListModel>? tipsList,
      String? totalAmount,
      String? payoutError}) {
    return CusomerTipsState(
        dataLoaded: dataLoaded ?? this.dataLoaded,
        totalAmount: totalAmount ?? this.totalAmount,
        tipsList: tipsList ?? this.tipsList,
        payoutError: payoutError ?? this.payoutError);
  }
}
