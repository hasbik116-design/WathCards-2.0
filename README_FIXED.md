# WatchCards v0.6 — исправленная сборка

Исправлена критическая ошибка Apple Watch target:
- Shared/Models.swift и Shared/WatchSyncPayload.swift теперь входят в Sources Apple Watch target.
- Из Sources Apple Watch target удалены ошибочно добавленные ссылки на готовые .app продукты.
- iPhone target сохранён без изменений.
- Codemagic проверяет отдельно iPhone Simulator и Apple Watch Simulator без code signing.

## Как заменить проект на GitHub
Самый простой вариант: удалить старые папки/файлы проекта в репозитории и загрузить содержимое этой папки в корень:
- iPhone
- Watch
- Shared
- WatchCards.xcodeproj
- codemagic.yaml

После commit запустить новый build в Codemagic.
