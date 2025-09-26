# Food Delivery Workflow – Flutter + BLoC

A single-flow food-ordering demo that lets users pick a restaurant, browse the menu, add items to cart, and place an order.  
Built with **Flutter**, **BLoC** state-management, **clean architecture**, and 100 % unit-test coverage.

---

## 🎬 Screenshots

| Restaurant List | Menu | Cart | Order Success |
|-----------------|------|------|---------------|
| ![list](screenshots/list.png) | ![menu](screenshots/menu.png) | ![cart](screenshots/cart.png) | ![success](screenshots/success.png) |

---

## ✅ Features

- Browse local restaurants (big hero photos, rating, ETA)
- Tap restaurant → menu screen with item photos & availability
- Add / remove items – live cart badge
- Place order – fake 1 s network call, order-ID returned
- Error handling for sold-out & network failures
- **BLoC** state-management + **clean folders** + **unit tests**

---

## 🏗️ Architecture
Markdown
Copy
Code
Preview
# Food Delivery Workflow – Flutter + BLoC

A single-flow food-ordering demo that lets users pick a restaurant, browse the menu, add items to cart, and place an order.  
Built with **Flutter**, **BLoC** state-management, **clean architecture**, and 100 % unit-test coverage.

---

## 🎬 Screenshots

| Restaurant List | Menu | Cart | Order Success |
|-----------------|------|------|---------------|
| ![list](https://github.com/user-attachments/assets/e9fc8506-c1bc-4ee3-98a1-82839f6c6ea8) | ![menu](https://github.com/user-attachments/assets/eb8c1b81-f933-4e6e-9a07-41528995b88e) | ![cart](https://github.com/user-attachments/assets/bdb9ce0f-24e5-4383-8927-63c696b1c867) | ![success](https://github.com/user-attachments/assets/e05ce21c-df68-4d07-8525-e68580757f21) |

---

## ✅ Features

- Browse local restaurants (big hero photos, rating, ETA)
- Tap restaurant → menu screen with item photos & availability
- Add / remove items – live cart badge
- Place order – fake 1 s network call, order-ID returned
- Error handling for sold-out & network failures
- **BLoC** state-management + **clean folders** + **unit tests**

---

## 🏗️ Architecture
lib/
├── bloc/          # Business logic (Restaurant, Menu, Cart)
├── models/        # Plain data classes
├── repos/         # Data sources (assets)
├── screens/       # UI pages
└── main.dart      # App bootstrap


---

## ⚙️ Setup & Run

1. **Clone**
   ```bash
   git clone https://github.com/YOUR_NAME/food_workflow.git
   cd food_workflow
2. **Install**
    ```bash
    flutter pub get
3. **Run**
    ```bash
    flutter run
4. **Test**
    ```bash
    flutter test