# 🔐 Flutter Firebase Authentication

A simple and functional Firebase authentication blueprint that can be easily integrated into other Flutter projects.

---

## ✨ Features

✅ **Email & Password Authentication**  
✅ **Google Sign-In**  
✅ **Facebook Login**  
✅ **Twitter Login**  
✅ **Email Signup with Verification**  
✅ **Password Reset Functionality**  
✅ **Simple Home Page with Logout Option**

---

## 📸 Screenshots

### 🔑 Login Page (Email & Social Login)
<img src="https://github.com/user-attachments/assets/8461ac40-d5d1-4084-b2ae-6f9f9d7b1c68" width="400"/>

---

### 🔁 Reset Password
<img src="https://github.com/user-attachments/assets/425ddd69-04f0-4234-8898-f8ab3244f2ba" width="400"/>

---

### 📝 Email Signup
<img src="https://github.com/user-attachments/assets/cbdadb4e-a1c3-464f-b8a5-90d77fde0f5f" width="400"/>

---

### 📧 Email Verification
<img src="https://github.com/user-attachments/assets/e1dc9519-f9b1-47fa-b84a-451a5aea7169" width="400"/>

---

### 🏠 Home Page with Logout
<img src="https://github.com/user-attachments/assets/62356042-463c-48a4-9693-3772e21fc424" width="400"/>

---

## 🎨 Update App's Theme

You can customize the theme of the app in:
`lib/Screens/login_screens/login_screens_constants/const_var.dart`


This file includes values for:

- Background color 
- Text Color
- Button Colors and more

Edit the values as per your liking

---

## 🔧 Prerequisites

- Flutter SDK installed
- Android device or emulator set up
- Firebase project with Authentication enabled
- Valid API keys for Google, Facebook, and Twitter (for social logins)

---

## 🚀 Installation & Usage

### 1. Clone the Repository

```bash
git clone https://github.com/upahar-khatiwada/Flutter-Firebase-Authentication
cd Flutter-Firebase-Authentication
```

### 2. Create a `.env` File at the Root

Create a `.env` file in the root directory and add your authentication keys:

```env
CLIENT_ID=
CLIENT_SECRET=
FACEBOOK_APP_ID=
FACEBOOK_CLIENT_TOKEN=
FB_LOGIN_PROTOCOL_SCHEME=
TWITTER_APIKEY=
TWITTER_SECRET=
TWITTER_CALLBACK=
```

### 3. Configure `env.gradle` for Android

In your root directory, create a `.env.gradle` file with the following content:

```gradle
def dotenv = new Properties()
def envFile = rootProject.file(".env")
if (envFile.exists()) {
    dotenv.load(new FileInputStream(envFile))
}

ext {
    facebookAppId = dotenv.getProperty("FACEBOOK_APP_ID")
    facebookClientToken = dotenv.getProperty("FACEBOOK_CLIENT_TOKEN")
    fbLoginProtocolScheme = dotenv.getProperty("FB_LOGIN_PROTOCOL_SCHEME")
}
```

### 4. Get Flutter Dependencies

```bash
flutter pub get
```

### 5. Run the App

```bash
flutter run
```

---
