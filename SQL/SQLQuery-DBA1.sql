/************************************************************************************************************************/
/* Created by MNS @ 20/01/2021.																							*/
/*																														*/
/************************************************************************************************************************/
/* Declaring the main database usage. */
USE Database1;

/* Cleaning all Finacne tables. */
TRUNCATE TABLE Finance.Income;

/* Populating the tables with sample data. */
EXEC Finance.IncomeAdd '20210128', '20210128', '2021 January', 'BNP BA Salary', 'January salary.',25000,'PLN','OK';
EXEC Finance.IncomeRemove 1;

/* Checking avaliable data in the tables. */
SELECT * FROM Finance.Income;