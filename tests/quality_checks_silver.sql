--**Table silver.crm_cust_info

--Check for nulls or duplicates in primary key
--Expectation : no results row

select 
cst_id,
count(*)
from silver.crm_cust_info
group by cst_id
having count(*) >1 or cst_id is null;

--Check for duplicate primary key

select 
*
from silver.crm_cust_info
where cst_id = 29466;

--Check for unwanted spaces in nvarchar colums of the table crm_cust_info

--Expectation : No result

select cst_firstname
from silver.crm_cust_info
where cst_firstname != trim(cst_firstname);

select cst_lastname
from silver.crm_cust_info
where cst_lastname != trim(cst_lastname);

--The below query gives all possible gender abbreviations applied

select distinct cst_gndr
from silver.crm_cust_info;

select distinct cst_marital_status
from silver.crm_cust_info;

select *
from silver.crm_cust_info
where cst_marital_status = 'n/a';

select *
from silver.crm_cust_info
where cst_gndr = 'n/a';

select *  from silver.crm_cust_info;

SELECT *
FROM silver.crm_cust_info
ORDER BY cst_id ASC;
---------------------------------------------------------------------------------------------------------------------------------------------------

--**Table silver.crm_prd_info

--Check for nulls or duplicates in primary key
--Expectation :No Result

select 
prd_id,
count(*)
from silver.crm_prd_info
group by prd_id
having count(*) > 1 or prd_id is null;

--Check for unwanted spaces in product name field prd_nm
--Expectation :No result

select 
prd_nm
from silver.crm_prd_info
where prd_nm != trim(prd_nm);

--Now check for nulls or negative numbers in prd_cost
--Expectation :No result

select 
prd_cost
from silver.crm_prd_info
where prd_cost < 0 or prd_cost is null;

--Now for data standardisation and consistency for the prd_line field do the follows 

select distinct prd_line 
from silver.crm_prd_info;

--Now check for invalid prd_start_dt and prd_end_dt
--Expectation : No result

select 
* 
from 
silver.crm_prd_info
where prd_start_dt > prd_end_dt;

--Final check for silver.crm_prod_info table

select * from silver.crm_prd_info;

----------------------------------------------------------------------------------------------------------------------------------------

--**Table silver.crm_sales_details

--Check for invalid order dates 

select *
from silver.crm_sales_details
where sls_order_dt > sls_ship_dt or sls_order_dt > sls_due_dt;

--Checking Bussiness rules

select distinct
sls_sales,
sls_quantity,
sls_price
from silver.crm_sales_details
where sls_sales != sls_quantity * sls_price 
or sls_sales is null or sls_quantity is null or sls_price is null
or sls_sales <= 0 or sls_quantity <= 0 or sls_price <= 0
order by sls_sales, sls_quantity, sls_price;

--So Business rules are perfect
--Now for final output as follows

select * from silver.crm_sales_details;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------

--**Table silver.erp_cust_az12

--Identify Out of range dates
--Expected :No result

select distinct
cid,
bdate
from silver.erp_cust_az12
where bdate < '1924-01-01' or bdate > getdate(); 

--Data standardisation and consistency

select distinct gen from silver.erp_cust_az12;

select * from silver.erp_cust_az12;

-----------------------------------------------------------------------------------------------------------------------------------------------------------

--**Table silver.erp_loc_a101

--Data standardisation and consistency

select distinct cntry
from silver.erp_loc_a101
order by cntry;

select * from silver.erp_loc_a101;

----------------------------------------------------------------------------------------------------------------------------------------

--**Table silver.erp_px_cat_g1v2

--Check for unwanted spaces

select 
*
from silver.erp_px_cat_g1v2 
where cat != trim(cat) or subcat != trim(subcat) or maintenance != trim(maintenance); 

--For data standardisation and consistency check as follows

select distinct
cat
from silver.erp_px_cat_g1v2;

select distinct
subcat
from silver.erp_px_cat_g1v2;

select distinct
maintenance
from silver.erp_px_cat_g1v2;

--Now see the whole silver.erp_px_cat_g1v2 table

select * from silver.erp_px_cat_g1v2;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
