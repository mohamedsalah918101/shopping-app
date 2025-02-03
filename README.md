# Shopping App Flutter

This repository contains a Flutter application designed to demonstrate a shopping interface.

## Features
1. **Localization**:
   - Added support for Arabic and English languages using the `easy_localization` package.
   - Easily switch between languages within the app.
   - Language files are stored in the `languages` directory.
2. **Responsive UI**:
   - Uses `mediaQuery` for dynamic layout.
3. **Form with Validation**:
   - Full name field: Ensures the first letter is capitalized.
   - Email field: Validates the presence of "@".
   - Password field: Requires a minimum of 6 characters.
   - Confirm password field: Ensures it matches the password.
4. **Product Carousel**:
   - Showcases products using `PageView`.
5. **Product Grid**:
   - Displays product cards with an 'Add to Cart' feature.
6. **Hot Offers Section**:
   - `ListView.builder` displays offers in a horizontally scrollable format.
7. **Fade Animation**:
   - Introduces a fade-in effect for elements as they appear on the screen.
8. **Firebase Auth**:
   - Adding Firebase Authentication to the app.
9. **Biometric Authentication**:
   - Biometric authentication for profile access.

## Instructions
1. Add your translation JSON files:
   - Create `ar-EG.json` for Arabic and `en-US.json` for English in the `languages` directory.
2. Run the app:
   - Use `flutter run`.
   - View the main shopping interface.
3. To switch languages:
   - Implement language toggle functionality in the app using `context.setLocale()`.

## Code Explanation
- **Localization**:
   - `easy_localization` integrates language switching.
   - Ensure `EasyLocalization` wraps your `MaterialApp`.
   - Set supported locales in your app configuration.
- The `ShoppingPage` is the main widget containing all UI elements.
- `PageView`, `GridView`, and `ListView.builder` manage the dynamic UI.
- **Fade Animation**:
   - Smooth transitions are implemented using `PageTransition Package`.

## Dependencies
- `easy_localization: ^3.0.7`
- `page_transition: ^2.2.1`
- `firebase_core: ^3.10.1`
- `firebase_auth: ^5.4.1`
- `local_auth: ^2.3.0`
- `cached_network_image: ^3.4.1`
