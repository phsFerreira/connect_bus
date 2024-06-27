![Banner ConnectBus](./assets/images/banner.png)

An application for public transportation (buses), written in Flutter using Firebase / Firestore.

## Description

**Connect Bus** is an application designed for the undergraduate thesis, with the aim of being
simple and intuitive for passengers and drivers to use.

## 📌 Table of Contents

- [Features](#features)

- [ScreenShots](#screenshots-)

- [Dependencies](#dependencies)

- [Installation](#installation)

    - [Setup Flutter](#1-setup-flutter)
    - [Clone the Repository](#2-clone-the-repository)
    - [Setup the Firebase App](#3-setup-the-firebase-app)
    - [Running on Android](#4-running-on-android--we-are-doing-this-just-for-android-platform-)

- [Contributing](#contributing-)

- [Authors](#authors)

- [License](#license)

## Features

<details>
<summary>Passenger</summary>

- Register, edit and delete your own account
- View all available bus routes
- View the location of buses in real time
- View bus stops in the city
- View line timetables by clicking on a bus stop
- Contact the police or emergency services
    - In the event of a crime or emergency.
  </details>

<details>
<summary>Driver</summary>

- Accessing the application
    - The account must have been previously created on
      the [Connect Bus Web](https://github.com/jenniferVC/connect-bus-web)
- Identify the bus you are driving
- Define the route they are taking
- Define the physical state of the bus
    - The physical state options are Normal, Broken, Accident and Congestion
- Activate location tracking
    - For passengers to see the bus moving in real time.
- Contact the police or emergency services
    - In the event of a crime or emergency.

</details>

## ScreenShots 📸

<details>
<summary>Passenger</summary>

| **Register, edit and delete your own account**                | **View all available bus routes**                             |
|---------------------------------------------------------------|---------------------------------------------------------------|
| <img src="./assets/images/gifs/passenger/p1.gif" width="250"> | <img src="./assets/images/gifs/passenger/p2.gif" width="250"> |

| **View the location of buses in real time**                   | **View line timetables by clicking on a bus stop** |
|---------------------------------------------------------------|----------------------------------------------------|
| <img src="./assets/images/gifs/passenger/p3.gif" width="250"> | <img src="./assets/images/gifs/passenger/p4.gif">  |
| **Contact the police or emergency services**                  |
| <img src="./assets/images/gifs/passenger/p5.gif" width="250"> |

</details>

<details>
<summary>Driver</summary>

| **Accessing the application**                              | **Define the route they are taking**                       |
|------------------------------------------------------------|------------------------------------------------------------|
| <img src="./assets/images/gifs/driver/d1.gif" width="250"> | <img src="./assets/images/gifs/driver/d2.gif" width="250"> |

| **Define the physical state of the bus**                   | **Activate location tracking**                 |
|------------------------------------------------------------|------------------------------------------------|
| <img src="./assets/images/gifs/driver/d3.gif" width="250"> | <img src="./assets/images/gifs/driver/d4.gif"> |
| **Contact the police or emergency services**               |
| <img src="./assets/images/gifs/driver/d5.gif" width="250"> |

</details>

## Dependencies

- [Flutter](https://flutter.dev/)
- [Firestore](https://pub.dev/packages/cloud_firestore)
- [Location](https://pub.dev/packages/location)
- [Firebase Auth](https://github.com/flutter/plugins/tree/master/packages/firebase_auth)
- [Firebase Database](https://pub.dev/packages/firebase_database)
- [Google Maps](https://pub.dev/packages/google_maps_flutter)
- [Provider](https://pub.dev/packages/provider)
- [Geolocator](https://pub.dev/packages/geolocator)
- [Flutter Config](https://pub.dev/packages/flutter_config)

## Installation

Follow these steps to install and run ConnectBus on your system.

### 1. [Setup Flutter](https://flutter.dev/docs/get-started/install)

### 2. Clone the Repository

1. Open your terminal or command prompt.

2. Use the following command to clone the ConnectBus repository:

```sh
$ git clone https://github.com/jenniferVC/connect_bus.git
$ cd connect_bus/
```

### 3. Setup the Firebase App

1. You'll need to create a Firebase instance. Follow the instructions
   at https://firebase.google.com/docs/firestore/quickstart.
2. Once your Firebase instance is created, you'll need to enable Google authentication.

- Go to the Firebase Console for your new instance.
- Click "Authentication" in the left-hand menu
- Click the "sign-in method" tab
- Click "Email/Password" and enable it

### 4. Running on Android (We are doing this just for Android Platform)

- Copy the information from the **.env.example** file
- Create a file and name it **.env** and paste the copied information
- Go to [Google API](https://console.developers.google.com/) and Enable **Maps SDK for Android** and
  get the API Key.
- In the **.env** file paste the API Key into the environment variable **ANDROID_MAPS_APIKEY**
- Now you can finally run VS-Code or Android Studio whichever you prefer and get the flutter
  packages and just run the App.

## Contributing ❤️

Thank you for choosing ConnectBus! If you encounter any issues or have suggestions for improvements,
please don't hesitate to [create an issue](https://github.com/jenniferVC/connect-bus/issues). We
look forward to your feedback and collaboration.

Please star⭐ the repo if you like it.

## License

Connect Bus is licensed under the [License Type](./LICENSE)

## Authors

| [<img src="https://avatars.githubusercontent.com/u/64858624?v=4" width=115><br><sub>Jennifer Vasconcelos</sub>](https://github.com/jenniferVC) | [<img src="https://avatars.githubusercontent.com/u/88093974?v=4" width=115><br><sub>Pedro Ferreira</sub>](https://github.com/phsFerreira) |
|:----------------------------------------------------------------------------------------------------------------------------------------------:|:-----------------------------------------------------------------------------------------------------------------------------------------:|
