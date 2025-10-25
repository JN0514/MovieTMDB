# MovieDB iOS App — README

## Setup
- Obtained TMDB API key and create app configuration
- Project uses Combine and SwiftUI, For playing youtube videos included swift package of YouTubeiOSPlayerHelper.
- Xcode 16.3 (iOS 17+ target) is recommended
- Clone this repo and open the project in Xcode and run the build connecting to a simulator/device

---

## Assumption
- Choose Clean Architecture + MVVM pattern. Though MVVM is sufficient for the project scope, for future changes and extensibility of codebase include Clean Architecture
- Create TMDB account and get API_Key, use postman to check the working of provided APIs response model and Analyse if the model has data to fulfil the task
- Internet connection is needed always, but as fallback, show alert messages for api failures in offline
- User needs a way to handle failed requests
- Favorites can be stored locally using userDefaults
- UI has to be responsive on different screen sizes
- As per TMDB api docs, Movie List screen can support pagination
- Credits API is available for fetching movie casts

---

## Implemented Features

### Movie List
- Displays list of popular movies with Title, rating and poster
- Pagination is supported for popular movie list
- Showb loading indicators during network calls
- Displays network failure messages as alert and allowed user to retry request

### Movie Search
- Supported listing of movies through search by title
- Pagination is supported for searching
- Navigate to Movie detail Screen is allowed from searching screen
- Displays network failure messages as alert and allowed user to retry request

### Movie Detail
- Displays Title, Plot, Genres, Cast, Duration, Rating
- Shows first available trailer and allow user to play the movie trailer in app
- Displays network failure messages as alert and allowed user to retry request

### Favorites
- Indicating favroites visually through heart icon in Movie Listing and Search screen, and with button text in Movie Detail screen
- Movies added to favourites will persist across app relaunches

---

## Known Limitations
- Error handling is basic, simple alert messages are shown for errors
- Favorites stored in UserDefaults, may not scale for large data sets
- Since pagination is implemented, Out of memory exceptions are possible, which is unhandled
- Not providing user to choose there preferred theme
- Youtube videos cannot be played with native iOS API, needs to depend on third party
- User has to be in network if needs to fetch new data, not having local storage to store image caches or app data

