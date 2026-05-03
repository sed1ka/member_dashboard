# Flutter Mini Test Project

### 🚀 Flutter Version

This project was developed using:

Flutter 3.41.9

---

### 📦 Installation

1. Clone this repository:
   git clone <your-repo-url>
   cd <project-folder>

2. Install dependencies:
   flutter pub get

3. Run code generation (required for go_router_builder):
   dart run build_runner build --delete-conflicting-outputs

---

### ▶️ Running the App

This project has been tested on:

* 🌐 Chrome (Web)
* 📱 Android Device

Run the app with:
flutter run -d chrome

or:
flutter run

---

### 📚 Packages Used

#### Dependencies

* bloc: ^9.2.0
* flutter_bloc: ^9.1.1
* dartz: ^0.10.1
* equatable: ^2.0.8
* get_it: ^9.2.1
* go_router: ^17.2.2
* go_router_builder: ^4.3.0
* easy_refresh: ^3.5.0
* flutter_secure_storage: ^10.0.0
* intl: ^0.20.2
* lottie: ^3.3.3
* skeletonizer: ^2.1.3

#### Dev Dependencies

* build_runner: ^2.14.1
* flutter_lints: ^6.0.0
* mocktail: ^1.0.5

---

### ⚖️ Assumptions & Tradeoffs

* The project does not use a real backend API.
* All data is sourced from mock JSON and treated as a remote API.
* All data sources are implemented as remote.

Tradeoffs:

* Faster development for the test scope.
* In real projects, an API client layer (e.g., Dio) should be added.
* Full TDD is not implemented due to time constraints.

---

### 🧪 Testing

* Unit test only available for:
  core/local_secure_storage

Run:
flutter test

Notes:

* Using mocktail
* Not full coverage due to time limitation

---

### 🧠 Architecture Overview

Clean Architecture:

* Presentation (Bloc)
* Domain (UseCase, Entity)
* Data (Repository, DataSource)

Using:

* get_it (Dependency Injection)
* bloc (State Management)

---
### ⚠️ Additional Notes

* Requires code generation (go_router_builder)
* If error occurs, run:
  dart run build_runner build --delete-conflicting-outputs
