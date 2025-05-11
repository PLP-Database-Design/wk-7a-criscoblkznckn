-- Question 1: Achieving 1NF (First Normal Form)
-- Original Table: ProductDetail(OrderID, CustomerName, Products)
-- Violation: 'Products' column contains multiple values.
-- Solution: Split products into individual rows.

CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100)
);

INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product)
VALUES
(101, 'John Doe', 'Laptop'),
(101, 'John Doe', 'Mouse'),
(102, 'Jane Smith', 'Tablet'),
(102, 'Jane Smith', 'Keyboard'),
(102, 'Jane Smith', 'Mouse'),
(103, 'Emily Clark', 'Phone');

-- The table is now in 1NF. Each product is in its own row.


-- Question 2: Achieving 2NF (Second Normal Form)
-- Original Table: OrderDetails(OrderID, CustomerName, Product, Quantity)
-- Violation: CustomerName depends only on OrderID, not the full composite key (OrderID, Product).
-- Solution: Create two tables: Orders and OrderItems

-- Step 1: Create Orders table (removing partial dependency)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

INSERT INTO Orders (OrderID, CustomerName)
VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

-- Step 2: Create OrderItems table with full dependency on composite key
CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

INSERT INTO OrderItems (OrderID, Product, Quantity)
VALUES
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);

-- Now the database is in 2NF. All non-key columns fully depend on the whole primary key.
