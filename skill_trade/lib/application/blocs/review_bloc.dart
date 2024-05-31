import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_trade/infrastructure/repositories/review_repository.dart';
import 'package:skill_trade/presentation/events/review_event.dart';
import 'package:skill_trade/presentation/states/review_state.dart';

class ReviewsBloc extends Bloc<ReviewsEvent, ReviewsState> {
  final ReviewRepository reviewRepository;
  
  ReviewsBloc({required this.reviewRepository}) : super(ReviewsLoading()) {
    on<LoadTechnicianReviews>(_onLoadTechnicianReviews);
    on<PostReview>(_onPostReviews);
    on<UpdateReview>(_onUpdateReview);
    on<DeleteReview>(_onDeleteReview);
  }

  Future<void> _onLoadTechnicianReviews(LoadTechnicianReviews event, Emitter<ReviewsState> emit) async {
    try {
      final reviews = await reviewRepository.getTechnicianReviews(event.technicianId);
      emit(ReviewsLoaded(reviews));
    } catch (error) {
      emit(ReviewsError(error.toString()));
    }
  }

  Future<void> _onPostReviews(PostReview event, Emitter<ReviewsState> emit) async {
    try {
      await reviewRepository.postReview(event.technicianId, event.customerId, event.rate, event.review);
      add(LoadTechnicianReviews(technicianId: event.technicianId));
    } catch (error) {
      emit(ReviewsError(error.toString()));
    }
  }

  Future<void> _onUpdateReview(UpdateReview event, Emitter<ReviewsState> emit) async {
    try {
      await reviewRepository.updateReview(event.reviewId, event.updates);
      add(LoadTechnicianReviews(technicianId: event.technicianId));
    } catch (error) {
      emit(ReviewsError(error.toString()));
    }
  }

  Future<void> _onDeleteReview(DeleteReview event, Emitter<ReviewsState> emit) async {
    try {
      await reviewRepository.deleteReview(event.reviewId);
      add(LoadTechnicianReviews(technicianId: event.technicianId));
    } catch (error) {
      emit(ReviewsError(error.toString()));
    }
  }
}
