part of 'news_bloc.dart';

@immutable
sealed class NewsState {}

final class NewsInitial extends NewsState {}
final class NewsLoadedSuccessfully extends NewsState {
    final List  newsList;
  NewsLoadedSuccessfully({ required this.newsList});
}
final class LoadingFailed extends NewsState {}


