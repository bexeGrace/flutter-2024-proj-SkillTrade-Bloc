import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:skill_trade/domain/models/review.dart';
import 'package:skill_trade/infrastructure/repositories/review_repository.dart';
import 'package:skill_trade/application/blocs/review_bloc.dart';
import 'package:skill_trade/presentation/events/review_event.dart';
import 'package:skill_trade/presentation/states/review_state.dart';

import 'review_bloc_test.mocks.dart';

@GenerateMocks([ReviewRepository])
void main() {
  late MockReviewRepository mockReviewRepository;
  late ReviewsBloc reviewsBloc;

  setUp(() {
    mockReviewRepository = MockReviewRepository();
  });

  tearDown(() {
    reviewsBloc.close();
  });

  group('ReviewsBloc', () {
    final reviews = [
      Review(
        id: 1,
        customer: 'cutomer',
        customerId: 1,
        rating: 5,
        comment: 'Great service!',
      ),
      Review(
        id: 1,
        customer: 'cutomer',
        customerId: 1,
        rating: 5,
        comment: 'Great service!',
      ),
    ];

    blocTest<ReviewsBloc, ReviewsState>(
      'emits [ReviewsLoading, ReviewsLoaded] when LoadTechnicianReviews event is added',
      setUp: () {
        when(mockReviewRepository.getTechnicianReviews(1)).thenAnswer((_) async => reviews);
      },
      build: () {
        reviewsBloc = ReviewsBloc(reviewRepository: mockReviewRepository);
        return reviewsBloc;
      },
      act: (bloc) => bloc.add(LoadTechnicianReviews(technicianId: 1)),
      expect: () => [ReviewsLoaded(reviews)],
    );

    blocTest<ReviewsBloc, ReviewsState>(
      'emits [ReviewsLoading, ReviewsError] when LoadTechnicianReviews event is added and an error occurs',
      setUp: () {
        when(mockReviewRepository.getTechnicianReviews(1)).thenThrow(Exception('Failed to load reviews'));
      },
      build: () {
        reviewsBloc = ReviewsBloc(reviewRepository: mockReviewRepository);
        return reviewsBloc;
      },
      act: (bloc) => bloc.add(LoadTechnicianReviews(technicianId: 1)),
      expect: () => [ReviewsError('Exception: Failed to load reviews')],
    );

    blocTest<ReviewsBloc, ReviewsState>(
      'emits [ReviewsLoading, ReviewsLoaded] when PostReview event is added and review is posted successfully',
      setUp: () {
        when(mockReviewRepository.postReview(1, 1, 5, 'Excellent service!')).thenAnswer((_) async => Future.value());
        when(mockReviewRepository.getTechnicianReviews(1)).thenAnswer((_) async => reviews);
      },
      build: () {
        reviewsBloc = ReviewsBloc(reviewRepository: mockReviewRepository);
        return reviewsBloc;
      },
      act: (bloc) => bloc.add(PostReview(technicianId: 1, customerId: 1, rate: 5, review: 'Excellent service!')),
      expect: () => [ReviewsLoaded(reviews)],
    );

    blocTest<ReviewsBloc, ReviewsState>(
      'emits [ReviewsLoading, ReviewsError] when PostReview event is added and an error occurs',
      setUp: () {
        when(mockReviewRepository.postReview(1, 1, 5, 'Excellent service!')).thenThrow(Exception('Failed to post review'));
      },
      build: () {
        reviewsBloc = ReviewsBloc(reviewRepository: mockReviewRepository);
        return reviewsBloc;
      },
      act: (bloc) => bloc.add(PostReview(technicianId: 1, customerId: 1, rate: 5, review: 'Excellent service!')),
      expect: () => [ReviewsError('Exception: Failed to post review')],
    );

    blocTest<ReviewsBloc, ReviewsState>(
      'emits [ReviewsLoading, ReviewsLoaded] when UpdateReview event is added and review is updated successfully',
      setUp: () {
        when(mockReviewRepository.updateReview(1, {'rate': 4})).thenAnswer((_) async => Future.value());
        when(mockReviewRepository.getTechnicianReviews(1)).thenAnswer((_) async => reviews);
      },
      build: () {
        reviewsBloc = ReviewsBloc(reviewRepository: mockReviewRepository);
        return reviewsBloc;
      },
      act: (bloc) => bloc.add(UpdateReview(reviewId: 1, technicianId: 1, updates: {'rate': 4})),
      expect: () => [ReviewsLoaded(reviews)],
    );

    blocTest<ReviewsBloc, ReviewsState>(
      'emits [ReviewsLoading, ReviewsError] when UpdateReview event is added and an error occurs',
      setUp: () {
        when(mockReviewRepository.updateReview(1, {'rate': 4})).thenThrow(Exception('Failed to update review'));
      },
      build: () {
        reviewsBloc = ReviewsBloc(reviewRepository: mockReviewRepository);
        return reviewsBloc;
      },
      act: (bloc) => bloc.add(UpdateReview(reviewId: 1, technicianId: 1, updates: {'rate': 4})),
      expect: () => [ReviewsError('Exception: Failed to update review')],
    );

    blocTest<ReviewsBloc, ReviewsState>(
      'emits [ReviewsLoading, ReviewsLoaded] when DeleteReview event is added and review is deleted successfully',
      setUp: () {
        when(mockReviewRepository.deleteReview(1)).thenAnswer((_) async => Future.value());
        when(mockReviewRepository.getTechnicianReviews(1)).thenAnswer((_) async => reviews);
      },
      build: () {
        reviewsBloc = ReviewsBloc(reviewRepository: mockReviewRepository);
        return reviewsBloc;
      },
      act: (bloc) => bloc.add(DeleteReview(reviewId: 1, technicianId: 1)),
      expect: () => [ReviewsLoaded(reviews)],
    );

    blocTest<ReviewsBloc, ReviewsState>(
      'emits [ReviewsLoading, ReviewsError] when DeleteReview event is added and an error occurs',
      setUp: () {
        when(mockReviewRepository.deleteReview(1)).thenThrow(Exception('Failed to delete review'));
      },
      build: () {
        reviewsBloc = ReviewsBloc(reviewRepository: mockReviewRepository);
        return reviewsBloc;
      },
      act: (bloc) => bloc.add(DeleteReview(reviewId: 1, technicianId: 1)),
      expect: () => [ReviewsError('Exception: Failed to delete review')],
    );
  });
}
