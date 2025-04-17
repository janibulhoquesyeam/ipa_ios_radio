import 'package:flutter/material.dart';

class contactscreen extends StatelessWidget {
  const contactscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1F6BD6), // Main blue
              Color(0xFF1552A1), // Darker blue
            ],
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Social icons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Icon(Icons.facebook, color: Colors.white),
                          Icon(Icons.camera_alt, color: Colors.white),
                          Icon(Icons.chat, color: Colors.white),
                          Icon(Icons.share, color: Colors.white),
                          Icon(Icons.location_pin, color: Colors.white),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Mail / App Links
                      CardItem(
                        title: 'Mail de omroeper',
                        icon: Icons.email,
                      ),
                      const SizedBox(height: 8),
                      CardItem(
                        title: 'App de omroeper',
                        icon: Icons.message,
                      ),
                      const SizedBox(height: 24),

                      // Email Section
                      const SectionHeader(title: 'Email:'),
                      const ContactDetail(
                          title: 'Directie', subtitle: 'apintie@sr.net'),
                      const ContactDetail(
                          title: 'Advertenties/Administratie',
                          subtitle: 'sales@apintie.sr'),
                      const ContactDetail(
                          title: 'Webmaster', subtitle: 'webmaster@apintie.sr'),
                      const SizedBox(height: 24),

                      // Phone Section
                      const SectionHeader(title: 'Telefoonnummers:'),
                      const ContactDetail(
                          title: 'Studio (Radio)', subtitle: '+597 400500'),
                      const ContactDetail(
                          title: 'Studio (Televisie)', subtitle: '+597 401400'),
                      const ContactDetail(
                          title: 'Nieuwsdienst', subtitle: '+597 400403'),
                      const ContactDetail(
                          title: 'Nieuws tiplijn 1', subtitle: '+597 8579195'),
                      const ContactDetail(
                          title: 'Nieuws tiplijn 2', subtitle: '+597 8623774'),
                      const ContactDetail(
                          title: 'Sportredactie', subtitle: '+597 400800'),
                      const ContactDetail(
                          title: 'Administratie', subtitle: '+597 400455'),
                      const ContactDetail(
                          title: 'Directie', subtitle: '+597 400450'),
                      const ContactDetail(
                          title: 'Facsimile', subtitle: '+597 400684'),
                      const SizedBox(height: 24),

                      // Address
                      const SectionHeader(title: 'Post- en bezoekadres:'),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'verl. Gemene Landsweg 37\nParamaribo, Suriname\nZuid Amerika',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  final String title;
  final IconData icon;

  const CardItem({required this.title, required this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF064997),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        trailing: const Icon(Icons.chevron_right, color: Colors.white),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}

class ContactDetail extends StatelessWidget {
  final String title;
  final String subtitle;

  const ContactDetail({required this.title, required this.subtitle, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      subtitle: Text(subtitle, style: const TextStyle(color: Colors.white70)),
    );
  }
}
