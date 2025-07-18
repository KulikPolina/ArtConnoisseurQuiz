🎨 Art Connoisseur Quiz
A sleek and interactive Flutter application that tests your knowledge of famous artworks. This app fetches data from the Art Institute of Chicago API, allowing users to take a challenging art quiz, search for specific pieces, and save their favorite works.

✨ Features
Interactive Art Quiz: Test your knowledge by identifying the artists of famous artworks.
Artwork Search: A fast and responsive search functionality to discover new art.
Favorites System: Save your favorite artworks for easy access. Your choices are persisted locally on your device.
Dynamic Theming: Seamlessly switch between light and dark modes. The app remembers your preference.
Clean, Modern UI: A polished and intuitive user interface designed for a great user experience.
Built with Clean Architecture: A robust and scalable codebase that separates business logic from UI and data sources.

📸 Screenshots
Note: Replace these with actual screenshots of your running application.
Quiz Screen	Search Screen	Favorites (Dark Mode)
Eksportuj do Arkuszy

Senior Dart Developer
Niestandardowy Gem
Pokaż przebieg rozumowania
Of course. Here is a complete README.md file for the "Art Connoisseur Quiz" project we've built.
You can create a file named README.md in the root of your project directory and paste this content inside.

🎨 Art Connoisseur Quiz
A sleek and interactive Flutter application that tests your knowledge of famous artworks. This app fetches data from the Art Institute of Chicago API, allowing users to take a challenging art quiz, search for specific pieces, and save their favorite works.

✨ Features
Interactive Art Quiz: Test your knowledge by identifying the artists of famous artworks.
Artwork Search: A fast and responsive search functionality to discover new art.
Favorites System: Save your favorite artworks for easy access. Your choices are persisted locally on your device.
Dynamic Theming: Seamlessly switch between light and dark modes. The app remembers your preference.
Clean, Modern UI: A polished and intuitive user interface designed for a great user experience.
Built with Clean Architecture: A robust and scalable codebase that separates business logic from UI and data sources.

📸 Screenshots
Note: Replace these with actual screenshots of your running application.
Quiz Screen	Search Screen	Favorites (Dark Mode)
Eksportuj do Arkuszy

🛠️ Tech Stack & Architecture
This project is a showcase of modern Flutter development practices and a robust, scalable architecture.
Core Technologies
Framework: Flutter
Language: Dart
State Management: flutter_bloc / bloc
Navigation: auto_route for type-safe, generated routing.
Dependency Injection: get_it for service location.
Networking: dio for powerful and reliable HTTP requests.
Local Storage: shared_preferences for persisting theme and favorite choices.
Code Generation: build_runner, json_serializable.
Architecture
The application is built following the principles of Clean Architecture. This separates the code into three distinct layers, ensuring that the business logic is independent of the UI and data sources.
Domain Layer: The core of the application. It contains the business logic (Use Cases) and entity definitions. It has no dependencies on any other layer.
Data Layer: Responsible for all data operations. It implements the repository contracts defined in the Domain layer and handles communication with the API and local storage.
Presentation Layer: The UI of the application. It contains all the screens, widgets, and BLoCs responsible for managing the UI state and reacting to user input.

