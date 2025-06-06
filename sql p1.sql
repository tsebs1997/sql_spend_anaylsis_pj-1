-- crate table --
 create table purchase 
			  (
				transaction_ID varchar(110),
				Item_Name varchar(100),
				Category varchar (100),
				Quantity int,
				Unit_Price float,
				Total_Cost float,
				Purchase_Date date,
				Supplier varchar (100),
				Buyer varchar (100)
               );
			   
	select*
	from purchase;

	select *
	from purchase;
	
---- data cleaning--
 select *
 from purchase 
 where transaction_id is null; 

  select *
 from purchase 
 where item_name is null;

  select *
 from purchase
 where
     category is null
      or
	 quantity is null
	  or 
	 unit_price is null 
	  or
	 total_cost is null 
	  or
	 purchase_date is null
	  or
	 supplier is null
	  or
	 buyer is null ;

	 ---data exploration--- 

--how many items were purchased?- 

  select count(*)as total_item 
  from purchase ;
  
 --  how many unqiue do we suppliers --

 select count(distinct supplier )as no_of_suppliers 
  from purchase ;

 -- how many categories do we have --

 select count(distinct category)as total_category  
  from purchase ; 

 -- how many buyers do we have --
 
 select count(distinct buyer)as total_buyers  
  from purchase ;

---- data analysis, spend anaylsis---  

--1. write a query that retrives all purchase on '2024-07-19'

select * 
  from purchase 
  where purchase_date ='2024-07-19';

--2. write a query where category is funiture and the quantity purchased is more than 10 in the month of oct  

select item_name 
  from purchase ;
  
select category,
   sum(quantity) 
  from purchase 
  where category = 'furniture'
  and 
  to_char(purchase_date,'YYY-MM')='2024-10'
  and 
  quantity > 10 
  group by category 

-- 3. write a query to calculate the total purchase of each category . 
  	 select
	   category ,
	   sum(total_cost) as net_purchase,
	   count(*) as total_purchase
	  from purchase 
	  group by 1

--4. write a query to find tranactions where total cost is above $200  
   select *
   from purchase 
   where total_cost > 200

--5. write a query to find the total no of items supplied by each supplier in each category   

  select item_name, category,
	supplier,
	count(*)as total_items 
	from purchase
	group by item_name, category,
	         supplier
   order by 1;

 -- 6.write a query to find the total no of items bought by each buyer in each category     
   select item_name, category,
	buyer,
	count(*)as total_items 
	from purchase
	group by item_name, category,
	         buyer
   order by 1;

 --7 query to calculate the average purchase for each month . hence month with high purchase 

  select 
  extract(year from purchase_date) as year,
  extract(month from purchase_date) as month,
  avg(total_cost) as avg_monthly_purchase,
  rank() over(partition by extract(year from purchase_date) 
  order by avg(total_cost) desc) as rank
  from purchase
  group by 1,2

   -- month with high purchase--

   select*
   from (
select 
  extract(year from purchase_date) as year,
  extract(month from purchase_date) as month,
  avg(total_cost) as avg_monthly_purchase,
  rank() over(partition by extract(year from purchase_date) 
  order by avg(total_cost) desc) as rank
  from purchase
  group by 1,2
   ) as t1
   where rank =1

--8 write a query to find the top suppliers based on items bought.
  select supplier,
  sum(total_cost) as total_item
  from purchase
  group by 1
  order by 2 desc;
  
--9 write a query to get the no of unq buyers that purchased items from every category 
 
  select category,
       count ( distinct buyer) as unq_buyers
  from purchase
  group by 1

	