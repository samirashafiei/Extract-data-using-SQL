-- 1. what are the products category?
Select distinct(Productcategory) as ProductsCategory
From product_t;

-- 2. Which category has the highst quantity in Inventory?
Select productcategory, count(quantityonhand) as Quantity
from product_t
group by productcategory
order by quantity desc
limit 1;

-- 3. Which product is the most expensive one?
select productname, sellingprice
from product_t
order by sellingprice desc
limit 1;

-- 4. Which products are more expensive than average selling price of all products.
select productNumber, productname
from product_t
where SellingPrice > (
select AVG(SellingPrice)
from Product_t);

-- 5. How many products in children’s category are more expensive than the average selling price of all the products in children’s category?

select COUNT(ProductNumber) 
from Product_T
where SellingPrice > 
( select AVG(SellingPrice) 
from Product_T 
where ProductCategory = 'Children') 
and ProductCategory = 'Children';


-- 6. How many products in road’s category are more expensive than the average selling price of all the products in children’s category?
select count(ProductNumber)
from Product_T
where SellingPrice > (
select AVG(SellingPrice)
from Product_T
where ProductCategory = 'Children') 
and ProductCategory = 'Road';

-- 7. Extract report on all products, their suppliers, and the number of sold products
select p.productname, s.companyname, o.Quantity
from product_t p left join supplier_t s
on p.suppliernumber = s.suppliernumber
left join orders_t o
on p.productnumber = o.productID;

-- 8. Which product has the highst profit?
select productname, round((sellingprice-purchasecost)) as profit
from product_t
order by profit desc
limit 1;

-- 9. Extract the name of supplier companies and product
select s.companyname, p.productname
from product_t p join supplier_t s
on p.suppliernumber=s.suppliernumber;

-- 10. Make a list of product names and supplier company’s name and location. Order the result table by product name in alphabetical order.
select p.productname, s.companyname
from product_t p join supplier_t s
on p.SupplierNumber = s.SupplierNumber
order by p.productname asc;

-- 11. Get the list of categories and product names that are supplied in San Diego and Seattle. 
select p.productcategory, p.productname, s.city
from product_t p join supplier_t s
on p.suppliernumber =s.suppliernumber
where city = "San diego" or city = "Long Branch" 
order by p.productcategory;

-- 12. Get a list of product names and supplier company’s name, where current inventory is equal to or less than the reorder level.
select p.productname, s.companyname, p.QuantityonHand, p.ReorderLevel
from product_t p join supplier_t s
on p.SupplierNumber = s.SupplierNumber
where p.QuantityonHand=p.reorderlevel;

-- 13. A manager wants to know which companies supply which products . Order by SupplierNumber. 
-- Note: the manager wants to include all companies even if they are not currently supplying any products.
select s.suppliernumber, p.productname
from supplier_t s left join product_t p
on s.SupplierNumber = p.SupplierNumber
order by s.suppliernumber asc;

-- 14. How many distinct products each supplier have supplied?
select s.CompanyName, count(distinct p.productnumber)
from supplier_t s left join product_t p
on s.SupplierNumber = p.SupplierNumber
group by s.companyname;

-- ==> Datasets: Employees $ Office

-- 15. What are the distinct locations that are mutual in Employees and Office tables?
select distinct(o.location)
from employees e join office o
on e.Location = o.location
order by o.location;

-- 16. List the ordered name of locations, the number of employees in each location, and show whether these locations are regional.
select o.location, Count(e.employeeID)
from office o left join employees e
on o.location= e.location 
where o.regionaloffice = "yes"
group by o.location
order by o.location;

