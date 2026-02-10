android {
    namespace = "com.example.stationary"
    compileSdk = 35  // <- yahan update

    defaultConfig {
        applicationId = "com.example.stationary"
        minSdk = 21
        targetSdk = 35  // <- optional, target bhi 35 kar do
        versionCode = 1
        versionName = "1.0"
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = "11"
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}
