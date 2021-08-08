import 'package:flutter/material.dart';
import 'package:movie_app/presentation/themes/app_color.dart';
import 'package:wiredash/wiredash.dart';

class WiredashApp extends StatelessWidget {
  final navigatorKey;
  final Widget child;
  final String languageCode;

  const WiredashApp(
      {Key key,
      @required this.navigatorKey,
      @required this.child,
      @required this.languageCode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wiredash(
      projectId: 'movie-app-isy2ceu',
      secret: 'acg5dklafbagthz499mbk75zip3nuaf0lbjvntzc7gki6uf4',
      navigatorKey: navigatorKey,
      child: child,
      options: WiredashOptionsData(
          locale: Locale.fromSubtags(
        languageCode: languageCode,
      )),
      theme: WiredashThemeData(
          brightness: Brightness.dark,
          primaryColor: AppColor.royalBlue,
          secondaryColor: AppColor.violet,
          secondaryBackgroundColor: AppColor.vulcan,
          dividerColor: AppColor.vulcan),
    );
  }
}
