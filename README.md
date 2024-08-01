# Call Logs & SMS Inbox App

This Flutter application displays the call logs and SMS inbox of the user's device. It utilizes the `call_log`, `flutter_sms_inbox`, and `permission_handler` packages to retrieve the call logs and SMS messages.

The app consists of two screens: Call Logs and SMS Inbox. The user can switch between these screens using a bottom navigation bar.

## Features

- Display the call logs with caller information and call details.
- Display the SMS inbox with sender information and message content.
- Pull to refresh the SMS inbox to fetch the latest messages.
- Request permission to access SMS data if not granted.

## Dependencies

The following packages are used in this application:

- `call_log: ^5.0.1` - Retrieves call logs from the device.
- `flutter_sms_inbox: ^2.1.0` - Retrieves SMS messages from the device.
- `permission_handler: ^13.2.0` - Handles runtime permissions for accessing SMS data.

## Getting Started

To run the application, follow these steps:

1. Make sure you have Flutter installed on your machine. If not, refer to the Flutter documentation for installation instructions.

2. Clone this repository to your local machine: git clone https://github.com/dsasank04/Call-Message-Log.git

3. Navigate to the project directory

4. Retrieve the dependencies by running the following command: flutter pub get

5. Connect your Android or iOS device to your development machine.

6. Run the app using the following command: flutter run

This will launch the app on your connected device.

7. Explore the Call Logs and SMS Inbox screens in the app.





