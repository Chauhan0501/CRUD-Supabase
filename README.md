# Supabase CRUD with Clean Architecture

A premium, modern Flutter application for managing notes using Supabase as the backend. This project follows **Clean Architecture** principles and uses **GetX** for state management and navigation.

---

## 🚀 Tech Stack

- **Framework**: [Flutter](https://flutter.dev)
- **Backend**: [Supabase](https://supabase.com) (Authentication & Database)
- **State Management**: [GetX](https://pub.dev/packages/get)
- **Dependency Injection**: [GetIt](https://pub.dev/packages/get_it)
- **Functional Programming**: [Dartz](https://pub.dev/packages/dartz) (for Either type/Error handling)
- **Architecture**: Clean Architecture (Data, Domain, Presentation layers)
- **Styling**: Modern UI with Gradients, Glassmorphism elements, and Custom Shadows.

---

## ✨ Features

- **Onboarding**: A stylish introduction screen.
- **Modern Authentication**:
  - Secure Login & Sign-up using Supabase Auth.
  - **Smart Navigation**: Automatically suggests registration if the user is not found during login.
  - **Session Persistence**: Keeps you logged in even after closing the app.
- **CRUD Operations**:
  - **Create**: Add notes with a title and content.
  - **Read**: View your notes in a beautiful, card-based list.
  - **Update**: Edit existing notes through a modern dialog.
  - **Delete**: Quickly remove notes with one tap.
- **Premium UI/UX**:
  - Vibrant gradient backgrounds.
  - High-end note cards with shadows and professional date formatting.
  - Interactive micro-animations and smooth transitions.

---

## 🏛 Architecture Overview

- **Domain Layer**: The core of the application. Contains Entities, Use Cases, and Repository Interfaces.
- **Data Layer**: Handles data retrieval. Contains Models (DTOs), Repository Implementations, and Remote Data Sources (Supabase integration).
- **Presentation Layer**: The UI and state. Contains GetX Controllers, Bindings, Pages, and Widgets.

---

## 🛠 Setup & Run

### 1. Supabase Configuration
Create a project on [Supabase](https://supabase.com) and run the following SQL script to create the `notes` table:

```sql
create table notes (
  id uuid default gen_random_uuid() primary key,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null,
  title text not null,
  content text not null,
  user_id uuid default auth.uid()
);

-- Enable Row Level Security (RLS)
alter table notes enable row level security;
create policy "Users can only see their own notes" on notes for select using (auth.uid() = user_id);
create policy "Users can insert their own notes" on notes for insert with check (auth.uid() = user_id);
create policy "Users can update their own notes" on notes for update using (auth.uid() = user_id);
create policy "Users can delete their own notes" on notes for delete using (auth.uid() = user_id);
```

### 2. Configure Flutter App
Update the `main.dart` with your Supabase URL and Anon Key:

```dart
await Supabase.initialize(
  url: 'YOUR_SUPABASE_URL',
  anonKey: 'YOUR_SUPABASE_ANON_KEY',
);
```

### 3. Run the project
```bash
flutter pub get
flutter run
```
