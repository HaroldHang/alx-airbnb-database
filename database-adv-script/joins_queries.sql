SELECT 
    Property.property_id,
    Property.name AS property_name,
    Property.description,
    Review.review_id,
    Review.rating,
    Review.comment
FROM 
    Property
LEFT JOIN 
    Review
ON 
    Property.property_id = Review.property_id;
