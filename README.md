This SQL script contains multiple queries designed to extract and analyze data from a database named MyGuitarShop. 
The queries focus on customer addresses, product details, order statistics, and sales analysis. Here’s a breakdown of the main sections:

1. Customer Addresses 
   - Retrieves customer addresses in a formatted manner.
   - The commented-out query includes customer names along with addresses by joining the Customers and Addresses tables.

2. Product Analysis
   - Finds products whose names start with 'G' or 'F'.
   - Counts products within each category and filters categories with more than two products.
   - Extracts the brand or company name from product names.
   - Counts products by brand and filters brands with more than one product.

3. Customer & Category Sales Insights
   - Identifies customers who purchased products from more than one category.
   - Counts the number of unique products sold per category.
   - Extracts usernames from email addresses and checks how many orders each customer has placed,
     filtering for those with zero orders.

4. Order Analysis
   - Counts the number of orders per card type.
   - Calculates the number of orders and total sales revenue per month.


**Tables:**
1. Addresses – Stores customer addresses, including billing and shipping addresses.
2. Customers – Stores customer details such as email, name, and addresses.
3. Categories – Stores product categories.
4. OrderItems – Stores details of products in customer orders.
5. Orders – Stores order details, including shipping and billing info.
6. Products – Stores product details, including price, discount, and category.
7. Administrators – Stores admin user credentials.
8. Copies of Categories, Customers, and Products – Backup tables.

**Views:**
- CustomerAdresses - Joins Customers and Addresses to display customer shipping and billing addresses.
- OrderItemProducts – Joins Orders, OrderItems, Products, and Categories to provide order item details, 
including calculated discount prices.

**Stored Procedures:**
1. findAverageSales:
- Calculates the average sales price of all order items.
-  Uses sum(ItemPrice - DiscountAmount) * count(Quantity) to compute total sales.
- Divides total sales by the count of items to get the average.
- Prints the result and returns it.

2. spDeleteCategory - Likley used to delete a category.

**Constraints and Defaults:**
- Foreign keys ensure data integrity by linking related tables.
- Default values
