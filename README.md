# Meet Halfway App

## 🚀 Project Overview

The Meet Halfway App is a mobile application that helps two or more users find a mutually convenient location between their starting points. Designed to simplify meetups for friends, couples, coworkers, and co-parents, the app calculates the optimal midpoint and suggests venues based on distance, travel time, user preferences, and context.

## 📱 Core Features

- Enter two addresses or use location detection or using autocomplete
- 🗺️ Shows nearby places using Google Places API
- 📱 Clean UI using Flutter & Provider
- 🛠️ Modular architecture for scalability
- Calculate a midpoint based on geography or estimated travel time
- Display a list of nearby places (restaurants, cafes, parks, etc.)
- Show time and distance for each user to the midpoint location
- Detailed view for each venue (hours, reviews, navigation, contact)
- One-click navigation via Google or Apple Maps
- History of past meeting spots for quick re-use
- Filter results by type, rating, hours, price range, etc.



## 🔒 Optional/Pro Features (Planned)

- Group planning mode (3+ people)
- Calendar integration for scheduling
- AI-based place suggestions based on preferences/history
- Partner integrations (e.g. Yelp, Uber, OpenTable)
- Sponsored listings and affiliate deals with local businesses

## 🧠 UX Highlights

- Clean, minimalist interface
- Large circular "Meet Halfway" button as the primary CTA
- Location input fields above and below the main button
- Simple tagline under the button: *“We’ll find a perfect meeting place for you both.”*

## 🧱 Tech Stack

- **Flutter** (Dart)
- **Provider** for state management
- **Google Places API** for autocomplete & nearby search
- **Geolocator** for current location access
- Custom widgets & services for clean separation of concerns

## 📁 File Structure (Current)
```
lib/
├── constants/
│   └── api_keys.dart
├── models/
│   ├── location_model.dart
│   ├── place_model.dart
├── providers/
│   ├── directions_provider.dart
│   ├── location_provider.dart
│   ├── midpoint_provider.dart
│   └── place_provider.dart
├── screens/
│   ├── directions_screen.dart
│   ├── home_screen_beforechatgptchanged.dart
│   ├── home_screen.dart
│   ├── place_details_screen.dart
│   └── results_screen.dart
├── services/
│   ├── directions_service.dart
│   ├── location_service.dart
│   ├── midpoint_calculator.dart
│   ├── place_service.dart
├── widgets/
│   ├── location_input_widget.dart
└── main.dart
```

## 🧑‍💻 Collaboration Notes

- Use Git for version control (main branch: `main`)
- Use feature branches with descriptive names (e.g., `feature/midpoint-logic`)
- Keep commits small and meaningful
- Document logic-heavy functions inline
- Use issues for feature requests and bugs

## 🤝 Contributing

If you’re collaborating via ChatGPT or another dev:

- Always refer to the README before implementation
- Stick to modular, testable code
- Ask clarifying questions if a feature spec is ambiguous
- Tag TODOs in the code where implementation is pending

## 📦 Future Enhancements

- Dark mode toggle
- Web companion app for planning meetups from desktop
- Voice-based search for hands-free interaction
- Smart venue ranking based on user behavior over time

---

## 📌 TODO

- Add support for filters (e.g. only show coffee shops)
- Map view for results
- Dark mode theme
- User profiles & history

---

## 📄 License

MIT License © 2025 Mathew Hurlock

Let’s build something that makes meeting up feel effortless ✨
