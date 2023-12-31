import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          close(context, "");
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    close(context, query);
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> lista = [];
    if (query.isNotEmpty) {
      lista = ["Android", "Android navegação", "IOS", "Jogos"]
          .where((texto) => texto.startsWith(query))
          .toList();
      return ListView.builder(
        itemCount: lista.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              close(context, index.toString());
            },
            title: Text(lista[index]),
          );
        },
      );
    } else {
      return Center(
        child: Text("Nenhum resultado para a pesquisa!"),
      );
    }
  }
}
