# Flutter Plant App


## Screenshots

| Plant shop | Discover |
| :---: | :---: |
| <img src="docs/screenshots/plant-shop.jpg" alt="Plant shop with plant categories and accessories" width="280"> | <img src="docs/screenshots/discover.jpg" alt="Discover dashboard with plant recognition, diagnosis, and light meter" width="280"> |

| My plants | Care schedule |
| :---: | :---: |
| <img src="docs/screenshots/my-plants.jpg" alt="My plants organized into indoor and outdoor sites" width="280"> | <img src="docs/screenshots/care-schedule.jpg" alt="Plant care schedule with watering and misting reminders" width="280"> |

## Local configuration

Provide your own Firebase configuration in android/app/google-services.json (excluded from Git). Set GOOGLE_MAPS_API_KEY and WEATHER_API_KEY using Flutter --dart-define options. Replace the Google Maps placeholder in AndroidManifest.xml and the Facebook client token placeholder in android/app/src/main/res/values/string.xml before running those integrations. PlantNet credentials are configured inside the app.
