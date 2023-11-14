import 'package:app/modules/home/repository/poke_news.service.dart';
 
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(NewsInitial())  {
    on<NewsEvent>((event, emit)async {
    
    print('0000000000000000000000000');
    dynamic newsData = await PokeNewsService().fetchNews();

    // print(newsData.runtimeType);
    // print(newsData['news']);
    emit(NewsLoadedSuccessfully(newsList: newsData['news']));
    });
  }
}
