import 'package:flutter/material.dart';

import '../util/findIp.dart';
import './components/button.dart';
import './components/input.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IP Find',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const IpForm(),
    );
  }
}

class IpForm extends StatefulWidget {
  const IpForm({super.key});

  @override
  State<IpForm> createState() => _IpFormState();
}

class _IpFormState extends State<IpForm> {
  String ip = "";
  String? continentName;
  String? countryName;
  String? regionName;
  String? city;
  String? postalCode;

  Future<void> find(String ip) async {
    try {
      var retorno = await findIp(ip);
      // ignore: avoid_print
      print(retorno);

      if (retorno['message'] != null && retorno['message']['code'] != 200) {
        errorFindIp();
        return;
      }

      setState(() {
        continentName = retorno['continentName'];
        countryName = retorno['countryName'];
        regionName = retorno['regionName'];
        city = retorno['city'];
        postalCode = retorno['postalCode'];
      });
    } catch (e) {
      // ignore: avoid_print
      print(e);
      errorFindIp();
    }
  }

  void errorFindIp() {
    clearData();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Erro"),
          content: const Text("Ocorreu um erro ao buscar o IP. Por favor, tente novamente."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void clearData() {
    setState(() {
      ip = "";
      continentName = null;
      countryName = null;
      regionName = null;
      city = null;
      postalCode = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('IP Finder')),
      body: Container(
        color: Colors.red.withOpacity(0.1),
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InputTextField(
                  label: "Informe o IP",
                  value: ip,
                  onChanged: (String value) => setState(() => ip = value),
                ),
                Button(
                  title: "Procurar",
                  onPressed: () => find(ip),
                ),
                const SizedBox(height: 16.0),
                if (continentName != null) ...[
                  if (continentName != null) Text("Continente: $continentName"),
                  if (countryName != null) Text("País: $countryName"),
                  if (regionName != null) Text("Região: $regionName"),
                  if (city != null) Text("Cidade: $city"),
                  if (postalCode != null) Text("Código Postal: $postalCode"),
                  const SizedBox(height: 16.0),
                  Button(
                    title: "Limpar",
                    onPressed: clearData,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
