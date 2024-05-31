import 'package:equatable/equatable.dart';

abstract class ReviewsEvent extends Equatable {
  const ReviewsEvent();

  @override
  List<Object?> get props => [];
}

class LoadTechnicianReviews extends ReviewsEvent {
  final int technicianId;

  const LoadTechnicianReviews({required this.technicianId});

  @override
  List<Object?> get props => [technicianId];
}

class PostReview extends ReviewsEvent {
  final int technicianId;
  final String review;
  final int rate;
  final int customerId;

  const PostReview({
    required this.technicianId,
    required this.review,
    required this.rate,
    required this.customerId,
  });

  @override
  List<Object?> get props => [technicianId, review, rate, customerId];
}

class UpdateReview extends ReviewsEvent {
  final Map<String, dynamic> updates;
  final int reviewId;
  final int technicianId;

  const UpdateReview({
    required this.updates,
    required this.reviewId,
    required this.technicianId,
  });

  @override
  List<Object?> get props => [updates, reviewId, technicianId];
}

class DeleteReview extends ReviewsEvent {
  final int reviewId;
  final int technicianId;

  const DeleteReview({
    required this.reviewId,
    required this.technicianId,
  });

  @override
  List<Object?> get props => [reviewId, technicianId];
}
