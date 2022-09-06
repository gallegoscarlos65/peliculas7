import 'package:flutter/material.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:peliculas/screens/screens.dart';
import 'package:provider/provider.dart';

void main() => runApp(AppState());

  class AppState extends StatelessWidget {
    const AppState({Key? key}) : super(key: key);
  
    @override
    Widget build(BuildContext context) {
      //EL multiprovider es para multiplos providers por si se ocupa
      return MultiProvider(
        providers: [
          //lazy: false sirve para que tan pronto como el widget provider es llamado haga la inicializacion del mismo
          ChangeNotifierProvider(create: ( _ ) => MoviesProvider(), lazy: false,),
        ],
        child: MyApp(),);
    }
  }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas',
      initialRoute: 'home',
      routes: {
        'home': ( _ ) => HomeScreen(),
        'details': ( _ ) => DetailsScreen(),
      },
      theme: ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(
          color: Colors.indigo,
        )
      ),
    );
  }
}