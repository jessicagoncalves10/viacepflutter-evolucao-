import 'package:cep_app/models/endereco_model.dart';
import 'package:cep_app/repositories/cep_repository.dart';
import 'package:cep_app/repositories/cep_repository_impl.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CepRepository cepRepository = CepRepositoryImpl();
  EnderecoModel? enderecoModel;
  bool loading = false;

  final formKey = GlobalKey<FormState>();
  final cepEC = TextEditingController();

  @override
  void dispose() {
    cepEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Buscar Cep")),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(padding: EdgeInsets.all(20)),
                TextFormField(
                  controller: cepEC,
                  keyboardType: TextInputType.number, // Defina o tipo de teclado para número
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Cep Obrigatório';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                    onPressed: () async {
                      final valid = formKey.currentState?.validate() ?? false;
                      if (valid) {
                        try {
                          setState(() {
                            loading = true;
                          });
                          final endereco =
                              await cepRepository.getCep(cepEC.text);
                          setState(() {
                            loading = false;
                            enderecoModel = endereco;
                          });
                        } catch (e) {
                          setState(() {
                            loading = false;
                            enderecoModel = null;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Erro ao buscar endereço')));
                        }
                      }
                    },
                    child: const Text(' Buscar')),
                const Padding(padding: EdgeInsets.all(20)),
                Visibility(
                    visible: loading, child: const CircularProgressIndicator()),
                const SizedBox(
                  width: 20,
                ),
                Visibility(
                  visible: enderecoModel != null,
                  child: Text(
                          'Cidade de ${enderecoModel?.localidade}\n${enderecoModel?.logradouro}\n${enderecoModel?.complemento}\nBairro ${enderecoModel?.bairro}',
                          style: const TextStyle(
                            fontSize: 18, 
                            color: Colors.black, 
                            fontWeight: FontWeight.w400, 
                          ),
                          textAlign: TextAlign.center,
                        ),
                )
              ], 
            )),
      ),
    );
  }
}
