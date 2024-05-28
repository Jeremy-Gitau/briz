# Brizz Weather API Documentation

The Brizz Weather API provides endpoints for fetching weather data and forecasts. It offers real-time weather updates, 14-day weather forecasts, and weather alerts.

## Endpoints

### Fetch Current Weather

**Endpoint:** `/forecast`

**Method:** `GET`

**Parameters:**
- `lat`: Latitude of the location.
- `lon`: Longitude of the location.

**Response:**
```json
{
  "forecast": {
    "forecastday": [
      {
        "date": "2024-05-28",
        "day": {
          "maxtemp_c": 25.0,
          "mintemp_c": 15.0,
          "condition": {
            "text": "Partly cloudy",
            "icon": "//cdn.weatherapi.com/weather/64x64/day/116.png"
          }
        }
      }
    ]
  },
  "current": {
    "temp_c": 20.0,
    "temp_f": 68.0,
    "condition": {
      "text": "Clear",
      "icon": "//cdn.weatherapi.com/weather/64x64/night/113.png"
    }
  },
  "location": {
    "name": "San Francisco"
  }
}


