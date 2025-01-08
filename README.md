

# Moru Weather App 🌦️

A Flutter-based weather application that provides real-time weather updates for any location. The app fetches weather data from the [WeatherAPI](https://www.weatherapi.com/) and allows users to save their preferred location for quick access.

---

## Features ✨

- **Real-Time Weather Data**: Fetch and display current weather conditions, including temperature, weather condition, and location.
- **Location Handling**: Save and clear preferred locations using secure local storage.
- **State Management**: Uses `flutter_bloc` for clean and scalable state management.
- **Dependency Injection**: Utilizes `get_it` for dependency injection to share services across the app.
- **Testing**: Includes unit tests and widget tests to ensure code reliability.
- **Secure API Key Management**: Stores the API key securely using environment variables.

---

## Screenshots 📸

| Home Screen | Search Location | Saved Location |
|-------------|-----------------|----------------|
| ![Home Screen](screenshots/home.png) | ![Search Location](screenshots/search.png) | ![Saved Location](screenshots/saved.png) |

---

## Getting Started 🚀

### Prerequisites

- Flutter SDK (version 3.0 or higher)
- Dart SDK (version 2.17 or higher)
- WeatherAPI key (sign up at [WeatherAPI](https://www.weatherapi.com/))

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/moru-weather-app.git
   cd moru-weather-app
   ```

2. Add your WeatherAPI key to a `.env` file:
   ```bash
   echo "WEATHER_API_KEY=your_api_key_here" > .env
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Run the app:
   ```bash
   flutter run
   ```

---

## Project Structure 🗂️

```
lib/
├── main.dart
├── config/
│   └── api_config.dart
├── data/
│   ├── models/
│   ├── repositories/
│   └── sources/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── use_cases/
├── presentation/
│   ├── bloc/
│   ├── pages/
│   └── widgets/
test/
.env
.gitignore
pubspec.yaml
```

---

## Usage 📱

### Fetching Weather Data

1. Enter a city name in the search bar.
2. Tap the "Search" button to fetch and display weather data.

### Saving Location

1. After fetching weather data, tap the "Save Location" button to save the current location.
2. The saved location will be displayed automatically on the next app launch.

### Clearing Location

1. Tap the "Clear Location" button to remove the saved location.

---


## Dependencies 📦

- [flutter_bloc](https://pub.dev/packages/flutter_bloc): State management.
- [get_it](https://pub.dev/packages/get_it): Dependency injection.
- [flutter_dotenv](https://pub.dev/packages/flutter_dotenv): Environment variable management.
- [http](https://pub.dev/packages/http): HTTP requests.
- [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage): Secure local storage.


---

## Contributing 🤝

Contributions are welcome! Please follow these steps:

1. Fork the repository.
2. Create a new branch:
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. Commit your changes:
   ```bash
   git commit -m "Add your feature"
   ```
4. Push to the branch:
   ```bash
   git push origin feature/your-feature-name
   ```
5. Open a pull request.

---

## License 📄

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

## Contact 📧

For any questions or feedback, please reach out:

- **Name**: [Sandesh Ghimire]
- **Email**: [mr.kashyapsandesh@gmail.com]


---

## Acknowledgments 🙏

- [WeatherAPI](https://www.weatherapi.com/) for providing the weather data.
- [Flutter](https://flutter.dev/) for the amazing framework.





