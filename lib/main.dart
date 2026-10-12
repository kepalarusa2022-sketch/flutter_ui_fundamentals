import 'package:flutter/material.dart';

// Identitas Mahasiswa
const String studentName = 'Jack Rich Loro';
const String studentId = '2415051101';

void main() {
  runApp(const CourseExplorerApp());
}

class CourseExplorerApp extends StatelessWidget {
  const CourseExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Course Explorer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ResponsiveShell(),
    );
  }
}

// Data Course
final List<Map<String, dynamic>> dummyCourses = [
  {
    'code': 'MOB04',
    'title': 'Responsive Layout',
    'status': 'Active',
    'credits': 3,
    'description': 'Mempelajari MediaQuery, LayoutBuilder, dan Breakpoint di Flutter.'
  },
  {
    'code': 'MOB05',
    'title': 'Navigation & Routes',
    'status': 'Planned',
    'credits': 3,
    'description': 'Memahami Navigator stack, passing data, dan adaptive navigation.'
  },
  {
    'code': 'MOB06',
    'title': 'User Interaction',
    'status': 'Planned',
    'credits': 2,
    'description': 'Penanganan gesture, Form validation, SnackBar, dan Dialog.'
  },
  {
    'code': 'MOB07',
    'title': 'State Management',
    'status': 'Planned',
    'credits': 4,
    'description': 'Pengelolaan state aplikasi berskala sedang hingga besar.'
  },
  {
    'code': 'MOB08',
    'title': 'API Integration',
    'status': 'Planned',
    'credits': 3,
    'description': 'Menghubungkan aplikasi Flutter dengan REST API.'
  },
];

// Shell Utama Adaptif
class ResponsiveShell extends StatefulWidget {
  const ResponsiveShell({super.key});

  @override
  State<ResponsiveShell> createState() => _ResponsiveShellState();
}

class _ResponsiveShellState extends State<ResponsiveShell> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const CoursesPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isExpanded = constraints.maxWidth >= 840;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Course Explorer | $studentId',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          ),
          body: isExpanded
              ? Row(
                  children: [
                    NavigationRail(
                      selectedIndex: _selectedIndex,
                      onDestinationSelected: (int index) {
                        setState(() => _selectedIndex = index);
                      },
                      labelType: NavigationRailLabelType.all,
                      destinations: const [
                        NavigationRailDestination(
                          icon: Icon(Icons.home_outlined),
                          selectedIcon: Icon(Icons.home),
                          label: Text('Home'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.school_outlined),
                          selectedIcon: Icon(Icons.school),
                          label: Text('Courses'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.person_outline),
                          selectedIcon: Icon(Icons.person),
                          label: Text('Profile'),
                        ),
                      ],
                    ),
                    const VerticalDivider(thickness: 1, width: 1),
                    Expanded(child: _pages[_selectedIndex]),
                  ],
                )
              : _pages[_selectedIndex],
          bottomNavigationBar: isExpanded
              ? null
              : NavigationBar(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: (int index) {
                    setState(() => _selectedIndex = index);
                  },
                  destinations: const [
                    NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
                    NavigationDestination(icon: Icon(Icons.school), label: 'Courses'),
                    NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
                  ],
                ),
        );
      },
    );
  }
}

