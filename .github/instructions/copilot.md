### General
- This is a Dart & Flutter project. 
- After making any changes, you can verify them by running the terminal command `flutter analyze` and confirm that there are no issues or warnings.

### UI
- All screens should use a ViewModel, which will interact with the service and is easily testable.
- Complex widgets within a screen can have their own ViewModel if required.
- ViewModels of StatefulWidgets must extend ChangeNotifier.