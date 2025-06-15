

-- ==========================
-- BẢNG NGƯỜI DÙNG
-- ==========================
CREATE TABLE Users (
    user_id INT PRIMARY KEY IDENTITY(1,1),
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100),
    phone_number VARCHAR(20),
    role VARCHAR(50),
    status VARCHAR(50),
    note NVARCHAR(MAX),
    created_at DATETIME DEFAULT GETDATE()
);

-- ==========================
-- BẢNG KHU VỰC
-- ==========================
CREATE TABLE Areas (
    area_id INT PRIMARY KEY IDENTITY(1,1),
    name NVARCHAR(100) NOT NULL,
    location NVARCHAR(255), 
    manager_id INT NOT NULL,
    court INT,
    open_time TIME NOT NULL,
    close_time TIME NOT NULL,
    descriptions NVARCHAR(MAX),
    FOREIGN KEY (manager_id) REFERENCES Users(user_id),
    CONSTRAINT chk_area_time CHECK (open_time < close_time)
);

-- ==========================
-- BẢNG HÌNH ẢNH KHU VỰC
-- ==========================
CREATE TABLE Area_Image (
    imageID INT PRIMARY KEY IDENTITY(1,1),
    area_id INT,
    imageURL TEXT,
    FOREIGN KEY (area_id) REFERENCES Areas(area_id)
);

-- ==========================
-- BẢNG GIÁ THUÊ SÂN
-- ==========================
CREATE TABLE Court_Pricing (
    pricing_id INT PRIMARY KEY IDENTITY(1,1),
    area_id INT NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (area_id) REFERENCES Areas(area_id),
    CONSTRAINT chk_pricing_time CHECK (start_time < end_time)
);

-- ==========================
-- BẢNG SÂN
-- ==========================
CREATE TABLE Courts (
    court_id INT PRIMARY KEY IDENTITY(1,1),
    court_number VARCHAR(50) NOT NULL,
    type NVARCHAR(50),
    floor_material NVARCHAR(50),
    lighting NVARCHAR(50),
    description NVARCHAR(255),
    image_url NVARCHAR(255),
    status NVARCHAR(50),
    area_id INT NOT NULL,
    open_time TIME NULL,
    close_time TIME NULL,
    FOREIGN KEY (area_id) REFERENCES Areas(area_id),
    CONSTRAINT chk_court_time CHECK (open_time IS NULL OR close_time IS NULL OR open_time < close_time),
    CONSTRAINT uq_court_number UNIQUE (court_number, area_id)
);

-- ==========================
-- BẢNG ĐẶT SÂN
-- ==========================
CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT NOT NULL,
    court_id INT NOT NULL,
    date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    status NVARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (court_id) REFERENCES Courts(court_id),
    CONSTRAINT chk_booking_time CHECK (start_time < end_time)
);

-- ==========================
-- BẢNG DỊCH VỤ (THUÊ VỢT, NƯỚC UỐNG...)
-- ==========================
CREATE TABLE BadmintonService (
    service_id INT PRIMARY KEY IDENTITY(1,1),
    name NVARCHAR(100) NOT NULL UNIQUE,
    price DECIMAL(10, 2) NOT NULL CHECK (price >= 0),
    description NVARCHAR(MAX),
    image_url NVARCHAR(255),
    status NVARCHAR(50) DEFAULT 'Active',
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME,
    is_deleted BIT DEFAULT 0
);

-- ==========================
-- BẢNG DỊCH VỤ TRONG BOOKING
-- ==========================
CREATE TABLE Booking_Services (
    id INT PRIMARY KEY IDENTITY(1,1),
    booking_id INT,
    service_id INT,
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id),
    FOREIGN KEY (service_id) REFERENCES BadmintonService(service_id)
);

-- ==========================
-- BẢNG DỊCH VỤ ÁP DỤNG CHO KHU VỰC
-- ==========================
CREATE TABLE Areas_Services (
    AreaServices_id INT PRIMARY KEY IDENTITY(1,1),
    service_id INT NOT NULL,
    area_id INT,
    FOREIGN KEY (area_id) REFERENCES Areas(area_id),
    FOREIGN KEY (service_id) REFERENCES BadmintonService(service_id)
);

-- ==========================
-- BẢNG BÀI VIẾT
-- ==========================
CREATE TABLE Posts (
    post_id INT PRIMARY KEY IDENTITY(1,1),
    title VARCHAR(255) NOT NULL,
    content VARCHAR(MAX) NOT NULL,
    created_by INT NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    type VARCHAR(20),
    FOREIGN KEY (created_by) REFERENCES Users(user_id)
);

-- ==========================
-- BẢNG BÌNH LUẬN
-- ==========================
CREATE TABLE Comments (
    comment_id INT PRIMARY KEY IDENTITY(1,1),
    post_id INT NOT NULL,
    user_id INT NOT NULL,
    content VARCHAR(MAX) NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (post_id) REFERENCES Posts(post_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- ==========================
-- BẢNG ĐÁNH GIÁ
-- ==========================
CREATE TABLE Reviews (
    review_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT NOT NULL,
    area_id INT NOT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment VARCHAR(MAX),
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (area_id) REFERENCES Areas(area_id)
);

-- ==========================
-- BẢNG TOKEN RESET MẬT KHẨU
-- ==========================
CREATE TABLE password_reset_tokens (
    id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    user_id INT NOT NULL,
    token VARCHAR(255) NOT NULL UNIQUE,
    created_at DATETIME DEFAULT GETDATE(),
    is_used BIT DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- ==========================
-- BẢNG THÔNG BÁO
-- ==========================
CREATE TABLE Notification (
    notification_id INT IDENTITY(1,1) PRIMARY KEY,
    title NVARCHAR(255) NOT NULL,
    content NVARCHAR(MAX) NOT NULL,
    image_url NVARCHAR(255),
    created_by INT,
    scheduled_time DATETIME,
    sent_time DATETIME,
    status VARCHAR(20),
    created_at DATETIME DEFAULT GETDATE()
);

-- ==========================
-- BẢNG NGƯỜI NHẬN THÔNG BÁO
-- ==========================
CREATE TABLE Notification_Receiver (
    id INT IDENTITY(1,1) PRIMARY KEY,
    notification_id INT,
    user_id INT,
    is_read BIT DEFAULT 0,
    read_at DATETIME,
    opened_at DATETIME,
    FOREIGN KEY (notification_id) REFERENCES Notification(notification_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- ==========================
-- BẢNG THẺ TAG CHO FAQ
-- ==========================
CREATE TABLE faq_tag (
    tag_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL UNIQUE
);

-- ==========================
-- BẢNG CÂU HỎI FAQ
-- ==========================
CREATE TABLE faq_question (
    question_id INT IDENTITY(1,1) PRIMARY KEY,
    title NVARCHAR(255) NOT NULL,
    tag_id INT NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME,
    FOREIGN KEY (tag_id) REFERENCES faq_tag(tag_id)
);

-- ==========================
-- BẢNG TRẢ LỜI FAQ
-- ==========================
CREATE TABLE faq_answer (
    answer_id INT IDENTITY(1,1) PRIMARY KEY,
    question_id INT NOT NULL,
    content NVARCHAR(MAX) NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME,
    FOREIGN KEY (question_id) REFERENCES faq_question(question_id)
);
