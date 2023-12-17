import 'package:flutter/material.dart';
import 'package:youtube/Api.dart';
import 'package:youtube/model/Video.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

class Inicio extends StatefulWidget {
  late String pesquisa;
  Inicio(this.pesquisa);
  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  Future<List<Video>> _listarVideos(String pesquisa) async {
    Api api = Api();
    return api.pesquisar(pesquisa);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Video>>(
        future: _listarVideos(widget.pesquisa),
        builder: (context, snapshot) {
          var retorno;
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              retorno = Center(
                child: CircularProgressIndicator(),
              );
              break;
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasData) {
                return ListView.separated(
                    itemBuilder: (context, index) {
                      List<Video>? videos = snapshot.data;
                      Video video = videos![index];
                      return GestureDetector(
                        onTap: () {
                          FlutterYoutube.playYoutubeVideoById(
                              apiKey: CHAVE_YOUTUBE_API, videoId: video.id, autoPlay: true, fullScreen: true);
                        },
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(video.imagem))),
                            ),
                            ListTile(
                              title: Text(video.titulo),
                              subtitle: Text(video.descricao),
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => Divider(
                          height: 3,
                          color: Colors.red,
                        ),
                    itemCount: snapshot.data!.length);
              }
              break;
          }
          return retorno;
        });
  }
}
