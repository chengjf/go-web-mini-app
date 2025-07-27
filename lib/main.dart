import 'package:flutter/material.dart';
import 'package:go_web_mini_app/common/langs/translation_service.dart';
import 'package:go_web_mini_app/common/routers/pages.dart';
import 'package:go_web_mini_app/common/store/store.dart';
import 'package:go_web_mini_app/common/style/style.dart';
import 'package:go_web_mini_app/common/utils/utils.dart';
import 'package:go_web_mini_app/global.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

Future<void> main() async {
  await Global.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (BuildContext context, Widget? child) {
        return RefreshConfiguration(
          headerBuilder: () => ClassicHeader(),
          footerBuilder: () => ClassicFooter(),
          hideFooterWhenNotFull: true,
          headerTriggerDistance: 80,
          maxOverScrollExtent: 100,
          footerTriggerDistance: 150,
          child: GetMaterialApp(
            title: 'News',
            theme: AppTheme.light,
            debugShowCheckedModeBanner: false,
            initialRoute: AppPages.INITIAL,
            getPages: AppPages.routes,
            builder: EasyLoading.init(),
            translations: TranslationService(),
            navigatorObservers: [AppPages.observer],
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: ConfigStore.to.languages,
            locale: ConfigStore.to.locale,
            fallbackLocale: Locale('en', 'US'),
            enableLog: true,
            logWriterCallback: Logger.write,
          ),
        );
      },
    );
  }
}
