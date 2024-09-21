import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'user_provider.dart';
import 'auth_service.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String _currentScreen = 'login';
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;
  String _errorMessage = '';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });
    try {
      final user = await _authService.login(
        _emailController.text,
        _passwordController.text,
      );
      context.read<UserProvider>().setUser(user['username'] ?? '');
      Navigator.of(context).pushReplacementNamed('/home');
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to login: ${e.toString()}';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _handleSignup() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });
    try {
      final user = await _authService.signup(
        _nameController.text,
        _emailController.text,
        _passwordController.text,
      );
      context.read<UserProvider>().setUser(user['username'] ?? '');
      Navigator.of(context).pushReplacementNamed('/home');
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to sign up: ${e.toString()}';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _handleForgotPassword() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });
    try {
      await _authService.forgotPassword(_emailController.text);
      setState(() {
        _errorMessage = 'Password reset email sent. Please check your inbox.';
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to send reset email: ${e.toString()}';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authentication'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back navigation
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : _buildCurrentScreen(),
        ),
      ),
    );
  }

  Widget _buildCurrentScreen() {
    return Column(
      children: [
        if (_errorMessage.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Text(
              _errorMessage,
              style: TextStyle(color: Colors.red),
            ),
          ),
        Expanded(
          child: _buildScreenContent(),
        ),
      ],
    );
  }

  Widget _buildScreenContent() {
    switch (_currentScreen) {
      case 'login':
        return _buildLoginScreen();
      case 'signup':
        return _buildSignupScreen();
      case 'forgotPassword':
        return _buildForgotPasswordScreen();
      default:
        return _buildLoginScreen();
    }
  }

  Widget _buildLoginScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Login',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        SizedBox(height: 20),
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            labelText: 'Email',
            prefixIcon: Icon(Icons.email),
          ),
        ),
        SizedBox(height: 10),
        TextField(
          controller: _passwordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            prefixIcon: Icon(Icons.lock),
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _handleLogin,
          child: Text('Login'),
        ),
        TextButton(
          onPressed: () => setState(() => _currentScreen = 'forgotPassword'),
          child: Text('Forgot password?'),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Don't have an account?"),
            TextButton(
              onPressed: () => setState(() => _currentScreen = 'signup'),
              child: Text('Sign up'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSignupScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Sign Up',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        SizedBox(height: 20),
        TextField(
          controller: _nameController,
          decoration: InputDecoration(
            labelText: 'Full Name',
            prefixIcon: Icon(Icons.person),
          ),
        ),
        SizedBox(height: 10),
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            labelText: 'Email',
            prefixIcon: Icon(Icons.email),
          ),
        ),
        SizedBox(height: 10),
        TextField(
          controller: _passwordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            prefixIcon: Icon(Icons.lock),
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _handleSignup,
          child: Text('Sign Up'),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Already have an account?'),
            TextButton(
              onPressed: () => setState(() => _currentScreen = 'login'),
              child: Text('Login'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildForgotPasswordScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Forgot Password',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        SizedBox(height: 20),
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            labelText: 'Email',
            prefixIcon: Icon(Icons.email),
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _handleForgotPassword,
          child: Text('Reset Password'),
        ),
        TextButton(
          onPressed: () => setState(() => _currentScreen = 'login'),
          child: Text('Back to Login'),
        ),
      ],
    );
  }
}