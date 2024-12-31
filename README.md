# Shopping App Flutter

This repository contains a simple Flutter application designed to demonstrate a shopping interface.

## Features:
1. **Responsive UI**: Uses `mediaQuery` for dynamic layout.
2. **Form with Validation**:
  - Full name field: Ensures the first letter is capitalized.
  - Email field: Validates the presence of "@".
  - Password field: Requires a minimum of 6 characters.
  - Confirm password field: Ensures it matches the password.
3. **Product Carousel**: Showcases products using `PageView`.
4. **Product Grid**: Display product cards with an 'Add to Cart' feature.
5. **Hot Offers Section**: ListView builder to display offers horizontally scrollable.
6. **Fade Animation**: Introduces a fade-in effect for elements as they appear on the screen, enhancing the user experience.

## Instructions:
- Run the app using `flutter run`.
- View the main shopping interface.

## Code Explanation:
- The `ShoppingPage` is the main widget containing all the UI elements.
- `PageView`, `GridView`, and `ListView.builder` are used to manage the dynamic UI.
- **Fade Animation**: This effect is applied to various UI components using `PageTransition Package` to create smooth transitions as elements appear on the screen.
