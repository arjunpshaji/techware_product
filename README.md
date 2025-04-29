# Techware Products App

A simple Flutter app for user authentication, PIN login, and product management using Firebase.

## 🔧 Setup Instructions

1. **Clone the repository**  
   `git clone https://github.com/your-repo/techware_products.git`

2. **Install dependencies**  
   `flutter pub get`

3. **Set up Firebase**
   - Add Firebase to your Flutter project (Android/iOS).
   - Add `google-services.json` to `android/app`.
   - Enable Email/Password sign-in in Firebase Authentication.
   - Enable Firestore Database (test mode is fine for development).

4. **Run the app**  
   `flutter run`

## 🧭 Routes

- `/register` – Register a new user
- `/setup-pin` – Set up a PIN after first login
- `/pin-login` – Login using PIN
- `/home` – View product list
- `/add-product` – Add a new product
- `/product-detail` – View product details and QR code

## ✅ Features

- Firebase email/password registration
- Secure PIN setup and login (using Flutter Secure Storage)
- Product listing from Firestore
- Add products with name, measurement, and price
- QR code generation based on product name
- View product details with QR code

---