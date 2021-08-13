import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:movie_app/data/data_sources/authentication_local_data_source.dart';
import 'package:movie_app/data/data_sources/authentication_remote_data_source.dart';
import 'package:movie_app/data/data_sources/language_local_data_source.dart';
import 'package:movie_app/data/data_sources/movie_local_data_source.dart';
import 'package:movie_app/data/repositories/app_repository_impl.dart';
import 'package:movie_app/data/repositories/authentication_repository_impl.dart';
import 'package:movie_app/domain/repositories/app_repository.dart';
import 'package:movie_app/domain/repositories/authentication_repository.dart';
import 'package:movie_app/domain/usecases/check_if_favorite_movie.dart';
import 'package:movie_app/domain/usecases/delete_favorite_movie.dart';
import 'package:movie_app/domain/usecases/get_cast.dart';
import 'package:movie_app/domain/usecases/get_favorite_movies.dart';
import 'package:movie_app/domain/usecases/get_movie_detail.dart';
import 'package:movie_app/domain/usecases/get_preferred_language.dart';
import 'package:movie_app/domain/usecases/get_videos.dart';
import 'package:movie_app/domain/usecases/save_movie.dart';
import 'package:movie_app/domain/usecases/search_movies.dart';
import 'package:movie_app/domain/usecases/update_language.dart';
import 'package:movie_app/presentation/blocs/cast/cast_bloc.dart';
import 'package:movie_app/presentation/blocs/favorite/favorite_bloc.dart';
import 'package:movie_app/presentation/blocs/language/language_bloc.dart';
import 'package:movie_app/presentation/blocs/loading/loading_bloc.dart';
import 'package:movie_app/presentation/blocs/login/login_bloc.dart';
import 'package:movie_app/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';
import 'package:movie_app/presentation/blocs/movie_carousel/movie_carousel_bloc.dart';
import 'package:movie_app/presentation/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:movie_app/presentation/blocs/movie_tabbed/movie_tabbed_bloc.dart';
import 'package:movie_app/presentation/blocs/search_movie/search_movie_bloc.dart';
import 'package:movie_app/presentation/blocs/videos/videos_bloc.dart';
import '../data/core/api_client.dart';
import '../data/data_sources/movie_remote_data_source.dart';
import '../data/repositories/movie_repository_impl.dart';
import '../domain/repositories/movie_repository.dart';
import '../domain/usecases/get_coming_soon.dart';
import '../domain/usecases/get_playing_now.dart';
import '../domain/usecases/get_popular.dart';
import '../domain/usecases/get_trending.dart';

final getItInstance = GetIt.I;

Future init() async {
  //SINGLETON INSTANCES

  getItInstance.registerLazySingleton<Client>(() => Client());

  getItInstance
      .registerLazySingleton<ApiClient>(() => ApiClient(getItInstance()));

  getItInstance.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(getItInstance()));

  getItInstance.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl());

  getItInstance.registerLazySingleton<LanguageLocalDataSource>(
      () => LanguageLocalDataSourceImpl());

  getItInstance.registerLazySingleton<AuthenticationRemoteDataSource>(
      () => AuthenticationRemoteDataSourceImpl(getItInstance()));

  getItInstance.registerLazySingleton<AuthenticationLocalDataSource>(
      () => AuthenticationLocalDataSourceImpl());

  getItInstance
      .registerLazySingleton<GetTrending>(() => GetTrending(getItInstance()));

  getItInstance
      .registerLazySingleton<GetPopular>(() => GetPopular(getItInstance()));

  getItInstance.registerLazySingleton<GetPlayingNow>(
      () => GetPlayingNow(getItInstance()));

  getItInstance.registerLazySingleton<GetComingSoon>(
      () => GetComingSoon(getItInstance()));

  getItInstance.registerLazySingleton<GetMovieDetail>(
      () => GetMovieDetail(getItInstance()));

  getItInstance.registerLazySingleton<GetCast>(() => GetCast(getItInstance()));

  getItInstance
      .registerLazySingleton<GetVideos>(() => GetVideos(getItInstance()));

  getItInstance
      .registerLazySingleton<SaveMovie>(() => SaveMovie(getItInstance()));

  getItInstance.registerLazySingleton<GetFavoriteMovies>(
      () => GetFavoriteMovies(getItInstance()));

  getItInstance.registerLazySingleton<DeleteFavoriteMovie>(
      () => DeleteFavoriteMovie(getItInstance()));

  getItInstance.registerLazySingleton<CheckIfFavoriteMovie>(
      () => CheckIfFavoriteMovie(getItInstance()));

  getItInstance.registerLazySingleton<UpdateLanguage>(
      () => UpdateLanguage(getItInstance()));

  getItInstance.registerLazySingleton<GetPreferredLanguage>(
      () => GetPreferredLanguage(getItInstance()));

  getItInstance
      .registerLazySingleton<SearchMovies>(() => SearchMovies(getItInstance()));

  getItInstance.registerLazySingleton<MovieRepository>(
      () => MovieRepositoryImpl(getItInstance(), getItInstance()));

  getItInstance.registerLazySingleton<AppRepository>(
      () => AppRepositoryImpl(getItInstance()));

  getItInstance.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(getItInstance(), getItInstance()));

  // FACTORY INSTANCES

  getItInstance.registerFactory(() => MovieBackdropBloc());

  getItInstance.registerFactory(
    () => MovieCarouselBloc(
      loadingBloc: getItInstance(),
      getTrending: getItInstance(),
      movieBackdropBloc: getItInstance(),
    ),
  );

  getItInstance.registerFactory(
    () => MovieTabbedBloc(
      getPopular: getItInstance(),
      getComingSoon: getItInstance(),
      getPlayingNow: getItInstance(),
    ),
  );

  getItInstance.registerFactory(
    () => MovieDetailBloc(
      loadingBloc: getItInstance(),
        getMovieDetail: getItInstance(),
        castBloc: getItInstance(),
        videosBloc: getItInstance(),
        favoriteBloc: getItInstance()),
  );

  getItInstance.registerFactory(
    () => CastBloc(
      getCast: getItInstance(),
    ),
  );

  getItInstance.registerFactory(
    () => VideosBloc(
      getVideos: getItInstance(),
    ),
  );

  getItInstance.registerFactory(
    () => SearchMovieBloc(
      loadingBloc: getItInstance(),
      searchMovies: getItInstance(),
    ),
  );

  getItInstance.registerSingleton<LanguageBloc>(LanguageBloc(
    updateLanguage: getItInstance(),
    getPreferredLanguage: getItInstance(),
  ));

  getItInstance.registerFactory(() => FavoriteBloc(
      saveMovie: getItInstance(),
      getFavoriteMovies: getItInstance(),
      deleteFavoriteMovie: getItInstance(),
      checkIfFavoriteMovie: getItInstance()));

  getItInstance.registerFactory(() => LoginBloc(
        loginUser: getItInstance(),
        logoutUser: getItInstance(),
        loadingBloc: getItInstance(),
      ));

  getItInstance.registerSingleton<LoadingBloc>(LoadingBloc());
}
