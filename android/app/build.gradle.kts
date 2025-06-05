import java.util.Properties

plugins {
    id("com.android.application")
    id("com.google.gms.google-services") // FlutterFire
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin") // must come last
}

val dotenv = Properties().apply {
    val envFile = File(rootDir.parentFile, ".env")
    if (envFile.exists()) {
        load(envFile.inputStream())
    } else {
        println(".env file not found in root project.")
    }
}

android {
    namespace = "com.example.shopping_app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.shopping_app"
        minSdk = 23
        targetSdk = 33
        versionCode = flutter.versionCode
        versionName = flutter.versionName

        resValue("string", "facebook_app_id", "\"${dotenv["FACEBOOK_APP_ID"] ?: "REPLACE_ME"}\"")
        resValue("string", "facebook_client_token", "\"${dotenv["FACEBOOK_CLIENT_TOKEN"] ?: "REPLACE_ME"}\"")
        resValue("string", "fb_login_protocol_scheme", "\"${dotenv["FB_LOGIN_PROTOCOL_SCHEME"] ?: "REPLACE_ME"}\"")
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation("com.facebook.android:facebook-android-sdk:latest.release")
}
