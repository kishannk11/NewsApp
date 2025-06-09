import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/news_service.dart';
import 'news_event.dart';
import 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsService _newsService;

  NewsBloc(this._newsService) : super(NewsInitial()) {
    on<LoadNews>(_onLoadNews);
    on<RefreshNews>(_onRefreshNews);
  }

  Future<void> _onLoadNews(LoadNews event, Emitter<NewsState> emit) async {
    emit(NewsLoading());
    try {
      final articles = await _newsService.getTopHeadlines();
      emit(NewsLoaded(articles));
    } catch (e) {
      emit(NewsError(e.toString()));
    }
  }

  Future<void> _onRefreshNews(
    RefreshNews event,
    Emitter<NewsState> emit,
  ) async {
    try {
      final articles = await _newsService.getTopHeadlines();
      emit(NewsLoaded(articles));
    } catch (e) {
      emit(NewsError(e.toString()));
    }
  }
}
