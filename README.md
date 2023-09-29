# TrailTales
## Problem

Hikers and outdoor enthusiasts lack a comprehensive and user-friendly iOS application for documenting their hiking experiences and creating visually appealing journals. The existing hiking journal apps offer limited functionality and fail to meet the needs of nature lovers and outdoor influencers. There is a demand for an iOS app that seamlessly integrates text and photo entries, prioritizes user privacy, maintains an aesthetic connection with Apple's design principles, and caters to both one-time purchase users and those interested in subscribing for additional features.

## Solution

The solution to this problem is the development of a feature-rich iOS hiking journal app that addresses these challenges and objectives. This app will provide a valuable tool for hikers to document their experiences and share them with the world, all while adhering to high standards of user experience and privacy.

## Architecture

TrailTales is built using the MVVM (Model-View-ViewModel) architectural pattern, which separates the app's components into three key layers:

### Model:
Represents the data and business logic of the app. In TrailTales, the models are responsible for defining the structure of hikes and user data. The Hike class serves as the model for individual hikes, while the User class represents user data.

### View:
Displays the user interface elements and interacts with the user. SwiftUI is used to create the views in TrailTales, providing a declarative and intuitive way to build the UI.

### ViewModel:
Acts as an intermediary between the Model and View layers. It holds the presentation logic, performs data transformations, and provides data to the views. In TrailTales, the AuthDataProvider and HikeListViewModel are examples of ViewModels that manage user authentication and hike data, respectively.

## Realm Database Integration

TrailTales leverages Realm, a popular mobile database, to store and manage data efficiently. Realm provides a seamless and robust solution for persisting user data, including hikes and user profiles.

Key aspects of Realm integration in TrailTales include:

### Hike Model:
The Hike model is defined using Realm's Object class. It includes properties like name, location, distance, and difficulty, all of which are annotated with @Persisted attributes to indicate that they should be persisted in the Realm database.

Realm Configuration: The app sets up the Realm database using the Realm configuration, ensuring data consistency and reliability.
Data Retrieval and Storage: TrailTales uses Realm to retrieve and store user-specific data, ensuring that each user can only access their own hike entries. The ownerId property in the Hike model is used to link hikes to their respective owners.


## Firebase Authentication

Firebase is integrated into TrailTales to provide a secure and convenient authentication mechanism. Firebase Authentication allows users to create accounts, log in, and protect their data.

Key Firebase Authentication features in TrailTales include:

User Registration: Users can create accounts with their email and password using Firebase Authentication. Upon registration, a user's data is securely stored in Firebase.

User Login: Registered users can log in to their accounts, and Firebase handles the authentication process. The app checks the authentication status using Firebase to determine whether a user is logged in or not.

Logout: TrailTales supports user logout functionality, which securely signs the user out of their Firebase account.

## Conclusion

TrailTales combines the power of MVVM architecture, Realm, and Firebase to create a seamless and secure hiking journal app. The MVVM architecture ensures separation of concerns, making the app maintainable and testable. Realm simplifies data management, while Firebase Authentication provides robust user authentication.

Enjoy your outdoor adventures with TrailTales, where you can record your hikes and cherish the memories!
