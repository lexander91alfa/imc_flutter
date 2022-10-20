import 'package:flutter/material.dart';
import 'package:imc/services/imc_sevices.dart';

class IMC extends StatelessWidget {
  const IMC({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IMC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'IMC'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final pesoController = TextEditingController();
  final alturaController = TextEditingController();

  double peso = 0.0;
  double altura = 0.0;
  double _imc = 0.0;

  void _setPeso() {
    peso = double.tryParse(pesoController.text) ?? 0.0;
  }

  void _setAltura() {
    altura = double.tryParse(alturaController.text) ?? 0.0;
  }

  @override
  void initState() {
    pesoController.addListener(_setPeso);
    alturaController.addListener(_setAltura);
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    pesoController.dispose();
    alturaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Calculo de IMC'),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                child: TextFormField(
                  controller: alturaController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Altura"),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
              child: TextFormField(
                controller: pesoController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Peso",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
              child: Text(
                'Seu IMC é : ${_imc.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                _imc = calculaImc(altura, peso);
                if (altura <= 0) _imc = 0.0;
                setState(() {});
              },
              child: const Text('Calcular IMC'),
            )
          ],
        ),
      ),
    );
  }
}
