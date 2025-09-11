import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:flutter/foundation.dart';

class OneSignalService {
  static OneSignalService? _instance;
  static OneSignalService get instance =>
      _instance ??= OneSignalService._internal();

  OneSignalService._internal();

  // Initialize OneSignal
  Future<void> initialize({required String appId}) async {
    try {
      // Remove this method to stop OneSignal Debugging
      if (kDebugMode) {
        OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
      }

      // OneSignal Initialization
      OneSignal.initialize(appId);

      // Request notification permissions
      await requestPermission();

      // Setup notification handlers
      _setupNotificationHandlers();

      if (kDebugMode) {
        print("OneSignal initialized successfully");
      }
    } catch (e) {
      if (kDebugMode) {
        print("OneSignal initialization error: $e");
      }
    }
  }

  // Request notification permission
  Future<bool> requestPermission() async {
    try {
      final permission = await OneSignal.Notifications.requestPermission(true);
      if (kDebugMode) {
        print("Notification permission granted: $permission");
      }
      return permission;
    } catch (e) {
      if (kDebugMode) {
        print("Error requesting permission: $e");
      }
      return false;
    }
  }

  // Get device ID (Subscription ID)
  Future<String?> getDeviceId() async {
    try {
      final subscriptionId = OneSignal.User.pushSubscription.id;
      if (kDebugMode) {
        print("Device ID (Subscription ID): $subscriptionId");
      }
      return subscriptionId;
    } catch (e) {
      if (kDebugMode) {
        print("Error getting device ID: $e");
      }
      return null;
    }
  }

  // Get player ID (User ID)
  String? getPlayerId() {
    try {
      final onesignalId = OneSignal.User.pushSubscription.id;
      if (kDebugMode) {
        print("OneSignal User ID: $onesignalId");
      }
      return onesignalId;
    } catch (e) {
      if (kDebugMode) {
        print("Error getting player ID: $e");
      }
      return null;
    }
  }

  // Set external user ID
  Future<void> setExternalUserId(String userId) async {
    try {
      await OneSignal.login(userId);
      if (kDebugMode) {
        print("External user ID set: $userId");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error setting external user ID: $e");
      }
    }
  }

  // Add tags
  Future<void> addTags(Map<String, String> tags) async {
    try {
      OneSignal.User.addTags(tags);
      if (kDebugMode) {
        print("Tags added: $tags");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error adding tags: $e");
      }
    }
  }

  // Remove tags
  Future<void> removeTags(List<String> tagKeys) async {
    try {
      OneSignal.User.removeTags(tagKeys);
      if (kDebugMode) {
        print("Tags removed: $tagKeys");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error removing tags: $e");
      }
    }
  }

  // Setup notification event handlers
  void _setupNotificationHandlers() {
    // Handle notification received while app is in foreground
    OneSignal.Notifications.addForegroundWillDisplayListener((event) {
      if (kDebugMode) {
        print(
          "Notification received in foreground: ${event.notification.title}",
        );
      }

      // Display the notification
      event.preventDefault();
      event.notification.display();
    });

    // Handle notification opened/clicked
    OneSignal.Notifications.addClickListener((event) {
      if (kDebugMode) {
        print("Notification clicked: ${event.notification.title}");
        print("Additional data: ${event.notification.additionalData}");
      }

      // Handle notification click action here
      _handleNotificationClick(event.notification);
    });

    // Handle permission changes
    OneSignal.Notifications.addPermissionObserver((state) {
      if (kDebugMode) {
        print("Permission state changed: $state");
      }
    });

    // Handle subscription changes
    OneSignal.User.pushSubscription.addObserver((state) {
      if (kDebugMode) {
        print(
          "Push subscription state changed: ${state.current.jsonRepresentation()}",
        );
      }
    });
  }

  // Handle notification click
  void _handleNotificationClick(OSNotification notification) {
    // Implement your notification click handling logic here
    final additionalData = notification.additionalData;

    if (additionalData != null) {
      // Handle different notification types based on additional data
      if (additionalData.containsKey('screen')) {
        final screen = additionalData['screen'];
        if (kDebugMode) {
          print("Navigate to screen: $screen");
        }
        // Add navigation logic here
      }
    }
  }

  // Send notification (for testing - usually done from backend)
  Future<void> sendNotificationToUser({
    required String userId,
    required String title,
    required String message,
    Map<String, dynamic>? additionalData,
  }) async {
    try {
      // This is typically done from your backend
      // Including here for testing purposes only
      if (kDebugMode) {
        print(
          "Note: Send notifications from your backend server, not from the app",
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error sending notification: $e");
      }
    }
  }

  // Clear all notifications
  Future<void> clearAllNotifications() async {
    try {
      OneSignal.Notifications.clearAll();
      if (kDebugMode) {
        print("All notifications cleared");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error clearing notifications: $e");
      }
    }
  }

  // Logout user
  Future<void> logout() async {
    try {
      await OneSignal.logout();
      if (kDebugMode) {
        print("User logged out from OneSignal");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error logging out: $e");
      }
    }
  }
}