// HomePage (Tahap 2: MediaQuery)
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    final isCompact = size.width < 600;
    final skills = ['Flutter', 'Dart', 'Responsive UI', 'Git', 'REST API', 'State Management'];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            color: Colors.blue.shade50,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Foto Profil dari Asset dengan Fallback Ikon
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.asset(
                      'assets/images/profile.jpg',
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const CircleAvatar(
                          radius: 40,
                          child: Icon(Icons.person, size: 40),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          studentName,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text('NIM: $studentId', style: const TextStyle(fontSize: 15)),
                        const Divider(),
                        Text('Width: ${size.width.toStringAsFixed(0)} px'),
                        Text('Height: ${size.height.toStringAsFixed(0)} px'),
                        Text('Orientation: ${orientation.name}'),
                        const SizedBox(height: 4),
                        Text(
                          'Layout: ${isCompact ? 'Compact' : 'Wide'}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isCompact ? Colors.blue : Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text('Keahlian Praktikum (Wrap Widget):', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: skills
                .map((e) => Chip(
                      label: Text(e),
                      backgroundColor: Colors.lightBlue.shade100,
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

// CoursesPage (LayoutBuilder Grid)
class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  final Set<String> _favoriteCodes = {};

  int _getCrossAxisCount(double width) {
    if (width < 600) return 1;
    if (width < 840) return 2;
    return 3;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = _getCrossAxisCount(constraints.maxWidth);

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: columns == 1 ? 2.5 : 1.8,
          ),
          itemCount: dummyCourses.length,
          itemBuilder: (context, index) {
            final course = dummyCourses[index];
            final isFav = _favoriteCodes.contains(course['code']);

            return Card(
              elevation: 2,
              child: InkWell(
                onTap: () async {
                  final result = await Navigator.push<bool>(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CourseDetailPage(
                        course: course,
                        isFavorite: isFav,
                      ),
                    ),
                  );

                  if (result != null && mounted) {
                    setState(() {
                      if (result) {
                        _favoriteCodes.add(course['code']);
                      } else {
                        _favoriteCodes.remove(course['code']);
                      }
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(result
                            ? 'Menambahkan ${course['title']} ke favorit'
                            : 'Membatalkan favorit ${course['title']}'),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(course['code'], style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                          IconButton(
                            icon: Icon(
                              isFav ? Icons.favorite : Icons.favorite_border,
                              color: isFav ? Colors.red : Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                if (isFav) {
                                  _favoriteCodes.remove(course['code']);
                                } else {
                                  _favoriteCodes.add(course['code']);
                                }
                              });
                            },
                          ),
                        ],
                      ),
                      Text(course['title'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const Spacer(),
                      Text('SKS: ${course['credits']} | Status: ${course['status']}'),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

// CourseDetailPage
class CourseDetailPage extends StatefulWidget {
  final Map<String, dynamic> course;
  final bool isFavorite;

  const CourseDetailPage({
    super.key,
    required this.course,
    required this.isFavorite,
  });

  @override
  State<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  late bool _favState;

  @override
  void initState() {
    super.initState();
    _favState = widget.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.course['title']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Kode: ${widget.course['code']}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Kredit SKS: ${widget.course['credits']} SKS'),
            Text('Status: ${widget.course['status']}'),
            const SizedBox(height: 16),
            Text('Deskripsi:\n${widget.course['description']}', style: const TextStyle(fontSize: 15)),
            const Spacer(),
            Card(
              color: Colors.amber.shade50,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text('Praktikan: $studentName ($studentId)'),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                backgroundColor: _favState ? Colors.red.shade100 : Colors.blue.shade100,
              ),
              icon: Icon(_favState ? Icons.favorite : Icons.favorite_border,
                  color: _favState ? Colors.red : Colors.blue),
              label: Text(_favState ? 'Hapus dari Favorit' : 'Tandai Favorit'),
              onPressed: () {
                setState(() => _favState = !_favState);
                Navigator.pop(context, _favState);
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ProfilePage
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _feedbackController = TextEditingController();

  void _submitFeedback() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Konfirmasi Pengiriman'),
          content: Text(
              'Kirim masukan berikut atas nama $studentName ($studentId)?\n\n"${_feedbackController.text}"'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _feedbackController.clear();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Umpan balik berhasil dikirim!')),
                );
              },
              child: const Text('Kirim'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                'assets/images/profile.jpg',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const CircleAvatar(
                    radius: 50,
                    child: Icon(Icons.person, size: 60),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 12),
          Center(
              child: Text(studentName,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
          Center(child: Text('NIM: $studentId', style: const TextStyle(color: Colors.grey))),
          const Divider(height: 32),
          const Text('Form Umpan Balik Matakuliah',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  initialValue: '$studentName ($studentId)',
                  enabled: false,
                  decoration: const InputDecoration(
                      labelText: 'Identitas Mahasiswa', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _feedbackController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Komentar / Masukan',
                    hintText: 'Tuliskan masukan minimal 5 karakter...',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().length < 5) {
                      return 'Komentar wajib diisi minimal 5 karakter';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(48)),
                  onPressed: _submitFeedback,
                  child: const Text('Kirim Feedback'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}