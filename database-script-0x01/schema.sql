-- Creating the User Table
CREATE TABLE User (
    user_id UUID PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(15),
    role ENUM('guest', 'host', 'admin') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Creating the Location Table
CREATE TABLE Location (
    location_id UUID PRIMARY KEY,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100),
    country VARCHAR(100) NOT NULL
);

-- Creating the Property Table
CREATE TABLE Property (
    property_id UUID PRIMARY KEY,
    host_id UUID NOT NULL,
    name VARCHAR(150) NOT NULL,
    description TEXT NOT NULL,
    pricepernight DECIMAL(10, 2) NOT NULL,
    location_id UUID NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (host_id) REFERENCES User(user_id) ON DELETE CASCADE,
    FOREIGN KEY (location_id) REFERENCES Location(location_id) ON DELETE CASCADE
);

-- Creating the Availability Table
CREATE TABLE Availability (
    availability_id UUID PRIMARY KEY,
    property_id UUID NOT NULL,
    available_date DATE NOT NULL,
    FOREIGN KEY (property_id) REFERENCES Property(property_id) ON DELETE CASCADE,
    UNIQUE (property_id, available_date) -- Prevent duplicate availability entries
);

-- Creating the Booking Table
CREATE TABLE Booking (
    booking_id UUID PRIMARY KEY,
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status ENUM('pending', 'confirmed', 'canceled') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES Property(property_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES User(user_id) ON DELETE CASCADE
);

-- Creating the PaymentMethod Table
CREATE TABLE PaymentMethod (
    payment_method_id UUID PRIMARY KEY,
    method_name ENUM('credit_card', 'paypal', 'stripe') NOT NULL
);

-- Creating the Payment Table
CREATE TABLE Payment (
    payment_id UUID PRIMARY KEY,
    booking_id UUID NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method_id UUID NOT NULL,
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id) ON DELETE CASCADE,
    FOREIGN KEY (payment_method_id) REFERENCES PaymentMethod(payment_method_id) ON DELETE CASCADE
);

-- Creating the Review Table
CREATE TABLE Review (
    review_id UUID PRIMARY KEY,
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES Property(property_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES User(user_id) ON DELETE CASCADE
);

-- Creating the Message Table
CREATE TABLE Message (
    message_id UUID PRIMARY KEY,
    sender_id UUID NOT NULL,
    recipient_id UUID NOT NULL,
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES User(user_id) ON DELETE CASCADE,
    FOREIGN KEY (recipient_id) REFERENCES User(user_id) ON DELETE CASCADE
);

-- Indexing for Optimization
CREATE INDEX idx_email ON User(email); -- Optimize user lookups by email
CREATE INDEX idx_property_location ON Property(location_id); -- Optimize location-based property searches
CREATE INDEX idx_booking_status ON Booking(status); -- Optimize queries by booking status
CREATE INDEX idx_review_property ON Review(property_id); -- Optimize property review retrieval
CREATE INDEX idx_message_sender ON Message(sender_id); -- Optimize sender message retrieval
CREATE INDEX idx_message_recipient ON Message(recipient_id); -- Optimize recipient message retrieval
