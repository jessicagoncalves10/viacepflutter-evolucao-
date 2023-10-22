import 'dart:convert';

class EnderecoModel {
  final String bairro;
  final String logradouro;
  final String complemento;
  final String localidade;

  EnderecoModel(
      {required this.bairro, required this.logradouro, required this.complemento, required this.localidade});

  Map<String, dynamic> toMap() {
    return {
      'bairro': bairro,
      'logradouro': logradouro,
      'complemento': complemento,
      'localidade': localidade,
    };
  }

  factory EnderecoModel.fromMap(Map<String, dynamic> map) {
    return EnderecoModel(
        bairro: map['bairro'],
        logradouro: map['logradouro'],
        complemento: map['complemento'],
        localidade: map['localidade']);
  }
  factory EnderecoModel.fromJson(String json) =>
      EnderecoModel.fromMap(jsonDecode(json));
}
