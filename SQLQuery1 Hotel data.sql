Use Hotel_det
Select * From ['Hotels '];
Select * From ['OYO '];

--- Q1 Select Cities where total amount of recieved from the customers which stayes in hotel is > 20000.
Select City, Sum(amount) as Total_Amount
From ['Hotels '] Inner join ['OYO ']
On ['Hotels '].hotel_id = ['OYO '].hotel_id
where ['OYO '].status = 'Stayed'
Group By City
Having Sum(amount) > 20000
Order By Sum(amount) Desc;

--- Q2 Display top 5 months when the revenue generated from the customers which stayed in the hotel is maximum.
Select Top 5 Datename(Month, check_in) As Month, Sum(amount) as Total_amount
From ['OYO ']
where status = 'stayed'
Group By Datename(Month, check_in)
Order By Sum(amount) Desc;

--- Q3 Display the total number and the amount of the bookings cancelled, stayed & No show.
(Select status,Count(status) as Total_Bookings, sum(amount) as Total_Amount
From ['OYO ']
Where status= 'Stayed'
Group By status)
Union
(Select status, Count(status) as Total_Bookings, sum(amount) as Total_Amount
From ['OYO ']
Where status= 'Cancelled'
Group By status) 
Union
(Select status, Count(status) as Total_Bookings, sum(amount) as Total_Amount
From ['OYO ']
Where status= 'No show'
Group By status);

--- Q4 Display the month wise total number of bookings cancelled in each city. 
Select city, Datename(Month, check_in) as Month, Count(booking_id) as Total_Bookings
From ['OYO '] Inner Join ['Hotels ']
ON ['OYO '].hotel_id = ['Hotels '].hotel_id
Where status = 'Cancelled'
Group By city, Datename(Month, check_in);

--- Q5 Display the hotel id's with total bookings (cancellations & stayed) with their total amount.
(Select status, hotel_id, Count(booking_id) as Total_Bookings, Sum(amount) as Total_Amount
From ['OYO ']
where status = 'Cancelled'
Group By hotel_id, status)
Union
(Select status, hotel_id, Count(booking_id) as Bookings, Sum(Amount) As Total_Amount
From ['OYO ']
where status = 'Stayed'
Group By hotel_id, status)
Order by status Desc, Count(booking_id) Desc;

--- Q6 Display the total number of days and the total amount paid by the customers stayed in the hotels.
Select customer_id, hotel_id, amount,
Datediff(day, check_in, check_out) As Total_days
From ['OYO ']
where status = 'Stayed'
Order By Total_days Desc;

--- Q7 Show total number of bookings in each city.
Select city, Count(booking_id) As Total_booking
From ['OYO '] Inner Join ['Hotels ']
On ['OYO '].Hotel_id = ['Hotels '].hotel_id
Group By city;

---Similar
Select ['Hotels '].city, ['OYO '].hotel_id
From ['OYO '] Inner Join ['Hotels ']
On ['OYO '].Hotel_id = ['Hotels '].hotel_id
Group By ['Hotels '].city, ['OYO '].hotel_id;

--- Q8 Show the difference in number of bookings month by month.
Select Month(check_in) as Month_no, Datename(month, check_in) as month, Count(booking_id) as Total_booking, Lag(Count(booking_id))Over(Order By Month(check_in)) As lag_Booking,
Count(booking_id) - Lag(Count(booking_id))Over(Order By Month(check_in)) as diff
From ['OYO ']
Group By Month(check_in), Datename(month, check_in)
Order By Month(check_in)asc;

--- Q9 Show the rank of the city based on their total boking.
Select e1.City, Count(e2.booking_id) as Total_booking,
Dense_Rank() Over(order by Count(e2.booking_id) Desc) As Rank
From ['Hotels '] e1 Inner Join ['Oyo '] e2
On e1.hotel_id = e2.hotel_id
Group By e1.city
Order By Rank Asc;

---Similar
Select e1.City, e1.hotel_id, Count(e2.booking_id) as Total_booking,
Dense_Rank() Over( order by Count(e2.booking_id) Desc) As Rank
From ['Hotels '] e1 Inner Join ['Oyo '] e2
On e1.hotel_id = e2.hotel_id
Group By e1.city, e1.hotel_id
Order By Rank Asc;

--- Q10 Show the maximum and average rate of hotels in different cities.
SELECT City, Round(AVG(amount),0) AS Average_rate_in_city, Max(amount) AS Max_rate_in_city
From ['Hotels '] Inner Join ['Oyo ']
On ['Hotels '].hotel_id = ['Oyo '].hotel_id
GROUP BY City;

--- Q11 Show the distribution of bookings of the hotels based on the status of booking.
Select hotel_id, 
Count(booking_id) As Total_booking,
Count(Case when status ='stayed' Then booking_id End) As Total_stayed,
Count(Case when status ='cancelled' Then booking_id End) As Total_Cancellations,
Count(Case when status ='No show' Then booking_id End) As Total_No_show
From ['OYO ']
Where status In ('stayed', 'cancelled','No show')
Group By hotel_id;

---Q12 Show the distribution of bookings of different cities based on the status of booking.
Select e1.city, 
Count(e2.booking_id) as Total_booking,
Count(Case when e2.status = 'stayed' Then e2.booking_id End) As Total_stayed,
Count(Case when e2.status = 'Cancelled' Then e2.booking_id End) As Total_cancelled
From ['OYO '] e2 Join ['Hotels '] e1
On e1.hotel_id = e2.hotel_id
Where e2.status In ('stayed', 'cancelled')
Group By e1.city;

--- Q13 Show the percentage discount provided by different hotels.
Select hotel_id, Sum(amount) As Total_Amount, Sum(discount) As Total_Discount, Sum(amount) - Sum(discount) As Actual_amountpayed, Round(sum(discount)*100/sum(amount),2) As Percentage_discount
From ['OYO ']
Group By hotel_id
Order By Sum(discount) Desc;




















