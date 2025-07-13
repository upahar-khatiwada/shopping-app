# 🛒 Flutter Shopping App

A simple shopping app built using **Flutter** for the frontend and **Firebase** for authentication and database management.

---

## ✨ Features

- ✅ **Email & Social Authentication** (Google, Facebook, Twitter)
- ✅ **Stripe Payment Integration**
- ✅ **Light & Dark Mode Support**
- ✅ **Product Categories with Detailed Product Pages**
- ✅ **Shopping Cart and Checkout Pages**
- ✅ **Order Receipt Generation**
- ✅ **Delivery Location Selection (based on your location)**
- ✅ **Simple Home Screen with Logout Option**

---


## 🎥 Video Demo
<!-- https://github.com/user-attachments/assets/ce5f9bf2-b4c4-4965-bfbb-3fede8e3f43b -->
https://github.com/user-attachments/assets/699e37e6-4cb0-49e9-a422-645125d45435


---

## 📸 Screenshots

### 🔑 Login Page (Email & Social Login)
<img src="https://github.com/user-attachments/assets/8461ac40-d5d1-4084-b2ae-6f9f9d7b1c68" width="400"/>

---

### 🏠 Home Page
<img src="https://github.com/user-attachments/assets/5073145e-d23f-4f8a-b961-5c62fbd1a0d8" width="400"/>

---

### ⚙️ Settings Page
<img src="https://github.com/user-attachments/assets/79d6c8c5-d780-49ba-8268-a4af8f3d5fe4" width="400"/>

---

### 📄 Product Details Page
<img src="https://github.com/user-attachments/assets/1489bdff-9325-4285-a221-a197254585a1" width="400"/>

---

### 🛒 Cart Page
<img src="https://github.com/user-attachments/assets/d2b81d82-6930-43e6-aaea-4706ba4c8829" width="400"/>

---

### 📍 Delivery Location Page
<img src="https://github.com/user-attachments/assets/4b7477d7-9357-465a-981d-cfb1216d0aa4" width="400"/>

---

### 💳 Checkout Page
<img src="https://github.com/user-attachments/assets/ffd1c67f-8c9d-4b9a-913c-c067cdafea40" width="400"/>

---

### 🧾 Receipt Page
<img src="https://github.com/user-attachments/assets/1665288d-24b2-481e-a653-358090813518" width="400"/>


---


### 🗄️ Database
<img src="https://github.com/user-attachments/assets/0fcb8c99-23ef-4c82-83e6-fd6458c5a7f6" width="400/">


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
git clone https://github.com/upahar-khatiwada/shopping-app
cd shopping-app
```

### 2. Create a `.env` File at the Root

Create a `.env` file in the root directory and add your authentication keys:

```env
FACEBOOK_APP_ID= access this from facebook developers site
FACEBOOK_CLIENT_TOKEN= access this from facebook developers site
FB_LOGIN_PROTOCOL_SCHEME= access this from facebook developers site
TWITTER_APIKEY= access this from twitter developers site
TWITTER_SECRET= access this from twitter developers site
TWITTER_CALLBACK= access this from twitter developers site
ACCESS_TOKEN= access this from gallimaps site
STRIPE_PUBLISHABLE_KEY= access this from stripe
STRIPE_SECRET_KEY= access this from stripe
LOCATION_IQ_API_KEY= access this from locationiq site
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

## 📥 Download APK

You can download the prebuilt APK file from the `app_folder/` directory and install it directly on your Android device.

> ⚠️ **Note:** This application is currently built and tested for **Android only**. Compatibility with iOS has not been verified.

---