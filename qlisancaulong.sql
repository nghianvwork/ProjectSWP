-- Bảng người dùng
CREATE TABLE Users (
    user_id INT PRIMARY KEY IDENTITY(1,1),
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100),
    phone_number VARCHAR(20),
    role VARCHAR(20) CHECK (role IN ('user', 'admin', 'manager')) DEFAULT 'user',
    created_at DATETIME DEFAULT GETDATE()
);

-- Bảng sân
CREATE TABLE Courts (
    court_id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(100) NOT NULL,
    location VARCHAR(255),
    status VARCHAR(20) CHECK (status IN ('available', 'unavailable')) DEFAULT 'available',
    price_per_hour DECIMAL(10, 2) NOT NULL,
    manager_id INT,
    FOREIGN KEY (manager_id) REFERENCES Users(user_id)
);

-- Bảng đặt sân
CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT NOT NULL,
    court_id INT NOT NULL,
    date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    status VARCHAR(20) CHECK (status IN ('booked', 'cancelled', 'completed')) DEFAULT 'booked',
    paid BIT DEFAULT 0,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (court_id) REFERENCES Courts(court_id)
);

-- Bảng thiết bị
CREATE TABLE Equipments (
    equipment_id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    quantity INT NOT NULL
);

-- Bảng thiết bị được đặt theo booking
CREATE TABLE Booking_Equipments (
    id INT PRIMARY KEY IDENTITY(1,1),
    booking_id INT NOT NULL,
    equipment_id INT NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id),
    FOREIGN KEY (equipment_id) REFERENCES Equipments(equipment_id)
);

-- Bảng bài viết
CREATE TABLE Posts (
    post_id INT PRIMARY KEY IDENTITY(1,1),
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    created_by INT NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    type VARCHAR(20) CHECK (type IN ('news', 'match', 'event')),
    FOREIGN KEY (created_by) REFERENCES Users(user_id)
);

-- Bảng tin nhắn
CREATE TABLE Messages (
    message_id INT PRIMARY KEY IDENTITY(1,1),
    sender_id INT NOT NULL,
    receiver_id INT NOT NULL,
    content TEXT NOT NULL,
    sent_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (sender_id) REFERENCES Users(user_id),
    FOREIGN KEY (receiver_id) REFERENCES Users(user_id)
);

-- Bảng đánh giá
CREATE TABLE Reviews (
    review_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT NOT NULL,
    court_id INT NOT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (court_id) REFERENCES Courts(court_id)
);
-- Bảng doanh thu
CREATE TABLE Revenue (
    revenue_id INT PRIMARY KEY IDENTITY(1,1),
    court_id INT NOT NULL,
    date DATE NOT NULL,
    amount DECIMAL(10, 2) NOT NULL CHECK (amount >= 0),
    description TEXT,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (court_id) REFERENCES Courts(court_id)
);
