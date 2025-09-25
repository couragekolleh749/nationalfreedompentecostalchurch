import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const ChurchApp());
}

class ChurchApp extends StatelessWidget {
  const ChurchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'National Freedom Pentecostal Church',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.black,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

// ---------------- HOME SCREEN ----------------
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomeTab(),
    SermonsTab(),
    EventsTab(),
    GivingTab(),
    ContactTab(),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[900],
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.play_circle), label: 'Sermons'),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Events'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Giving'),
          BottomNavigationBarItem(icon: Icon(Icons.phone), label: 'Contact'),
        ],
      ),
    );
  }
}

// ---------------- HOME TAB ----------------
class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final List<String> _welcomeMessages = [
    "Welcome to National Freedom Pentecostal Church! ✝️",
    "Experience the power of God in every service! 🙏",
    "Join us in worship, fellowship, and community! 🌟",
  ];

  int _currentIndex = 0;

  Future<void> _launchFacebook() async {
    final uri = Uri.parse("https://www.facebook.com/profile.php?id=100088557976958");
    if (await canLaunchUrl(uri)) await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Future<void> _launchEmail() async {
    final uri = Uri.parse("mailto:nationalfreedompentecostalchur@gmail.com");
    if (await canLaunchUrl(uri)) await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Future<void> _launchGoogleForm() async {
    final uri = Uri.parse("https://forms.gle/YOUR_GOOGLE_FORM_ID"); // Replace with your form
    if (await canLaunchUrl(uri)) await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Banner Image
          Padding(
            padding: const EdgeInsets.all(16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset("assets/images/banner.jpg", fit: BoxFit.cover, height: 180, width: double.infinity),
            ),
          ),
          const SizedBox(height: 20),
          // PageView for welcome messages
          SizedBox(
            height: 100,
            child: PageView.builder(
              onPageChanged: (index) => setState(() => _currentIndex = index),
              itemCount: _welcomeMessages.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[900],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      _welcomeMessages[index],
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          // Indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_welcomeMessages.length, (index) {
              return Container(
                width: _currentIndex == index ? 12 : 8,
                height: _currentIndex == index ? 12 : 8,
                margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == index ? Colors.blueAccent : Colors.grey,
                ),
              );
            }),
          ),
          const SizedBox(height: 20),
          // Social & Visitor Form Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Image.asset('assets/images/facebook.jpg', height: 40),
                onPressed: _launchFacebook,
              ),
              const SizedBox(width: 20),
              IconButton(
                icon: const Icon(Icons.email, size: 40, color: Colors.redAccent),
                onPressed: _launchEmail,
              ),
              const SizedBox(width: 20),
              IconButton(
                icon: const Icon(Icons.person_add, size: 40, color: Colors.greenAccent),
                onPressed: _launchGoogleForm,
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Service Times Card
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blueGrey[900],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("⛪ Sunday School: 9:30 AM - 11:00 AM", style: TextStyle(fontSize: 16)),
                Text("🙏 Worship Service: 11:00 AM - 1:30 PM", style: TextStyle(fontSize: 16)),
                Text("🍞 Communion: Wednesday 5:00 PM - 7:00 PM", style: TextStyle(fontSize: 16)),
                Text("🛡 Anointing Service: Friday 5:00 PM - 7:00 PM", style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------- SERMONS TAB ----------------
class SermonsTab extends StatelessWidget {
  const SermonsTab({super.key});

  Future<void> _launchVideo(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final sermons = [
      {"title": "Faith Over Fear", "url": "https://www.facebook.com/100088557976958/videos/1677086653247106/?app=fbl"},
      {"title": "Walking in Love", "url": "https://www.facebook.com/100088557976958/videos/805873701868755/?app=fbl"},
      {"title": "Power of God", "url": "https://www.facebook.com/100088557976958/videos/3690391411094972/?app=fbl"},
      {"title": "Walking in Faith", "url": "https://www.facebook.com/100088557976958/videos/1442319083521035/?app=fbl"},
    ];

    return ListView.builder(
      itemCount: sermons.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 6,
          child: ListTile(
            leading: const Icon(Icons.play_circle_fill, color: Colors.blue, size: 40),
            title: Text(sermons[index]["title"]!, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: const Text("Apostle Alexander George"),
            trailing: const Icon(Icons.open_in_new, color: Colors.blue),
            onTap: () => _launchVideo(sermons[index]["url"]!),
          ),
        );
      },
    );
  }
}

// ---------------- EVENTS TAB ----------------
class EventsTab extends StatelessWidget {
  const EventsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final events = [
      {"title": "Youth Revival Night", "date": "October 15, 2025"},
      {"title": "Christmas Concert", "date": "December 24, 2025"},
      {"title": "New Year Crossover Service", "date": "December 31, 2025"},
    ];

    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 6,
          child: ListTile(
            leading: const Icon(Icons.event, color: Colors.orange, size: 40),
            title: Text(events[index]["title"]!, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(events[index]["date"]!),
          ),
        );
      },
    );
  }
}

// ---------------- GIVING TAB ----------------
class GivingTab extends StatelessWidget {
  const GivingTab({super.key});

  Future<void> _launchDonation() async {
    final uri = Uri.parse("tel:+231886569938"); // Pastor number with +231
    if (await canLaunchUrl(uri)) await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Support Our Ministry", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            icon: const Icon(Icons.phone),
            label: const Text("Call Pastor to Donate"),
            onPressed: _launchDonation,
          ),
        ],
      ),
    );
  }
}

// ---------------- CONTACT TAB ----------------
class ContactTab extends StatelessWidget {
  const ContactTab({super.key});

  Future<void> _launchEmail(String email) async {
    final uri = Uri.parse("mailto:$email");
    if (await canLaunchUrl(uri)) await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final team = [
      {"role": "Pastor", "name": "Apostle Alexander George", "contact": "+231886569938", "image": "assets/images/pastor.jpg"},
      {"role": "Mother", "name": "Kadiatu George", "contact": "", "image": "assets/images/mother.jpg"},
      {"role": "Choir Director", "name": "Sehsue Davies", "contact": "", "image": "assets/images/choir.jpg"},
      {"role": "Media Head", "name": "Moses Fallah", "contact": "", "image": "assets/images/media.jpg"},
      {"role": "Youth Head", "name": "Israel Acolaste", "contact": "", "image": "assets/images/youth.jpg"},
      {"role": "Protocol Head", "name": "Jerome Kannakai", "contact": "", "image": "assets/images/church.jpg"},
    ];

    return ListView.builder(
      itemCount: team.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 6,
          child: ListTile(
            leading: CircleAvatar(backgroundImage: AssetImage(team[index]["image"]!)),
            title: Text("${team[index]["role"]}: ${team[index]["name"]}"),
            subtitle: team[index]["contact"] != "" ? Text("Contact: ${team[index]["contact"]}") : null,
            trailing: team[index]["contact"] != "" ? IconButton(
              icon: const Icon(Icons.phone, color: Colors.greenAccent),
              onPressed: () => launchUrl(Uri.parse("tel:${team[index]["contact"]}"), mode: LaunchMode.externalApplication),
            ) : null,
            onTap: team[index]["contact"] == "" ? () => _launchEmail("kollehmelvin62@gmail.com") : null,
          ),
        );
      },
    );
  }
}





