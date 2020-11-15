import 'package:flutter/material.dart';
import 'package:BitMob/moeda.dart';
import 'package:BitMob/database-helper.dart';

class MoedaScreen extends StatefulWidget {
  final Moeda moeda;
  MoedaScreen(this.moeda);
  @override
  State<StatefulWidget> createState() => new _MoedaScreenState();
}

class _MoedaScreenState extends State<MoedaScreen> {
  DatabaseHelper db = new DatabaseHelper();
  TextEditingController _nomeController;
  TextEditingController _valorController;
  TextEditingController _simboloController;
  TextEditingController _variacaoDiaController;
  @override
  void initState() {
    super.initState();
    _nomeController = new TextEditingController(text: widget.moeda.nome);
    _valorController = new TextEditingController(text: widget.moeda.valor);
    _simboloController = new TextEditingController(text: widget.moeda.simbolo);
    _variacaoDiaController =
        new TextEditingController(text: widget.moeda.variacao_dia);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Cryptomoeda'),
        backgroundColor: Colors.orangeAccent,
      ),
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    'https://raw.githubusercontent.com/visued/BitMob/master/logo/logo.png'),
                fit: BoxFit.cover)),
        margin: EdgeInsets.all(15.0),
        alignment: Alignment.center,
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person, color: Colors.deepOrange),
                labelText: 'Nome',
                labelStyle: new TextStyle(color: Colors.deepOrange),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepOrange),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orangeAccent),
                ),
              ),
              style: TextStyle(
                color: Colors.orangeAccent,
              ),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            TextField(
              controller: _valorController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.money, color: Colors.deepOrange),
                labelText: 'Valor',
                labelStyle: new TextStyle(color: Colors.deepOrange),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepOrange),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orangeAccent),
                ),
              ),
              style: TextStyle(
                color: Colors.orangeAccent,
              ),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            TextField(
              controller: _simboloController,
              decoration: InputDecoration(
                  prefixIcon:
                      Icon(Icons.emoji_symbols, color: Colors.deepOrange),
                  labelText: 'Simbolo',
                  labelStyle: new TextStyle(color: Colors.deepOrange),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepOrange),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.orangeAccent),
                  )),
              style: TextStyle(
                color: Colors.orangeAccent,
              ),
            ),
            TextField(
              controller: _variacaoDiaController,
              decoration: InputDecoration(
                  prefixIcon:
                      Icon(Icons.insert_chart, color: Colors.deepOrange),
                  labelText: 'Variação dia',
                  labelStyle: new TextStyle(color: Colors.deepOrange),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepOrange),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.orangeAccent),
                  )),
              style: TextStyle(
                color: Colors.orangeAccent,
              ),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            RaisedButton(
              color: Colors.orangeAccent,
              child:
                  (widget.moeda.id != null) ? Text('Alterar') : Text('Inserir'),
              onPressed: () {
                if (widget.moeda.id != null) {
                  db
                      .updateMoeda(Moeda.fromMap({
                    'id': widget.moeda.id,
                    'nome': _nomeController.text,
                    'valor': _valorController.text,
                    'simbolo': _simboloController.text,
                    'variacao_dia': _variacaoDiaController.text
                  }))
                      .then((_) {
                    Navigator.pop(context, 'update');
                  });
                } else {
                  db
                      .inserirMoeda(Moeda(
                          _nomeController.text,
                          _valorController.text,
                          _simboloController.text,
                          _variacaoDiaController.text))
                      .then((_) {
                    Navigator.pop(context, 'save');
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
