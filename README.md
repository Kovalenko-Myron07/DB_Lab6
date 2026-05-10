# Лабораторна робота №6 | Міграції

Цей файл документує зміни, внесені до схеми бази даних (`schema.prisma`) в рамках лабораторної роботи №6.

## 1. Додавання нової таблиці (maintenance_log)

**Опис:** Створено нову модель `maintenance_log` для фіксації ремонтів та обслуговування майна.

Встановлено зв'язки:
* Одне майно (`asset`) може мати багато записів про ремонт (`maintenance_log`).

**Зміни в `schema.prisma`:**

```prisma
// НОВА МОДЕЛЬ
model maintenance_log {
  logid       Int      @id @default(autoincrement())
  assetid     Int
  description String   @db.Text
  logdate     DateTime @default(now()) @db.Date
  asset       asset    @relation(fields: [assetid], references: [assetid], onDelete: NoAction, onUpdate: NoAction)
}

// ОНОВЛЕННЯ ІСНУЮЧОЇ МОДЕЛІ
model asset {
  assetid          Int                @id
  // ... інші поля
  maintenance_log  maintenance_log[]  // Зворотній зв'язок
}
```
## 2. Модифікація таблиці asset
Додано нове необов'язкове поле condition для відстеження фізичного стану обладнання.

Попередня структура:
```model asset {
  assetid          Int                @id
  inventorynumber  String             @unique @db.VarChar(50)
  assetname        String             @db.VarChar(200)
  price            Decimal?           @db.Decimal(10, 2)
  categoryid       Int
}
```
Оновлена структура:
```model asset {
  assetid          Int                @id
  inventorynumber  String             @unique @db.VarChar(50)
  assetname        String             @db.VarChar(200)
  price            Decimal?           @db.Decimal(10, 2)
  condition        String?            @db.VarChar(50) // Нове поле (Optional)
  categoryid       Int
}
```
## 3. Видалення стовпця з таблиці room
З метою оптимізації схеми та усунення надмірності було видалено поле roomname, оскільки для ідентифікації кабінету достатньо його номера (roomnumber).

## 4. Розширення таблиці employee та унікальність
Додано поле email із застосуванням обмеження на рівні бази даних для запобігання дублюванню.
Оновлена структура:
```
model employee {
  employeeid       Int                @id
  fullname         String             @db.VarChar(150)
  position         String             @db.VarChar(100)
  email            String?            @unique @db.VarChar(100) // Унікальне поле
}
```
## 5. Створення таблиці department та зв'язку
Опис: Створено таблицю-довідник department для нормалізації даних про структуру установи.
Зміни в schema.prisma:
```
// НОВА МОДЕЛЬ
model department {
  departmentid Int        @id @default(autoincrement())
  name         String     @db.VarChar(100)
  employees    employee[]
}

// ОНОВЛЕННЯ МОДЕЛІ ПРАЦІВНИКІВ
model employee {
  // ... інші поля
  departmentid     Int?               
  department       department?        @relation(fields: [departmentid], references: [departmentid], onDelete: NoAction, onUpdate: NoAction)
}
```
## 6. Перевірка та верифікація
Для підтвердження успішного застосування 5 міграцій використано інструмент Prisma Studio.
Результати перевірки:

Таблиці maintenance_log та department доступні для CRUD-операцій.

Поле email відображається в таблиці employee.

Поле roomname повністю видалено з фізичної структури БД.

Цілісність існуючих даних (категорії, майно) повністю збережена.

Усі 5 змін зафіксовані окремими кроками в локальній папці prisma/migrations.
<img width="1863" height="731" alt="image" src="https://github.com/user-attachments/assets/77631608-ded2-4c43-bda0-f7210b800ef8" />
