import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../viewmodels/auth_viewmodel.dart';

class LoginScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final passwordVisible = useState(false);
    final errorMessage = useState<String?>(null);
    final isLoading = useState(false);
    final greetingVisible = useState(false);

    useEffect(() {
      Future.delayed(Duration(milliseconds: 500), () {
        greetingVisible.value = true;
      });
      return;
    }, []);

    void handleLogin() async {
      final email = emailController.text;
      final password = passwordController.text;

      if (email.isEmpty) {
        errorMessage.value = "Please enter your email";
        return;
      }

      if (password.isEmpty) {
        errorMessage.value = "Please enter your password";
        return;
      }

      isLoading.value = true;
      errorMessage.value = null;

      final user = await ref.read(authProvider).signInWithEmail(email, password);
      isLoading.value = false;

      if (user != null) {
        Navigator.pushReplacementNamed(context, '/market');
      } else {
        errorMessage.value = "Failed to sign in. Please check your credentials.";
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              opacity: greetingVisible.value ? 1.0 : 0.0,
              duration: Duration(seconds: 1),
              child: Text(
                "Welcome !",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
            ),
            SizedBox(height: 32),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: !passwordVisible.value,
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    passwordVisible.value ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    passwordVisible.value = !passwordVisible.value;
                  },
                ),
              ),
            ),
            SizedBox(height: 16),
            if (isLoading.value)
              CircularProgressIndicator()
            else
              ElevatedButton(
                onPressed: handleLogin,
                child: Text("Login"),
              ),
            if (errorMessage.value != null) ...[
              SizedBox(height: 16),
              Text(
                errorMessage.value!,
                style: TextStyle(color: Colors.red),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
