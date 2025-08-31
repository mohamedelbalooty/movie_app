# Flutter TMDB People App

This project is a Flutter application that integrates with the **TMDB API** to display popular people, their details, and related images.  
The app demonstrates clean architecture (Domain, Data, and Presentation layers), API integration, pagination, caching, and testing.

---

## ✨ Features
- **Popular People Page**  
  Displays a paginated list of popular people fetched from TMDB API.

- **Person Details Page**  
  Shows basic information about a selected person.

- **Person Images Page**  
  Displays a grid view of images related to the selected person.

- **Image Download Feature**  
  Allows users to download images to their device with support for both Android & iOS.

- **Offline Caching**  
  When there is **no internet connection**, the app retrieves cached data using **SharedPreferences** as a simple caching mechanism.

---

## 🏗️ Architecture
The app is built with **Clean Architecture**:
- **Data Layer** → Remote (API calls) + Local (SharedPreferences cache)
- **Domain Layer** → Entities + Repositories + Use Cases
- **Presentation Layer** → Flutter UI (Popular People, Person Details, Person Images pages)

---

## 🔑 API Integration
- All API calls are done using **TMDB API**.
- API Key is stored in `api_constants.dart` file for **easy setup** (not in `.env` file), so reviewers can directly run the project without extra configuration.

---

## 🧪 Testing
- Unit tests for **Domain layer** (use cases & repositories).
- Unit tests for **Data layer** (remote & local data sources).
- Integration tests for API calls and caching behavior.

---

## 🌐 Git Flow
- The project uses a **simple Git Flow strategy** with two main branches:
    - `master` → Stable production-ready branch.
    - `development` → Main development branch.

### Workflow:
1. Create a feature branch from `development`.
2. Develop and test the feature.
3. Open a Pull Request (PR) from feature branch → `development`.
4. After reviewing and finalizing, create a Pull Request from `development` → `master`.
5. Merge the PR into `master` once approved.

---

## 📱 Result
The final application includes:
1. **Popular People Page** with pagination.
2. **Person Details Page** with personal info.
3. **Person Images Page** with grid view and download feature.
4. **Offline support** with caching using SharedPreferences.

---

## 🚀 How to Run
1. Clone the repository:
   ```bash
   git clone <repo_url>
