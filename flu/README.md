# flu

A new Flutter project.

## Getting Started

For help getting started with Flutter development, view the online
[documentation](https://flutter.dev/).

For instructions integrating Flutter modules to your existing applications,
see the [add-to-app documentation](https://flutter.dev/docs/development/add-to-app).

### 设置版本号仅编译release aar

flutter build aar --no-debug --no-profile --build-number=1.0.0

### 设置web baseUrl

flutter build web --base-href=/static/web/

flutter pub run build_runner build --delete-conflicting-outputs

flutter gen-l10n