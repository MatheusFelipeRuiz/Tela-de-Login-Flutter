import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const TelaLogin());
}

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final _chaveForm = GlobalKey<FormState>();
  var _modoLogin = true;
  var _emailInserido = '';
  var _senhaInserida = '';
  var _nomeUsuarioInserido = '';
  var _senhaVisivel = true;

  void _enviar() async {
    if (!_chaveForm.currentState!.validate()) {
      return;
    }

    _chaveForm.currentState!.save();

    try {
      if (_modoLogin) {
        //logar usuario
        print('Usuário Logado. Email: $_emailInserido, Senha: $_senhaInserida');
      } else {
        //criar usuario
        print(
            'Usuário Criado. Email: $_emailInserido, Senha: $_senhaInserida, Nome de Usuário: $_nomeUsuarioInserido');
      }
    } catch (_) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).clearSnackBars();
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Falha na autenticação.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        focusColor: Colors.black,
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: Colors.yellow,
        ),
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    top: 30,
                    bottom: 20,
                    left: 20,
                    right: 20,
                  ),
                  child: Image.asset(
                    'img/logo-unicv.png',
                    width: 400,
                    height: 100,
                  ),
                ),
                Card(
                  surfaceTintColor: Colors.white,
                  color: Colors.white,
                  margin: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Form(
                        key: _chaveForm,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              cursorColor: Colors.black,
                              decoration: const InputDecoration(
                                labelText: 'E-mail',
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              autocorrect: false,
                              textCapitalization: TextCapitalization.none,
                              validator: (value) {
                                if (value == null ||
                                    value.trim().isEmpty ||
                                    !value.contains('@')) {
                                  return 'Por favor, insira um endereço de email válido.';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _emailInserido = value!;
                              },
                            ),
                            if (!_modoLogin)
                              TextFormField(
                                decoration: const InputDecoration(
                                    labelText: 'Nome de Usuário'),
                                enableSuggestions: false,
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.trim().length < 4) {
                                    return 'Por favor, insira pelo menos 4 caracteres.';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _nomeUsuarioInserido = value!;
                                },
                              ),
                            TextFormField(
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                labelText: 'Senha',
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _senhaVisivel
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _senhaVisivel = !_senhaVisivel;
                                    });
                                  },
                                ),
                              ),
                              obscureText: _senhaVisivel,
                              validator: (value) {
                                if (value == null || value.trim().length < 6) {
                                  return 'A senha deve ter pelo menos 6 caracteres.';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _senhaInserida = value!;
                              },
                            ),
                            const SizedBox(height: 50),
                            ElevatedButton(
                              style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all<Size>(
                                  Size(200, 50),
                                ),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Color.fromRGBO(
                                    81,
                                    137,
                                    60,
                                    100,
                                  ),
                                ),
                              ),
                              onPressed: _enviar,
                              child: Text(
                                _modoLogin ? 'Entrar' : 'Cadastrar',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
