import 'package:flutter/material.dart';
import '../widgets/background_shapes.dart';
import '../widgets/glass_container.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/gradient_button.dart';
import '../services/auth_service.dart';
import '../utils/token_storage.dart';
import 'signup_screen.dart';
import 'dashboard_screen.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  bool loading = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    setState(() => loading = true);

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    final result = await AuthService.login(email, password);

    setState(() => loading = false);

    if (result.success) {
      await TokenStorage.saveToken(result.token!);

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const DashboardScreen()),
      );
    } else {
      _showError(result.message ?? "Login failed");
    }
  }

  void _showError(String msg) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white.withOpacity(0.15),
        title: const Text("Error", style: TextStyle(color: Colors.white)),
        content: Text(msg, style: const TextStyle(color: Colors.white)),
        actions: [
          TextButton(
            child: const Text("OK", style: TextStyle(color: Colors.white)),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundShapes(),

          // Fade-in animation
          FadeTransition(
            opacity: _fadeAnimation,
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: GlassContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Welcome Back",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Login to continue",
                        style: TextStyle(fontSize: 16, color: Colors.white70),
                      ),
                      const SizedBox(height: 32),

                      CustomTextField(
                        label: "Email",
                        controller: emailController,
                      ),
                      const SizedBox(height: 16),

                      CustomTextField(
                        label: "Password",
                        controller: passwordController,
                        obscure: true,
                      ),
                      const SizedBox(height: 24),

                      loading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : GradientButton(text: "Login", onTap: _login),

                      const SizedBox(height: 16),

                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ForgotPasswordScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(
                              color: Colors.white70,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const SignupScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "Don't have an account? Sign up",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
