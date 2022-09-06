import 'package:flutter/material.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:peliculas/search/search_delegate.dart';
import 'package:peliculas/widgets/widgets.dart';
import 'package:provider/provider.dart';

//El key es una manera de identificar el widget en el arbol de widgets
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    /* <MoviesProvider>, busca en el arbol de widgets la primer instancia que encuentre de Movies provider, en caso de
       no encontrar ninguna va a crear alguna nueva siempre y cuando en el multiprovider se tenga definida 
    */

    //listen: true, le dice que le redibuje cuando hay algun cambio
    final moviesProvider = Provider.of<MoviesProvider>(context);

    print(moviesProvider.onDisplayMovies);

    return Scaffold(
      appBar: AppBar(
        title: Text("Peliculas en cine"),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => showSearch(context: context, delegate: MovieSearchDelegate()),
            icon: Icon(Icons.search_outlined)
            ), 
        ],
        
      ),
      body: SingleChildScrollView(
        child: Column(
      children: [
        //Tarjetas principales
        CardSwiper(movies: moviesProvider.onDisplayMovies),

        //Slider de películas
        MovieSlider(
          movies: moviesProvider.popularMovies,
          title: 'Populares',
          onNextPage: () => moviesProvider.getPopularMovies(),
          ),

        // TODO: CardSwiper

        //Listado horizontal de peliculas

      ]
    ),
      )
    );
  }
}