import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Adicione no pubspec.yaml

void main() {
  runApp(MyApp());
}

class Contact {
  final String name;
  final String email;
  final String avatarUrl;
  bool isFavorite;

  Contact({
    required this.name,
    required this.email,
    required this.avatarUrl,
    this.isFavorite = false,
  });
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Contact> contacts = [
    Contact(
      name: 'Alice',
      email: 'alice@example.com',
      avatarUrl: 'https://i.pravatar.cc/150?img=1',
    ),
    Contact(
      name: 'Bob',
      email: 'bob@example.com',
      avatarUrl: 'https://i.pravatar.cc/150?img=2',
    ),
    Contact(
      name: 'Charlie',
      email: 'charlie@example.com',
      avatarUrl: 'https://i.pravatar.cc/150?img=3',
    ),
  ];

  bool showOnlyFavorites = false;

  int get favoriteCount => contacts.where((c) => c.isFavorite).length;

  List<Contact> get visibleContacts {
    if (showOnlyFavorites) {
      return contacts.where((c) => c.isFavorite).toList();
    }
    return contacts;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Perfil & Contatos',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Perfil'),
          backgroundColor: Colors.deepPurple,
        ),
        drawer: Drawer(
          child: Column(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.deepPurple),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Contatos ❤️: $favoriteCount',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(
                        showOnlyFavorites
                            ? Icons.filter_alt
                            : Icons.filter_alt_outlined,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          showOnlyFavorites = !showOnlyFavorites;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: visibleContacts.length,
                  itemBuilder: (context, index) {
                    final contact = visibleContacts[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(contact.avatarUrl),
                      ),
                      title: Text(contact.name),
                      subtitle: Text(
                        contact.email,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          contact.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color:
                              contact.isFavorite ? Colors.red : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            contact.isFavorite = !contact.isFavorite;
                          });
                        },
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(
                    'https://i.pravatar.cc/300?u=isabelle'), // substitua por sua imagem se quiser
              ),
              SizedBox(height: 16),
              Text(
                'Isabelle',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                'isabelle.furman@gmail.com',
                style: TextStyle(color: Colors.grey[600]),
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.phone, color: Colors.deepPurple),
                  SizedBox(width: 8),
                  Text('+55 11 91234-5678'),
                ],
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(FontAwesomeIcons.linkedin, color: Colors.blue),
                  SizedBox(width: 8),
                  Text('linkedin.com/in/isabellefurman'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
