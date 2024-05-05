--  1.  Add a new column named time_of_day to give insight of sales in the Morning, Afternoon and Evening.
-- This will help answer the question on which part of the day most sales are made.

SELECT *, 
   CASE 
WHEN time BETWEEN '07:00:00' AND '11:59:59' THEN 'morning'
WHEN time BETWEEN '12:00:00' AND '15:59:59' THEN 'afternoon'
ELSE 'evning'
END AS 'time_of_day'
FROM WALMART

ALTER TABLE	Walmart
ADD time_of_dey VARCHAR (50)
 
UPDATE Walmart 
SET time_of_dey =  
   CASE 
WHEN time BETWEEN '07:00:00' AND '11:59:59' THEN 'morning'
WHEN time BETWEEN '12:00:00' AND '15:59:59' THEN 'afternoon'
ELSE 'evning'
END 
FROM WALMART
 
 select * from Walmart

-- 2. Add a new column named day_name that contains the extracted days of the week on which the given transaction took place (Mon, Tue, Wed, Thur, Fri).
--  This will help answer the question on which week of the day each branch is busiest.

ALTER TABLE WALMART
ADD dey_name varchar (50)

SELECT * FROM WALMART

UPDATE Walmart 
SET dey_name = DATENAME(dw, date)

-- 3. Add a new column named month_name that contains the extracted months of the year on which the given transaction took place (Jan, Feb, Mar).
--  Help determine which month of the year has the most sales and profit.

ALTER TABLE WALMART
ADD month_name VARCHAR (50)

UPDATE WALMART 
SET month_name = DATENAME(MONTH,Date)

SELECT * FROM WALMART

/* 4. Exploratory Data Analysis (EDA)

Conducting exploratory data analysis is essential to address the project's listed questions and objectives.
Business Questions to Answer
Generic Questions

    How many distinct cities are present in the dataset?
    In which city is each branch situated? */
 
   SELECT COUNT(branch)AS NR_of_branch,branch 
   FROM WALMART
   GROUP BY Branch 
   ORDER BY NR_of_branch DESC

   SELECT COUNT(city)AS City_numer,city,branch
   FROM Walmart
   GROUP BY City,Branch

   SELECT * FROM Walmart

   --5.How many distinct product lines are there in the dataset?
   
   SELECT  DISTINCT (Product_line) as Product_line
   FROM Walmart

   
   --6.  What is the most common payment method?

   SELECT COUNT(payment) as payment_method,Payment 
   FROM WALMART 
   GROUP BY Payment
   
   --7.What is the most selling product line?

   SELECT COUNT(product_line) AS productline_total,Product_line
   FROM Walmart
   GROUP BY Product_line   
   ORDER BY Product_line DESC

 --8,What is the total revenue by month?
 
 SELECT month_name,COUNT(month_name)AS total_month,ROUND (SUM(Total),2) AS total_sales 
 FROM walmart
 GROUP BY month_name
 ORDER BY total_sales DESC
 
 --9. Which month recorded the highest Cost of Goods Sold (COGS)?

 SELECT TOP 1 month_name,ROUND  (MAX(total),2) AS highest_month
 FROM Walmart
 GROUP BY month_name
 ORDER BY highest_month DESC

 
 --10.  Which product line generated the highest revenue?


 SELECT product_line,ROUND (SUM(total),2) AS total
 FROM Walmart
 GROUP BY Product_line
 ORDER BY total DESC

 --11. Which city has the highest revenue?

 SELECT city,ROUND (SUM(total),2) AS total 
 FROM Walmart
 GROUP BY city
 ORDER BY total DESC

 --12.  Which product line incurred the highest VAT?

 SELECT TOP 1 Product_line,ROUND(SUM(tax_5),2) AS highte_vat
 FROM Walmart
 GROUP BY Product_line
 ORDER BY highte_vat DESC

