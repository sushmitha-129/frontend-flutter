import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

void main() {
  runApp(const SportsApp());
}

class SportsApp extends StatelessWidget {
  const SportsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Sports Talent Platform",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const AuthSelectionPage(),
    );
  }
}

/// Landing page → Login / Register / Skip
class AuthSelectionPage extends StatelessWidget {
  const AuthSelectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.sports, size: 80, color: Colors.white),
            const SizedBox(height: 20),
            const Text(
              "Welcome to Sports Talent Platform",
              style: TextStyle(fontSize: 20, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const LoginPage()));
              },
              child: const Text("Login"),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const RegisterPage()));
              },
              child: const Text("Register"),
            ),
            const SizedBox(height: 15),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const VideoUploadPage()));
              },
              child: const Text(
                "Skip for now",
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// LOGIN PAGE
class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email or Mobile"),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Login Successful")));
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const VideoUploadPage()));
              },
              child: const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}

/// REGISTER PAGE
class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  String? selectedCountry;
  String? selectedState;
  String? selectedCity;
  DateTime? selectedDob;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(decoration: const InputDecoration(labelText: "Full Name")),
              const SizedBox(height: 10),
              TextFormField(decoration: const InputDecoration(labelText: "Email")),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(labelText: "Password"),
                obscureText: true,
              ),
              const SizedBox(height: 10),
              TextFormField(decoration: const InputDecoration(labelText: "Mobile Number")),
              const SizedBox(height: 10),

              /// Dropdowns
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: "Country"),
                items: ["India", "USA", "UK", "Other"]
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (val) => setState(() => selectedCountry = val),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: "State"),
                items: ["Karnataka", "Maharashtra", "Delhi", "Other"]
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (val) => setState(() => selectedState = val),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: "City"),
                items: ["Bangalore", "Mumbai", "Delhi", "Other"]
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (val) => setState(() => selectedCity = val),
              ),
              const SizedBox(height: 10),

              /// DOB Picker
              Row(
                children: [
                  Expanded(
                    child: Text(selectedDob == null
                        ? "Date of Birth: Not Selected"
                        : "Date of Birth: ${selectedDob!.day}/${selectedDob!.month}/${selectedDob!.year}"),
                  ),
                  TextButton(
                    onPressed: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        firstDate: DateTime(1950),
                        lastDate: DateTime.now(),
                        initialDate: DateTime(2005),
                      );
                      if (picked != null) {
                        setState(() => selectedDob = picked);
                      }
                    },
                    child: const Text("Select"),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              TextFormField(decoration: const InputDecoration(labelText: "School/College Name")),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(labelText: "Aadhar Number"),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),

              /// Terms & Conditions
              Row(
                children: [
                  Checkbox(value: true, onChanged: (val) {}),
                  const Expanded(child: Text("By registering, you agree to our Terms & Conditions"))
                ],
              ),
              const SizedBox(height: 15),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Registered Successfully!")));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const VideoUploadPage()));
                  }
                },
                child: const Text("Create Account"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

/// VIDEO UPLOAD PAGE
class VideoUploadPage extends StatefulWidget {
  const VideoUploadPage({Key? key}) : super(key: key);

  @override
  VideoUploadPageState createState() => VideoUploadPageState();
}

class VideoUploadPageState extends State<VideoUploadPage> {
  PlatformFile? runningVideo;
  PlatformFile? jumpingVideo;
  PlatformFile? pushupsVideo;

  String userName = "Guest"; // default if skipped login

  Future<void> pickVideo(String type) async {
    final result = await FilePicker.platform.pickFiles(type: FileType.video);
    if (result != null) {
      setState(() {
        if (type == 'running') runningVideo = result.files.first;
        if (type == 'jumping') jumpingVideo = result.files.first;
        if (type == 'pushups') pushupsVideo = result.files.first;
      });
    }
  }

  Widget instructionTile(String step) {
    return Container(
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.25),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white30, width: 1),
      ),
      child: Text(
        step,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget actionTile(String title, PlatformFile? file, String type) {
    return GestureDetector(
      onTap: () => pickVideo(type),
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.25),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white30, width: 1),
        ),
        child: Row(
          children: [
            const Icon(Icons.video_camera_back, size: 30, color: Colors.black87),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title + (file != null ? " : ${file.name}" : ""),
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black87),
              ),
            ),
            const Icon(Icons.upload_file, color: Colors.black87),
          ],
        ),
      ),
    );
  }

  void submitVideos() {
    if (runningVideo != null && jumpingVideo != null && pushupsVideo != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Videos submitted successfully!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please upload all required videos.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD6E6F2), // light vintage blue
      appBar: AppBar(
        backgroundColor: const Color(0xFFD6E6F2),
        elevation: 0,
        title: const Text(
          "Sports Talent Platform",
          style: TextStyle(
              color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: const Color(0xFFD6E6F2)),
              child: Text(
                "Hello $userName",
                style: const TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text("About"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.contact_mail),
              title: const Text("Contact"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Instructions",
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
            const SizedBox(height: 12),
            instructionTile(
                "Running: Place your phone in pocket or on tripod. Record 20-30m sprint."),
            instructionTile(
                "Jumping: Ensure full body is visible from the side. Perform 2-3 jumps."),
            instructionTile(
                "Pushups: Phone should capture full torso, side/front view. Perform maximum correct reps in 60 seconds."),
            const SizedBox(height: 20),
            const Text("Upload Videos",
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
            actionTile("Running Video", runningVideo, 'running'),
            actionTile("Jumping Video", jumpingVideo, 'jumping'),
            actionTile("Pushups Video", pushupsVideo, 'pushups'),
            const SizedBox(height: 30),
            Center(
              child: GestureDetector(
                onTap: submitVideos,
                child: Container(
                  width: 100,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(2, 2),
                      ),
                    ],
                    border: Border.all(color: Colors.white30, width: 1),
                  ),
                  child: const Center(
                    child: Text(
                      "Submit",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
