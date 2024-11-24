# Database Normalization to 3NF

## Overview
Normalization is the process of organizing data in a database to reduce redundancy and improve data integrity. The goal is to achieve the Third Normal Form (3NF), which requires:
1. The database to be in 1NF (eliminate repeating groups).
2. The database to be in 2NF (eliminate partial dependency on the primary key).
3. The database to be in 3NF (eliminate transitive dependency).

Below are the steps taken to ensure the Airbnb database is normalized to 3NF.

---

## Step 1: Ensure First Normal Form (1NF)
### Requirement:
- Each column contains atomic values.
- Each row is unique (identified by a primary key).
- No repeating groups or arrays.

### Adjustments:
- In the `Property` table, `availability` (list of dates) is not atomic.  
  **Resolution**: Move availability dates to a separate `Availability` table.

#### Updated Schema:
**Availability**
- `availability_id`: Primary Key
- `property_id`: Foreign Key → `Property(property_id)`
- `available_date`: DATE, NOT NULL  

---

## Step 2: Ensure Second Normal Form (2NF)
### Requirement:
- All non-primary key attributes are fully dependent on the primary key.
- Eliminate partial dependencies (dependencies on part of a composite key).

### Adjustments:
- No tables in the schema have composite keys; thus, no partial dependencies exist.

#### No changes were required in this step.

---

## Step 3: Ensure Third Normal Form (3NF)
### Requirement:
- Eliminate transitive dependencies (non-prime attributes depending on other non-prime attributes).

### Adjustments:
1. **Payment Table**:
   - `payment_method` values (e.g., credit_card, PayPal) can potentially be stored as raw text. This creates redundancy if the same method is used across many payments.
   **Resolution**: Create a separate `PaymentMethod` table.

   **Updated Schema**:
   **PaymentMethod**
   - `payment_method_id`: Primary Key
   - `method_name`: ENUM (credit_card, PayPal, Stripe), NOT NULL  

   **Payment**
   - Replace `payment_method` with `payment_method_id` (Foreign Key → `PaymentMethod(payment_method_id)`).

2. **Property Table**:
   - `location` is currently stored as a single field. If `location` contains structured data (e.g., city, state, country), redundancy may occur. 
   **Resolution**: Normalize location into a `Location` table.

   **Updated Schema**:
   **Location**
   - `location_id`: Primary Key
   - `city`: VARCHAR, NOT NULL
   - `state`: VARCHAR, NULL
   - `country`: VARCHAR, NOT NULL  

   **Property**
   - Replace `location` with `location_id` (Foreign Key → `Location(location_id)`).

3. **Review Table**:
   - `rating` directly depends on the property and user but is already normalized as it depends on the composite keys (`property_id`, `user_id`).

#### Final Adjustments:
No further transitive dependencies exist.

---

## Final Normalized Database Design
### Tables:
#### 1. **User**
- `user_id` (Primary Key)
- `first_name`
- `last_name`
- `email`
- `password_hash`
- `phone_number`
- `role`
- `created_at`

#### 2. **Property**
- `property_id` (Primary Key)
- `host_id` (Foreign Key → `User(user_id)`)
- `name`
- `description`
- `pricepernight`
- `location_id` (Foreign Key → `Location(location_id)`)
- `created_at`
- `updated_at`

#### 3. **Location**
- `location_id` (Primary Key)
- `city`
- `state`
- `country`

#### 4. **Availability**
- `availability_id` (Primary Key)
- `property_id` (Foreign Key → `Property(property_id)`)
- `available_date`

#### 5. **Booking**
- `booking_id` (Primary Key)
- `property_id` (Foreign Key → `Property(property_id)`)
- `user_id` (Foreign Key → `User(user_id)`)
- `start_date`
- `end_date`
- `total_price`
- `status`
- `created_at`

#### 6. **Payment**
- `payment_id` (Primary Key)
- `booking_id` (Foreign Key → `Booking(booking_id)`)
- `amount`
- `payment_date`
- `payment_method_id` (Foreign Key → `PaymentMethod(payment_method_id)`)

#### 7. **PaymentMethod**
- `payment_method_id` (Primary Key)
- `method_name`

#### 8. **Review**
- `review_id` (Primary Key)
- `property_id` (Foreign Key → `Property(property_id)`)
- `user_id` (Foreign Key → `User(user_id)`)
- `rating`
- `comment`
- `created_at`

#### 9. **Message**
- `message_id` (Primary Key)
- `sender_id` (Foreign Key → `User(user_id)`)
- `recipient_id` (Foreign Key → `User(user_id)`)
- `message_body`
- `sent_at`

---

## Conclusion
The database design is now in **Third Normal Form (3NF)**. These adjustments reduce redundancy, improve data integrity, and maintain scalability for the Airbnb system.
