class Moeda {
  int _id;
  String _nome;
  String _valor;
  String _simbolo;
  String _variacao_dia;

  //construtor da classe
  Moeda(this._nome, this._valor, this._simbolo, this._variacao_dia);
  //converte dados de vetor para objeto
  Moeda.map(dynamic obj) {
    this._id = obj['id'];
    this._nome = obj['nome'];
    this._valor = obj['valor'];
    this._simbolo = obj['simbolo'];
    this._variacao_dia = obj['variacao_dia'];
  }
  // encapsulamento
  int get id => _id;
  String get nome => _nome;
  String get valor => _valor;
  String get simbolo => _simbolo;
  String get variacao_dia => _variacao_dia;
//converte o objeto em um map
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['nome'] = _nome;
    map['valor'] = _valor;
    map['simbolo'] = _simbolo;
    map['variacao_dia'] = _variacao_dia;
    return map;
  }

  //converte map em um objeto
  Moeda.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._nome = map['nome'];
    this._valor = map['valor'];
    this._simbolo = map['simbolo'];
    this._variacao_dia = map['variacao_dia'];
  }
}
