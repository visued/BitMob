import 'package:flutter/material.dart';
import 'package:BitMob/moeda.dart';
import 'package:BitMob/database-helper.dart';
import 'package:BitMob/moeda_screen.dart';

class ListViewMoeda extends StatefulWidget {
  @override
  _ListViewMoedaState createState() => new _ListViewMoedaState();
}

class _ListViewMoedaState extends State<ListViewMoeda> {
  List<Moeda> items = new List();
  //conexão com banco de dados
  DatabaseHelper db = new DatabaseHelper();
  @override
  void initState() {
    super.initState();
    db.getMoedas().then((moedas) {
      setState(() {
        moedas.forEach((moeda) {
          items.add(Moeda.fromMap(moeda));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exemplo de Cadastro',
      home: Scaffold(
        appBar: AppBar(
          title: Text('BitMob - Listagem de Cryptomoedas',
              style: TextStyle(color: Colors.black)),
          centerTitle: true,
          backgroundColor: Colors.orangeAccent,
        ),
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        'https://raw.githubusercontent.com/visued/BitMob/master/logo/logo.png'),
                    fit: BoxFit.cover)),
            child: Center(
              child: ListView.builder(
                  itemCount: items.length,
                  padding: const EdgeInsets.all(15.0),
                  itemBuilder: (context, position) {
                    return Column(
                      children: [
                        Divider(height: 5.0, color: Colors.grey),
                        ListTile(
                          title: Text(
                            '${items[position].nome} - ${items[position].simbolo}',
                            style: TextStyle(
                              fontSize: 22.0,
                              color: Colors.deepOrangeAccent,
                            ),
                          ),
                          subtitle: Row(children: [
                            Text('USD ${items[position].valor}',
                                style: new TextStyle(
                                    fontSize: 18.0,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.orangeAccent)),
                            Text(' ${items[position].variacao_dia}',
                                style: new TextStyle(
                                    fontSize: 16.0,
                                    fontStyle: FontStyle.italic,
                                    color: items[position]
                                            .variacao_dia
                                            .contains('-')
                                        ? Colors.red
                                        : Colors.green)),
                            IconButton(
                                icon: const Icon(
                                  Icons.remove_circle_outline,
                                  color: Colors.redAccent,
                                ),
                                onPressed: () => _deleteMoeda(
                                    context, items[position], position)),
                          ]),
                          leading: CircleAvatar(
                            backgroundColor: Colors.deepOrange,
                            radius: 15.0,
                            child: Text(
                              '${items[position].id}',
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          onTap: () =>
                              _navigateToMoeda(context, items[position]),
                        ),
                      ],
                    );
                  }),
            )),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.black,
          ),
          onPressed: () => _createNewMoeda(context),
          backgroundColor: Colors.orangeAccent,
        ),
      ),
    );
  }

  void _deleteMoeda(BuildContext context, Moeda moeda, int position) async {
    db.deleteMoeda(moeda.id).then((moedas) {
      setState(() {
        items.removeAt(position);
      });
    });
  }

  void _navigateToMoeda(BuildContext context, Moeda moeda) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MoedaScreen(moeda)),
    );
    if (result == 'update') {
      db.getMoedas().then((moedas) {
        setState(() {
          items.clear();
          moedas.forEach((moeda) {
            items.add(Moeda.fromMap(moeda));
          });
        });
      });
    }
  }

  void _createNewMoeda(BuildContext context) async {
    //aguarda o retorno da página de cadastro
    String result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MoedaScreen(Moeda('', '', '', ''))),
    );
    //se o retorno for salvar, recarrega a lista
    if (result == 'save') {
      db.getMoedas().then((moedas) {
        setState(() {
          items.clear();
          moedas.forEach((moeda) {
            items.add(Moeda.fromMap(moeda));
          });
        });
      });
    }
  }
}
