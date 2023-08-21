import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marooooooofirebaseproject2/layouts/social_app/cubit/cubit.dart';
import 'package:marooooooofirebaseproject2/layouts/social_app/cubit/states.dart';
import 'package:marooooooofirebaseproject2/layouts/social_app/social_layout.dart';
import 'package:marooooooofirebaseproject2/modules/social_app/social_login_screen/social_login_screen.dart';
import 'package:marooooooofirebaseproject2/shared/bloc_Observer.dart';
import 'package:marooooooofirebaseproject2/shared/componantes/componantes.dart';
import 'package:marooooooofirebaseproject2/shared/componantes/constants.dart';
import 'package:marooooooofirebaseproject2/shared/cubit/cubit.dart';
import 'package:marooooooofirebaseproject2/shared/cubit/states.dart';
import 'package:marooooooofirebaseproject2/shared/network/local/cache_helper.dart';
import 'package:marooooooofirebaseproject2/shared/styles/themes.dart';


Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async
{
  print('on background message');
  print(message.data.toString());

  showToast(text: 'on background message', state: ToastStates.SUCCESS,);
}

void main() async {
  // بيتأكد ان كل حاجه هنا في الميثود خلصت و بعدين يتفح الابلكيشن
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  var token = await FirebaseMessaging.instance.getToken();

  print(token);


  // foreground fcm
  FirebaseMessaging.onMessage.listen((event)
  {
    print('on message');
    print(event.data.toString());

    showToast(text: 'on message', state: ToastStates.SUCCESS,);
  });

  // when click on notification to open app
  FirebaseMessaging.onMessageOpenedApp.listen((event)
  {
    print('on message opened app');
    print(event.data.toString());

    showToast(text: 'on message opened app', state: ToastStates.SUCCESS,);
  });

  // background fcm
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  Bloc.observer = MyBlocObserver();

  await CacheHelper.init();

  //bool isDark = CacheHelper.getData(key: 'isDark');

  Widget widget;

  //bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  //token = CacheHelper.getData(key: 'token');

  uId = CacheHelper.getData(key: 'uId');

  // if(onBoarding != null)
  // {
  //   if(token != null) widget = ShopLayout();
  //   else widget = ShopLoginScreen();
  // } else
  //   {
  //     widget = OnBoardingScreen();
  //   }

  if(uId != null)
  {
    widget = SocialLayout();
  } else
  {
    widget = SocialLoginScreen();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
}

// Stateless
// Stateful

// class MyApp

class MyApp extends StatelessWidget
{
  // constructor
  // build

  final Widget startWidget;

  const MyApp({super.key,
    required this.startWidget,
  });

  @override
  Widget build(BuildContext context)
  {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => SocialCubit()..getUserData()..getPosts()..getUsers(),
        ),
      ],
      child: BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}

// ./gradlew signingReport