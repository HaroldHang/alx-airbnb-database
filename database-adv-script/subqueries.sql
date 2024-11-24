SELECT 
    user_id, 
    first_name, 
    last_name 
FROM 
    User 
WHERE 
    (
        SELECT 
            COUNT(*) 
        FROM 
            Booking 
        WHERE 
            Booking.user_id = User.user_id
    ) > 3;
