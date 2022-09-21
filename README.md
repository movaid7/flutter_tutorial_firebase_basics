# Flutter × Firebase

### Based on (playlist)

[![Flutter × Firebase](https://img.youtube.com/vi/PBxbWZZTG2Q/0.jpg)](https://www.youtube.com/playlist?list=PLlvRDpXh1Se4wZWOWs8yapI8AS_fwDHzf "Flutter × Firebase")


### Learnings

- Setting up Firebase with a Flutter app using the FlutterFire CLI as per [Firebase docs](https://firebase.google.com/docs/flutter/setup)

- Authenticating users with Firebase Autentication
  - Sign in and register new users
  - Forgot and reset password
  
- CRUD operations on Firestore Database data
  - Setting the users UID as documentID when writing data; for easier lookups
  
    ```dart
    .doc(FirebaseAuth.instance.currentUser!.uid)
    ```

- Retrieving, storing and referencing device token for Firebase Cloud Messaging (FCM) - app notifications
  - iOS requires additional config to request notification permission from user
  
    Alternatively [Provisional authorization](https://firebase.flutter.dev/docs/messaging/permissions/#provisional-authorization) can be used
    ```dart
    NotificationSettings settings = await messaging.requestPermission(provisional: true);
    ```

-  Handling of Firebase errors on the frontend (e.g. incorrect password length, invalid email address)