/*  13. Retrieve each product line and add a column product_category, indicating 'Good' or 'Bad,' 
       based on whether its sales are above the average. */
	  

	  SELECT Product_line,AVG(total) 
	  FROM Walmart
	  GROUP BY Product_line

	  SELECT AVG(total) FROM Walmart  /* AVG 322.966749205589*/

	  SELECT product_line,AVG(total),
	  CASE 
	  WHEN total < (select avg(total) FROM Walmart) THEN 'bed'
	  ELSE 'good'
	  END
	  FROM Walmart
	  GROUP BY product_line,Total

	  ALTER TABLE walmart
	  add product_category VARCHAR (50)


	UPDATE Walmart
    SET product_category =
    CASE 
    WHEN total < (SELECT AVG(total) FROM Walmart) THEN 'bad'
    ELSE 'good'
    END;

	SELECT * FROM Walmart

	--14.Which branch sold more products than average product sold?


	SELECT Branch,ROUND (AVG(TOTAL),2) AS best_line_sell
	FROM Walmart
    GROUP BY Branch
	HAVING AVG(total) > 322


	-- 15. What is the most common product line by gender?

	SELECT Gender, Product_line,count(Gender) AS line_by_gender 
	FROM Walmart
	GROUP BY Product_line,Gender
	ORDER BY line_by_gender DESC
		

   -- 16.  What is the average rating of each product line?
   

   SELECT ROUND(SUM(TOTAL),2) AS total , ROUND(AVG(total),2) AS avg_total,Product_line
   FROM Walmart
   GROUP BY Product_line

   -- 17. Number of sales made in each time of the day per weekday

   SELECT ROUND (SUM(total),2),time_of_dey,dey_name
   FROM Walmart
   GROUP BY time_of_dey,dey_name
   ORDER BY dey_name DESC
   
   -- 18.   Identify the customer type that generates the highest revenue

   SELECT ROUND (SUM(Total),2) as total,Customer_type 
   FROM Walmart
   GROUP BY Customer_type
   ORDER BY total DESC

   --19.  Which city has the largest tax percent/ VAT (Value Added Tax)?
   

   SELECT MAX(tax_5) AS tax,City 
   FROM Walmart
   GROUP BY City
   ORDER BY tax DESC

   --20.    Which customer type pays the most VAT?
   
   SELECT MAX(tax_5) AS most_tax,customer_type
   FROM	Walmart
   GROUP BY Customer_type
   ORDER BY most_tax DESC
   

   --21.      How many unique customer types does the data have?


   SELECT Customer_type,count(customer_type) AS customer_type  
   FROM Walmart
   WHERE Customer_type = 'member'
   GROUP BY Customer_type
   
   --22.  How many unique payment methods does the data have?
   
   SELECT DISTINCT(Payment) 
   FROM Walmart
   
   -- 23.   Which is the most common customer type?

   SELECT Customer_type,Gender,COUNT(Customer_type) AS total 
   FROM Walmart
   GROUP BY Customer_type,Gender
   ORDER BY total DESC

   --24.  Which customer type buys the most

   SELECT Customer_type,gender, sum(total) AS total 
   FROM Walmart
   GROUP BY Customer_type,Gender
   ORDER BY total DESC

   --25.  What is the gender of most of the customers?

   SELECT gender, COUNT(gender) AS nr_gender
   FROM Walmart
   GROUP BY Gender

   -- 26. What is the gender distribution per branch?

   SELECT COUNT(branch) AS Nr_visitor,Branch,Gender 
   FROM Walmart
   GROUP BY Branch,Gender
   ORDER BY Branch 

   -- 27.  Which time of the day do customers give most ratings?

   SELECT DISTINCT(time_of_dey),SUM(Rating) AS rating_of_day
   FROM Walmart
   GROUP BY time_of_dey
   ORDER BY time_of_dey ASC

   -- 28. Which time of the day do customers give most ratings per branch?

   SELECT  DISTINCT(time_of_dey),COUNT(Branch) AS branch, branch,SUM(Rating) AS rating 
   FROM Walmart
   GROUP BY time_of_dey,Branch
   ORDER BY rating DESC

   -- chatGPT

   
   WITH RatingsPerBranchTimeOfDay AS (
    SELECT 
        time_of_dey,
        Branch,
        SUM(Rating) AS TotalRating
    FROM 
        Walmart
    GROUP BY 
        time_of_dey,
        Branch
)
SELECT 
    time_of_dey,
    Branch,
    TotalRating
FROM 
    (
    SELECT 
        time_of_dey,
        Branch,
        TotalRating,
        ROW_NUMBER() OVER (PARTITION BY time_of_dey ORDER BY TotalRating DESC) AS RankByRating
    FROM 
        RatingsPerBranchTimeOfDay
    ) AS RankedRatings
WHERE 
    RankByRating = 1
ORDER BY 
    time_of_dey;



   --29.  Which day of the week has the best avg ratings?


 SELECT dey_name,AVG(rating) AS best_rating
 FROM Walmart
GROUP BY dey_name
ORDER BY best_rating DESC


-- 30 .  Which day of the week has the best average ratings per branch?

SELECT dey_name,Branch,avg(rating) AS rating 
FROM Walmart
GROUP BY dey_name,Branch
ORDER BY dey_name


CREATE VIEW test AS 
SELECT dey_name,Branch,avg(rating) AS rating
FROM Walmart
GROUP BY dey_name,Branch

SELECT * FROM test

	