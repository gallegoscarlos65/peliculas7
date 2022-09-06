import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';
import 'package:peliculas/widgets/widgets.dart';

//El key es una manera de identificar el widget en el arbol de widgets
class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // TODO: Cambiar luego por una instancia de movie
    // Los dos simbolos de ?? declaran que si todo lo anterior es nulo se le mandara otra cosa
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
    print(movie.title);

    return Scaffold(
      body: CustomScrollView(
        //Los slivers son ciertos widgets que tienen cierto funcionamiento programado cuando se hace scroll en el contenido del padre
        slivers: [
          _CustomAppBar(movie),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _PosterAndTitle(movie),
                _Overview(movie),
                _Overview(movie),
                _Overview(movie),
                _Overview(movie),
                _Overview(movie),
                CastingCards(movie.id),

                
                ]
            ))
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  //const _CustomAppBar({Key? key}) : super(key: key);

  final Movie movie;

  const _CustomAppBar(this.movie);


  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          child: Text(
            '${movie.title}',
            style: TextStyle(fontSize: 16),
          ),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'), 
          image: NetworkImage('${movie.fullBackdropPath}'),
          fit: BoxFit.cover,),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {

  final Movie movie;

  const _PosterAndTitle(this.movie);

  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;


    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'), 
              image: NetworkImage(movie.fullPosterImg),
              // width: 150,
              height: 150,
              width: 110,
              ),
          ),

          SizedBox(width: 20,),

          ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: size.width - 200),
            child: Column(
              //Para que quede alineado al inicio en este caso a la izquierda
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movie.title, style: textTheme.headline5, overflow: TextOverflow.ellipsis, maxLines: 2,),
          
                //Text(movie.title, style: textTheme.headline5, overflow: TextOverflow.ellipsis, maxLines: 2,),
                Text(movie.originalTitle, style: textTheme.subtitle2, overflow: TextOverflow.ellipsis, maxLines: 2,),
             
                Row(
                  children: [
                    Icon(Icons.star, size: 15, color: Colors.grey,),
                    SizedBox(width: 5,),
                    Text('${movie.voteAverage}', style: textTheme.caption,),
                  ],
                )
             ],
            ),
          )
        ],
      ),
    );
  }
}

//El overview es un simple contenedor en el cual va a tener un texto
class _Overview extends StatelessWidget {
  //const _Overview({Key? key}) : super(key: key);

  final Movie movie;

  const _Overview(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(movie.overview,
      textAlign: TextAlign.justify,
      style: Theme.of(context).textTheme.subtitle1),
    );
  }
}