import 'package:flutter/material.dart';
import 'package:workshop2/waiting_room_manager.dart';

void main() {
  runApp(const WaitingRoomApp());
}

class WaitingRoomApp extends StatelessWidget {
  const WaitingRoomApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WaitingRoomScreen(),
    );
  }
}

class WaitingRoomScreen extends StatefulWidget {
  const WaitingRoomScreen({super.key});

  @override
  State<WaitingRoomScreen> createState() => _WaitingRoomScreenState();
}

class _WaitingRoomScreenState extends State<WaitingRoomScreen> {
  // Instance de notre logique créée à l'étape 1
  final WaitingRoomManager _manager = WaitingRoomManager();
  
  // Contrôleur pour récupérer ce que l'utilisateur écrit dans le champ
  final TextEditingController _controller = TextEditingController();

  void _addClient() {
    if (_controller.text.isNotEmpty) {
      // setState dit à Flutter de redessiner l'écran avec la nouvelle valeur
      setState(() {
        _manager.addClient(_controller.text);
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Waiting Room'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Champ texte + Bouton Ajouter
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(labelText: 'Client Name'),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _addClient,
                  child: const Text('Add'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Compteur de clients
            Text('Clients in Queue: ${_manager.clients.length}'),
            const SizedBox(height: 16),
            // Liste déroulante des clients
            Expanded(
              child: ListView.builder(
                itemCount: _manager.clients.length,
                itemBuilder: (context, index) {
                  final clientName = _manager.clients[index];
                  return Card(
                    child: ListTile(
                      title: Text(clientName),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            _manager.removeClient(clientName);
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
