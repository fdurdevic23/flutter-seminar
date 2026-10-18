
import 'package:flutter/material.dart';

void main() {
  runApp(const MojaAplikacija());
}

class MojaAplikacija extends StatelessWidget {
  const MojaAplikacija({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Navigacija između dva zaslona',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
      ),
      home: const PocetniZaslon(),
    );
  }
}

// PRVI ZASLON
class PocetniZaslon extends StatefulWidget {
  const PocetniZaslon({super.key});

  @override
  State<PocetniZaslon> createState() => _StanjePocetnogZaslona();
}

class _StanjePocetnogZaslona extends State<PocetniZaslon> {
  final TextEditingController _kontrolerImena =
      TextEditingController();

  void _idiNaDrugiZaslon() {
    final ime = _kontrolerImena.text.trim();

    if (ime.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Molimo unesite ime.'),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DrugiZaslon(ime: ime),
      ),
    );
  }

  @override
  void dispose() {
    _kontrolerImena.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Početni zaslon'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Dobrodošli!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _kontrolerImena,
                decoration: const InputDecoration(
                  labelText: 'Unesite svoje ime',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _idiNaDrugiZaslon,
                child: const Text('Nastavi'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// DRUGI ZASLON
class DrugiZaslon extends StatelessWidget {
  final String ime;

  const DrugiZaslon({
    super.key,
    required this.ime,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drugi zaslon'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Pozdrav, $ime! 👋',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Povratak'),
            ),
          ],
        ),
      ),
    );
  }
}
