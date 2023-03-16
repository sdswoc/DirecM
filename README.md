

# DirecM
This is my proposal for woc(2023)

## About
DirecM is an app that is designed to be used by visually impaired and blind people. It is a wayfinding app that helps its user to navigate routes and eliminates the use of external assistance like blind canes and service dogs as not everyone can afford or have access to these.This app uses a basic hardware module involving arduino nano that detects obstacles in the user's path and informs them and also guides them throughout their journey using voice output.

## How to Install

### App

Clone the repository to your local machine using the command
 > git clone (SSH key)
  
Add the following dependencies in your pubspec.yaml
  - flutter_tts: ^3.6.3.
  - geocoding: ^2.0.5.
  - geolocator: ^9.0.2
  - camera: ^0.10.3+1
  - dio: ^5.0.0
  - get_it: ^7.2.0
  - dartz: ^0.10.1
  - equatable: ^2.0.5
  - flutter_bloc: ^8.1.2
  - tflite_flutter: ^0.9.0
  - image_picker: ^0.7.4
  - tflite_flutter_helper:
  - flutter_bluetooth_serial: ^0.4.0
  - scoped_model: ^2.0.0-nullsafety.0
  - sqlite3_flutter_libs: ^0.4.2

Then use the pub get to get dependencies and install the application in your device

### Arduino
Ensemble your external module by using arduino nano, hc-05 bluetooth module, sr-04 ultrasonic sensor, breadboard and male to male jumper wires.
Connect your module to your laptop and upload the arduino code on it.

## Usage
After setting up the app and the arduino you are good to go, just select the hc-05 module in the list of discoverable devices and use the 3 buttons on the follow up page to help you navigate, one button detects the obstacle near you using real-time object detection, another detects the output from the arduino which tells you the distance of obstacles in your path , and the last button detects your current location using gps and helps in guiding you with different routes.
You will get the audio output of you location, the distance you have to go, when to take a turn, when an obstacle near you and detects the object as well.


