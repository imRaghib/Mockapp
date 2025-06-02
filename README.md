# 🚗 Vehicle Dealer Service App

A **cross-platform vehicle dealer service app** built using **Flutter**, following **MVVM
architecture** and **SOLID principles** for scalable and maintainable code.

---

## ✨ Features

- 🔒 **Secure Authentication**  
  Node.js backend with JWT-based authentication for secure user and dealer logins.

- 🧠 **AI/ML License Plate Detection**  
  Integrated a custom-built OCR model that detects and matches license plates against an internal
  vehicle directory.

- 📦 **Optimized Data Management**  
  Backend database queries optimized for 30% faster data retrieval, supporting over **5,000 vehicle
  listings** and user accounts.

- 💡 **Responsive Cross-Platform UI**  
  Built in Flutter with responsive layouts for seamless experience across devices.

- 🔄 **Real-Time Dealer-Customer Interaction**  
  Live updates and smooth workflows to streamline the vehicle buying/selling process.

---

## 📐 Architecture

This project adopts the **Model-View-ViewModel (MVVM)** pattern for clear separation of concerns and
testability.

```
lib/
├── services/, constants/, utils/
├── auth/, vehicles/, dashboard/, ...
│ ├── model/
│ ├── view/
│ ├── viewmodel/
├── data/
│ └── api/, repository/

````

---

## 🛠 Tech Stack

### Frontend

- Flutter & Dart
- MVVM Architecture
- Provider (State Management)

### Backend

- Node.js & Express.js
- JWT Authentication
- SQL Database (PostgreSQL/MySQL)
- RESTful APIs  
  🔗 [Backend Repository](https://github.com/imRaghib/Mockapp_Server)

### AI/ML

- Custom OCR + ML Model
- License Plate Recognition (Python-based)
- Integrated using platform channels/local services

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK
- Node.js
- SQL Database (MySQL or PostgreSQL)
- Python (for AI/ML module)

### Installation

```bash
# Clone the repo
git clone https://github.com/your-username/vehicle-dealer-app.git
cd vehicle-dealer-app

# Install Flutter dependencies
flutter pub get

# Run the app
flutter run
