import 'package:flutter/widgets.dart';
import 'package:movie_app/common/constants/route_constants.dart';
import 'package:movie_app/presentation/journeys/home/home_screen.dart';
import 'package:movie_app/presentation/journeys/movie_detail/movie_detail_screen.dart';

import 'journeys/favorite/favorite_screen.dart';
import 'journeys/login/login_screen.dart';
import 'journeys/watch_video/watch_video_screen.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes(RouteSettings settings) => {
        RouteList.initial: (context) => LoginScreen(),
        RouteList.home: (context) => HomeScreen(),
        RouteList.movieDetail: (context) => MovieDetailScreen(
              movieDetailArguments: settings.arguments,
            ),
        RouteList.watchTrailer: (context) => WatchVideoScreen(
              watchVideoArguments: settings.arguments,
            ),
        RouteList.favorite: (context) => FavoriteScreen(),
      };
}
