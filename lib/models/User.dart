import 'package:flutter/material.dart';

class User{

  final String id;
  final String name;
  final String email;
  final String avatarUrl;

  final String nroCartaoSUS;
  final String dataNascimento;
  final String cpf;
  final String nomeMaePaciente;

  final String dataAgendamento;

  const User({
    this.id,
    @required this.name,
    @required this.email,
    this.avatarUrl,
    @required this.nroCartaoSUS,
    @required this.dataNascimento,
    @required this.cpf,
    @required this.nomeMaePaciente,
    this.dataAgendamento,
  });

}