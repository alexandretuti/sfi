import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/provider/users.dart';
import 'package:provider/provider.dart';

class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _form = GlobalKey<FormState>();
  DateTime _selectedDate;

  final Map<String, String> _formData = {};

  void _loadFormData(User user) {
    if (user != null && user.id != null) {
      _formData['id'] = user.id;
      _formData['name'] = user.name;
      _formData['email'] = user.email;
      _formData['avatarUrl'] = user.avatarUrl;
      _formData['nroCartaoSUS'] = user.nroCartaoSUS;
      _formData['dataNascimento'] = user.dataNascimento;
      _formData['cpf'] = user.cpf;
      _formData['nomeMaePaciente'] = user.nomeMaePaciente;
      _formData['dataAgendamento'] = user.dataAgendamento;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final user = ModalRoute.of(context).settings.arguments;
    _loadFormData(user);
  }

  _showDatePicker() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2021),
        lastDate: DateTime(2022)
    ).then((pickedDate){
      if(pickedDate == null){
        return;
      }
      setState((){
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário de usuário'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                final isValid = _form.currentState.validate();
                if (isValid) {
                  _form.currentState.save();
                  Provider.of<Users>(context, listen: false).put(
                    User(
                      id: _formData['id'],
                      name: _formData['name'],
                      email: _formData['email'],
                      avatarUrl: _formData['avatarUrl'],
                      nroCartaoSUS: _formData['nroCartaoSUS'],
                      dataNascimento: _formData['dataNascimento'],
                      cpf: _formData['cpf'],
                      nomeMaePaciente: _formData['nomeMaePaciente'],
                      dataAgendamento: _formData['dataAgendamento'],
                    ),
                  );
                  Navigator.of(context).pop();
                }
              }),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _form,
          child: Column(
            children: <Widget>[
              //
              TextFormField(
                initialValue: _formData['nroCartaoSUS'],
                decoration: InputDecoration(labelText: 'Número cartão SUS'),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Cartão não informado';
                  }
                  if (value.trim().length < 10) {
                    return 'Número do cartão deve conter pelo menos 10 caracteres.';
                  }
                  return null;
                },
                onSaved: (value) => _formData['nroCartaoSUS'] = value,
              ),

              TextFormField(
                initialValue: _formData['dataNascimento'],
                decoration: InputDecoration(labelText: 'Data de nascimento'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Data de nascimento invalida!';
                  }
                  return null;
                },
                onSaved: (value) => _formData['dataNascimento'] = value,
              ),

              //

              TextFormField(
                initialValue: _formData['name'],
                decoration: InputDecoration(labelText: 'Nome completo'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nome invalido';
                  }
                  if (value.trim().length < 3) {
                    return 'Nome muito pequeno. Informe no minimo 3 letras';
                  }
                  return null;
                },
                onSaved: (value) => _formData['name'] = value,
              ),

              TextFormField(
                initialValue: _formData['cpf'],
                decoration: InputDecoration(labelText: 'CPF'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'CPF invalido!';
                  }
                  if (value.trim().length < 11) {
                    return 'CPF deve conter 11 caracteres';
                  }
                  return null;
                },
                onSaved: (value) => _formData['cpf'] = value,
              ),

              TextFormField(
                initialValue: _formData['nomeMaePaciente'],
                decoration:
                    InputDecoration(labelText: 'Nome da mãe do paciente'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nome invalido';
                  }
                  if (value.trim().length < 3) {
                    return 'Nome muito pequeno. Informe no minimo 3 letras';
                  }
                  return null;
                },
                onSaved: (value) => _formData['nomeMaePaciente'] = value,
              ),

              TextFormField(
                initialValue: _formData['email'],
                decoration: InputDecoration(labelText: 'Email'),
                onSaved: (value) => _formData['email'] = value,
              ),
              TextFormField(
                initialValue: _formData['avatarUrl'],
                decoration: InputDecoration(labelText: 'Foto'),
                onSaved: (value) => _formData['avatarUrl'] = value,
              ),

              TextFormField(
                initialValue: _formData['dataAgendamento'],
                decoration:
                InputDecoration(labelText: 'Data de agendamento'),
                validator: (value) {
                  return null;
                },
                onSaved: (value) => _formData['dataAgendamento'] = _selectedDate.toString(),
              ),

              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Text(
                        _selectedDate == null ? "data":  _selectedDate.toString()
                    ),
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      child: Text(
                        'Selecionar Data',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: _showDatePicker,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
