import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentStep = 0;
  String? _userName;
  int? _roommateCount;
  List<String> _sharedSpaces = [];

  final List<String> _spaceOptions = ['Kitchen', 'Bathroom', 'Living Room', 'Yard'];

  void _nextStep() {
    if (_currentStep < 2) {
      setState(() {
        _currentStep++;
      });
    } else {
      // TODO: Navigate to main app screen
      print('Onboarding complete');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                _currentStep == 0 ? 'Welcome!' : 'Hi ${_userName ?? ''}',
                style: Theme.of(context).textTheme.headline4,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Expanded(
                child: _buildCurrentStep(),
              ),
              ElevatedButton(
                onPressed: _currentStep == 1 && _roommateCount == null || 
                           _currentStep == 2 && _sharedSpaces.isEmpty ? null : _nextStep,
                child: Text(_currentStep == 2 ? 'Finish' : 'Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return _buildWelcomeScreen();
      case 1:
        return _buildRoommateCountScreen();
      case 2:
        return _buildSharedSpacesScreen();
      default:
        return Container();
    }
  }

  Widget _buildWelcomeScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Let\'s set up your Roomies profile!'),
        SizedBox(height: 20),
        TextField(
          decoration: InputDecoration(
            labelText: 'Your Name',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            setState(() {
              _userName = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildRoommateCountScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('How many roommates do you have?'),
        SizedBox(height: 20),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [1, 2, 3, 4].map((count) {
            return ElevatedButton(
              onPressed: () {
                setState(() {
                  _roommateCount = count;
                });
              },
              style: ElevatedButton.styleFrom(
                primary: _roommateCount == count ? Colors.blue : Colors.grey,
              ),
              child: Text('$count'),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSharedSpacesScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('What are the shared spaces here?'),
        SizedBox(height: 20),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: _spaceOptions.map((space) {
            return FilterChip(
              label: Text(space),
              selected: _sharedSpaces.contains(space),
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _sharedSpaces.add(space);
                  } else {
                    _sharedSpaces.remove(space);
                  }
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_dashboard.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentStep = 0;
  String? _userName;
  int? _roommateCount;
  List<String> _sharedSpaces = [];
  final List<String> _spaceOptions = ['Kitchen', 'Bathroom', 'Living Room', 'Yard'];

  void _nextStep() async {
    if (_currentStep < 2) {
      setState(() {
        _currentStep++;
      });
    } else {
      // Save onboarding data
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('onboardingComplete', true);
      await prefs.setString('userName', _userName ?? '');
      await prefs.setInt('roommateCount', _roommateCount ?? 0);
      await prefs.setStringList('sharedSpaces', _sharedSpaces);

      // Navigate to main app screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeDashboard()),
      );
    }
  }

  bool get _canProceed {
    switch (_currentStep) {
      case 0:
        return _userName != null && _userName!.isNotEmpty;
      case 1:
        return _roommateCount != null;
      case 2:
        return _sharedSpaces.isNotEmpty;
      default:
        return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                _currentStep == 0 ? 'Welcome!' : 'Hi ${_userName ?? ''}',
                style: Theme.of(context).textTheme.headline4,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Expanded(
                child: _buildCurrentStep(),
              ),
              ElevatedButton(
                onPressed: _canProceed ? _nextStep : null,
                child: Text(_currentStep == 2 ? 'Finish' : 'Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return _buildWelcomeScreen();
      case 1:
        return _buildRoommateCountScreen();
      case 2:
        return _buildSharedSpacesScreen();
      default:
        return Container();
    }
  }

  Widget _buildWelcomeScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Let\'s set up your Roomies profile!'),
        SizedBox(height: 20),
        TextField(
          decoration: InputDecoration(
            labelText: 'Your Name',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            setState(() {
              _userName = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildRoommateCountScreen() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text('How many roommates do you have?'),
      SizedBox(height: 20),
      Wrap(
        spacing: 10,
        runSpacing: 10,
        children: [1, 2, 3, 4].map((count) {
          return ElevatedButton(
            onPressed: () {
              setState(() {
                _roommateCount = count;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _roommateCount == count ? Colors.blue : Colors.grey,
            ),
            child: Text('$count'),
          );
        }).toList(),
      ),
    ],
  );
}

  Widget _buildSharedSpacesScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('What are the shared spaces here?'),
        SizedBox(height: 20),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: _spaceOptions.map((space) {
            return FilterChip(
              label: Text(space),
              selected: _sharedSpaces.contains(space),
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _sharedSpaces.add(space);
                  } else {
                    _sharedSpaces.remove(space);
                  }
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}