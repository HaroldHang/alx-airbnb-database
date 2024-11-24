-- Seeding the User Table
INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at)
VALUES
    ('a1b2c3d4-e5f6-7890-g1h2-i3j4k5l6m7n8', 'Alice', 'Johnson', 'alice@example.com', 'hashed_password1', '1234567890', 'guest', CURRENT_TIMESTAMP),
    ('b2c3d4e5-f6g7-8901-h2i3-j4k5l6m7n8o9', 'Bob', 'Smith', 'bob@example.com', 'hashed_password2', '0987654321', 'host', CURRENT_TIMESTAMP),
    ('c3d4e5f6-g7h8-9012-i3j4-k5l6m7n8o9p0', 'Charlie', 'Brown', 'charlie@example.com', 'hashed_password3', '1122334455', 'admin', CURRENT_TIMESTAMP);

-- Seeding the Location Table
INSERT INTO Location (location_id, city, state, country)
VALUES
    ('loc1', 'New York', 'NY', 'USA'),
    ('loc2', 'San Francisco', 'CA', 'USA'),
    ('loc3', 'Paris', NULL, 'France');

-- Seeding the Property Table
INSERT INTO Property (property_id, host_id, name, description, pricepernight, location_id, created_at, updated_at)
VALUES
    ('prop1', 'b2c3d4e5-f6g7-8901-h2i3-j4k5l6m7n8o9', 'Cozy Apartment in NYC', 'A beautiful apartment in the heart of NYC.', 150.00, 'loc1', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('prop2', 'b2c3d4e5-f6g7-8901-h2i3-j4k5l6m7n8o9', 'San Francisco Retreat', 'A cozy home with stunning views.', 200.00, 'loc2', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('prop3', 'b2c3d4e5-f6g7-8901-h2i3-j4k5l6m7n8o9', 'Parisian Getaway', 'Charming studio near the Eiffel Tower.', 180.00, 'loc3', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Seeding the Availability Table
INSERT INTO Availability (availability_id, property_id, available_date)
VALUES
    ('avail1', 'prop1', '2024-12-01'),
    ('avail2', 'prop1', '2024-12-02'),
    ('avail3', 'prop2', '2024-12-05'),
    ('avail4', 'prop3', '2024-12-10');

-- Seeding the Booking Table
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at)
VALUES
    ('book1', 'prop1', 'a1b2c3d4-e5f6-7890-g1h2-i3j4k5l6m7n8', '2024-12-01', '2024-12-03', 300.00, 'confirmed', CURRENT_TIMESTAMP),
    ('book2', 'prop2', 'a1b2c3d4-e5f6-7890-g1h2-i3j4k5l6m7n8', '2024-12-05', '2024-12-07', 400.00, 'pending', CURRENT_TIMESTAMP);

-- Seeding the PaymentMethod Table
INSERT INTO PaymentMethod (payment_method_id, method_name)
VALUES
    ('paym1', 'credit_card'),
    ('paym2', 'paypal'),
    ('paym3', 'stripe');

-- Seeding the Payment Table
INSERT INTO Payment (payment_id, booking_id, amount, payment_date, payment_method_id)
VALUES
    ('pay1', 'book1', 300.00, CURRENT_TIMESTAMP, 'paym1'),
    ('pay2', 'book2', 400.00, CURRENT_TIMESTAMP, 'paym2');

-- Seeding the Review Table
INSERT INTO Review (review_id, property_id, user_id, rating, comment, created_at)
VALUES
    ('rev1', 'prop1', 'a1b2c3d4-e5f6-7890-g1h2-i3j4k5l6m7n8', 5, 'Fantastic stay! Highly recommend.', CURRENT_TIMESTAMP),
    ('rev2', 'prop3', 'a1b2c3d4-e5f6-7890-g1h2-i3j4k5l6m7n8', 4, 'Lovely place, but a bit noisy.', CURRENT_TIMESTAMP);

-- Seeding the Message Table
INSERT INTO Message (message_id, sender_id, recipient_id, message_body, sent_at)
VALUES
    ('msg1', 'a1b2c3d4-e5f6-7890-g1h2-i3j4k5l6m7n8', 'b2c3d4e5-f6g7-8901-h2i3-j4k5l6m7n8o9', 'Is the apartment available for these dates?', CURRENT_TIMESTAMP),
    ('msg2', 'b2c3d4e5-f6g7-8901-h2i3-j4k5l6m7n8o9', 'a1b2c3d4-e5f6-7890-g1h2-i3j4k5l6m7n8', 'Yes, it is! Feel free to book.', CURRENT_TIMESTAMP);
