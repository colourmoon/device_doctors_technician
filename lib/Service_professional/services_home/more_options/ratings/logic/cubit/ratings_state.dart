part of 'ratings_cubit.dart';

class RatingsState {
  final bool dataLoaded;
  final String? averageRating;
  final List<RatingReviewsModel>? ratingsList;
  final String payoutError;
  const RatingsState(
      {this.dataLoaded = false,
      required this.ratingsList,
      this.averageRating = "0",
      this.payoutError = ''});

  RatingsState copyWith(
      {bool? dataLoaded,
      List<RatingReviewsModel>? ratingsList,
      String? averageRating,
      String? payoutError}) {
    return RatingsState(
        dataLoaded: dataLoaded ?? this.dataLoaded,
        averageRating: averageRating ?? this.averageRating,
        ratingsList: ratingsList ?? this.ratingsList,
        payoutError: payoutError ?? '');
  }
}
