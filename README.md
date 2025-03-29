# Country Details App

A modern Flutter application that displays information about countries around the world, organized by regions. This app provides a beautiful and intuitive UI for exploring country details, with map integration and social sharing features.

## Features

- **Organized by Regions**: Countries are organized by geographical regions for easy navigation
- **Search Functionality**: Quickly find countries with a responsive search feature
- **Detailed Information**: Comprehensive information about each country, including:
  - Basic details (name, capital, population)
  - Geographical information (region, subregion, area, coordinates)
  - Cultural information (languages, demonyms)
  - Communication details (dialing codes, top-level domains)
  - And more!
- **Map Integration**: Open country locations in installed map applications
- **Social Sharing**: Share country information with friends
- **Beautiful UI**: Modern and user-friendly interface with smooth animations
- **Offline Support**: Data caching for offline access
- **Dark Mode Support**: Adapts to system theme settings

## Technical Details

### Architecture

The app is built using a clean architecture approach with the following layers:

- **Presentation Layer**: UI components, screens, and widgets
- **Domain Layer**: Business logic, providers, and state management
- **Data Layer**: API services, repositories, and models

### Technologies and Libraries

- **State Management**: Flutter Riverpod
- **Networking**: Dio with caching support
- **UI Components**: Custom widgets with Material Design
- **Map Integration**: map_launcher
- **Social Sharing**: share_plus
- **Image Caching**: cached_network_image
- **Loading Animations**: loading_animation_widget

## Getting Started

### Prerequisites

- Flutter SDK (3.6.0 or newer)
- Dart SDK (3.6.0 or newer)
- Android Studio or VS Code with Flutter extensions

### Installation

1. Clone the repository
   ```
   git clone https://github.com/your-username/country_details.git
   ```

2. Navigate to the project directory
   ```
   cd country_details
   ```

3. Install dependencies
   ```
   flutter pub get
   ```

4. Run the app
   ```
   flutter run
   ```

## API Reference

This app uses the [REST Countries API](https://restcountries.com/), which provides detailed information about countries.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgements

- [REST Countries](https://restcountries.com/) for providing the API
- [Flutter](https://flutter.dev/) and [Dart](https://dart.dev/) teams for their amazing work
- All the package developers that made this project possible
