![alt text](https://github.com/SirishC/journal/blob/master/assets/images/logo.png)
# Introspective Journal
A digital diary for introspecting once selves.
## Getting Started

Introspective Journal  is a cloud-enabled, mobile-ready, offline-storage, Flutter powered application which helps you to introspect you emotions over a period of time.


# Features!

  - Users can log each day just like Diary Writting.
  - A day might have a mixed feeling so the user can select a text and can tag the selected text based on Emotion , People , Place and Custom.
  - Based on the tags the application lets you know the overall emotion over a period of time.

# Structure of Data stored.

#### Class holding the entire data .
```dart
/// Overall Data.
class Data {
  List<DailyFeeds> dailyFeeds = [
    DailyFeeds(formatDate(DateTime.now(), [ M, ',', dd, ',', yyyy]),)
  ];
  add(date) {
    DailyFeeds newfeed = DailyFeeds(date);
    this.dailyFeeds.add(newfeed);
  }
  bool isContains(date) {
    for (int i = 0; i < dailyFeeds.length; i++) {
      if (dailyFeeds[i].date == date) {
        return true;
      }
    }
    return false;
  }
  int getItemByDate(date) {
    for (int i = 0; i < dailyFeeds.length; i++) {
      if (dailyFeeds[i].date == date) {
        return i;
      }
    }
    return -1;
  }
}

/// Object containing overall data .
Data data = new Data();
```

# Todo.
- [shared_preferences 0.5.7](https://pub.dev/packages/shared_preferences) not been implemented yet so data is lost once you close the application.
- UI Changes.
- Statistic view of users monthly logs.


## Get packages from here [Pub.dev](https://pub.dev).

