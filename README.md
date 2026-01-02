# **Mini User & Task Manager — Flutter App**

This is a simple Flutter application built as part of a technical assessment.
The goal of the project is to demonstrate real-world Flutter skills using:

* REST API integration
* Provider state management
* Local storage with Hive
* Clean and readable code structure

The app allows users to view a list of users from a public API, open their details, and create local tasks for each user.

# **🚀 Features**

### 👤 Users

* Fetch users from a public REST API (JSONPlaceholder)
* Display user list with name & email
* View user details on a separate screen

### 📝 Tasks

* Create tasks for a specific user
* Tasks are stored locally using Hive
* Tasks persist even after restarting the app
* Show all tasks created for that user
* Handle “no tasks” states gracefully

### 💡 UX / UI

* Simple and clean layout 
* Loading indicators 
* Error messages 
* Empty-state handling

# ** 🛠️ Tech Stack & Packages
| Purpose          | Package                          |
| ---------------- | -------------------------------- |
| HTTP requests    | `http`                           |
| State management | `provider`                       |
| Local storage    | `hive`, `hive_flutter`           |
| Code generation  | `hive_generator`, `build_runner` |

# **📂 Project Structure**

The project follows a simple and understandable structure:

lib/

├── models/          
├── services/        
├── providers/       
├── screens/         
├── hive/            
└── main.dart


👉 I kept the structure clean but not over-engineered, so it remains easy to understand and scale.

# **🌍 API Used**

Users are fetched from:

https://jsonplaceholder.typicode.com/users


This API is widely used for testing and development and requires no authentication.

# **🧠 Architecture Decisions**
### Provider

I chose Provider because it is lightweight, easy to understand, and ideal for small to medium apps:

* separates UI from logic 
* reactive updates 
* minimal boilerplate

### Hive

I used Hive for tasks storage because:

* very fast local database 
* works offline 
* no SQL queries required 
* perfect for small structured data

Each task is stored with:

* userId 
* task title 
* created date

# **▶️ How to Run the Project**
### 1️⃣ Install dependencies

flutter pub get

### 2️⃣ Generate Hive adapters
flutter packages pub run build_runner build --delete-conflicting-outputs

### ️⃣ Run the app
flutter run

# **📌 Possible Improvements (Future Work)**


* Task completion toggle 
* Paging for user list 
* Better UI styling 
* Dark mode 
* Unit tests

# **🎯 Summary**

This project demonstrates:

* clean REST API integration 
* proper state management using Provider 
* persistent local storage using Hive 
* clean code separation 
* ability to handle real-world app scenarios
