# 🎮 Tic Tac Toe – Advanced Flutter Edition

A modern and interactive Tic Tac Toe game built with Flutter, focused on high-quality UI/UX, smooth animations, and clean architecture.
This project demonstrates advanced Flutter concepts including animations, responsive design, localization (RTL/LTR), theming, and structured state management.

---
## 🎥 Demo Video

[![Watch the demo](assets/screenshots/demo_thumbnail.png)](https://drive.google.com/file/d/1X7AimsG2YJ7xUpQZ8wfFwr6Cla_h8HGi/view?usp=drivesdk)

---

## 📸 Screenshots

### 🌙 Dark Mode
![Dark Mode](assets/screenshots/dark_mode.png)

### ☀️ Light Mode
![Light Mode](assets/screenshots/light_mode.png)

### 🏆 Win Celebration
![Win State](assets/screenshots/win_state.png)

### 🌍 Arabic (RTL) Mode
![RTL Mode](assets/screenshots/rtl_mode.png)

### 📱 iPad (Responsive Layout)
![iPad Demo](assets/screenshots/ipad_demo.png)

---

## ✨ Features

### 🧠 Smart Game Logic
- Win detection (horizontal, vertical, diagonal)
- Draw detection
- Score tracking (Player X, Player O, Draw)
- Turn switching
- Undo last move

---

## 🎨 Dynamic Theming

- Light Mode
- Dark Mode
- Custom gradients
- Glows & shadows
- Theme switching using ThemeData

---

## 🎞 Animations & Effects

- Implicit animations using `AnimatedContainer`
- Explicit board flip animation
- Win celebration animation powered by [flutter_animate](https://pub.dev/packages/flutter_animate)
- Lottie celebration animation using [lottie](https://pub.dev/packages/lottie)
- Victory sound effect using [audioplayers](https://pub.dev/packages/audioplayers)

---

## 🌍 Localization (RTL / LTR Support)

- English (LTR)
- Arabic (RTL)
- Automatic layout mirroring

---

## 📱 Responsive Layout

- Small mobile screens
- Large mobile screens
- Adaptive UI using LayoutBuilder & flexible widgets

---

## 🧪 Testing

- Game logic testing
- UI behavior validation

---

## 🛠 Tech Stack

- **Flutter** – Cross-platform UI framework  
- **Dart** – Programming language  
- **State Management** – setState  
- **Theming System** – Custom ThemeData (Light & Dark Mode)  
- **Animations** – Implicit & Explicit animations  
- **Third-Party Packages** – flutter_animate, lottie, audioplayers

---

## 🏗 Architecture Highlights

- Clean separation between UI and game logic  
- Reusable custom widgets for repeated components  
- Extracted shared UI elements for better maintainability  
- Organized state handling for board, scores, and turns  
- Structured, readable code with inline documentation  

---

## 🚀 Getting Started
1. Clone the repository
2. Run:
```
flutter pub get
flutter run
```