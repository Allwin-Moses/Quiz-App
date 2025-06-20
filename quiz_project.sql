create database quiz

use quiz

--CREATE Categories TABLE

CREATE  TABLE CATEGORIES (
ID INT PRIMARY KEY IDENTITY(1,1),
CATEGORYNAME NVARCHAR(200));

INSERT INTO Categories (CategoryName) VALUES ('C#'), ('MVC'), ('SQL'), ('ADO.NET'), ('ASP.NET');

CREATE PROC ALLCATEGORIES
AS
BEGIN
SELECT * FROM CATEGORIES
END

--CREATE QUESTIONS  TABLE

CREATE TABLE QUESTIONS(
QId INT PRIMARY KEY IDENTITY(1,1),
QnText NVARCHAR(255),
CategoryId INT FOREIGN KEY REFERENCES Categories(Id));

CREATE TABLE Answers (
    Id INT PRIMARY KEY IDENTITY,
    QuestionId INT FOREIGN KEY REFERENCES Questions(qId),
    AnswerText NVARCHAR(255),
    IsCorrect BIT
);


CREATE PROC GETQN_BYCATEGORIES
@CategoryId INT
AS
BEGIN
SELECT * FROM QUESTIONS WHERE CategoryId=@CategoryId
END

CREATE PROC GETANS_BY_QID
@QuestionId INT
AS
BEGIN
SELECT * FROM ANSWERS WHERE QuestionId=@QuestionId
END

CREATE PROCEDURE GetCorrectAnswerIds
AS
BEGIN
    SELECT Id FROM Answers WHERE IsCorrect = 1
END

INSERT INTO QUESTIONS (QnText, CategoryId) VALUES
('What is the default access modifier for class members in C#?', 1),
('Which keyword is used to inherit a class in C#?', 1),
('Which of the following is NOT a value type in C#?', 1),
('What does the "static" keyword indicate in C#?', 1),
('Which interface is implemented for foreach loop support in C#?', 1);


-- Question 1 answers
INSERT INTO Answers (QuestionId, AnswerText, IsCorrect) VALUES
((SELECT QId FROM QUESTIONS WHERE QnText = 'What is the default access modifier for class members in C#?'), 'private', 1),
((SELECT QId FROM QUESTIONS WHERE QnText = 'What is the default access modifier for class members in C#?'), 'public', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'What is the default access modifier for class members in C#?'), 'protected', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'What is the default access modifier for class members in C#?'), 'internal', 0);

-- Question 2 answers
INSERT INTO Answers (QuestionId, AnswerText, IsCorrect) VALUES
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which keyword is used to inherit a class in C#?'), 'extends', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which keyword is used to inherit a class in C#?'), 'inherits', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which keyword is used to inherit a class in C#?'), 'base', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which keyword is used to inherit a class in C#?'), ' : ', 1);

-- Question 3 answers
INSERT INTO Answers (QuestionId, AnswerText, IsCorrect) VALUES
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which of the following is NOT a value type in C#?'), 'int', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which of the following is NOT a value type in C#?'), 'float', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which of the following is NOT a value type in C#?'), 'string', 1),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which of the following is NOT a value type in C#?'), 'bool', 0);

-- Question 4 answers
INSERT INTO Answers (QuestionId, AnswerText, IsCorrect) VALUES
((SELECT QId FROM QUESTIONS WHERE QnText = 'What does the "static" keyword indicate in C#?'), 'Method or variable belongs to the instance', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'What does the "static" keyword indicate in C#?'), 'Method or variable belongs to the class itself', 1),
((SELECT QId FROM QUESTIONS WHERE QnText = 'What does the "static" keyword indicate in C#?'), 'Variable is constant', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'What does the "static" keyword indicate in C#?'), 'Variable is volatile', 0);

-- Question 5 answers
INSERT INTO Answers (QuestionId, AnswerText, IsCorrect) VALUES
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which interface is implemented for foreach loop support in C#?'), 'IEnumerable', 1),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which interface is implemented for foreach loop support in C#?'), 'IEnumerator', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which interface is implemented for foreach loop support in C#?'), 'ICollection', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which interface is implemented for foreach loop support in C#?'), 'IDisposable', 0);

-- Insert new questions
INSERT INTO QUESTIONS (QnText, CategoryId) VALUES
('Which of these types is a reference type in C#?', 1),
('What does the "using" statement do in C#?', 1),
('Which access modifier allows a member to be accessible only within its own class and derived classes?', 1),
('What is the output of 5 / 2 in C#?', 1),
('Which keyword prevents a class from being inherited?', 1);

-- Question: Which of these types is a reference type in C#?
INSERT INTO Answers (QuestionId, AnswerText, IsCorrect) VALUES
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which of these types is a reference type in C#?'), 'int', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which of these types is a reference type in C#?'), 'bool', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which of these types is a reference type in C#?'), 'string', 1),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which of these types is a reference type in C#?'), 'double', 0);

-- Question: What does the "using" statement do in C#?
INSERT INTO Answers (QuestionId, AnswerText, IsCorrect) VALUES
((SELECT QId FROM QUESTIONS WHERE QnText = 'What does the "using" statement do in C#?'), 'Declares a namespace only', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'What does the "using" statement do in C#?'), 'Manages resource disposal automatically', 1),
((SELECT QId FROM QUESTIONS WHERE QnText = 'What does the "using" statement do in C#?'), 'Imports external libraries', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'What does the "using" statement do in C#?'), 'Allocates memory manually', 0);

-- Question: Which access modifier allows a member to be accessible only within its own class and derived classes?
INSERT INTO Answers (QuestionId, AnswerText, IsCorrect) VALUES
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which access modifier allows a member to be accessible only within its own class and derived classes?'), 'private', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which access modifier allows a member to be accessible only within its own class and derived classes?'), 'internal', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which access modifier allows a member to be accessible only within its own class and derived classes?'), 'protected', 1),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which access modifier allows a member to be accessible only within its own class and derived classes?'), 'public', 0);

-- Question: What is the output of 5 / 2 in C#?
INSERT INTO Answers (QuestionId, AnswerText, IsCorrect) VALUES
((SELECT QId FROM QUESTIONS WHERE QnText = 'What is the output of 5 / 2 in C#?'), '2.5', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'What is the output of 5 / 2 in C#?'), '2', 1),
((SELECT QId FROM QUESTIONS WHERE QnText = 'What is the output of 5 / 2 in C#?'), '2.0', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'What is the output of 5 / 2 in C#?'), 'Compilation error', 0);

-- Question: Which keyword prevents a class from being inherited?
INSERT INTO Answers (QuestionId, AnswerText, IsCorrect) VALUES
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which keyword prevents a class from being inherited?'), 'static', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which keyword prevents a class from being inherited?'), 'sealed', 1),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which keyword prevents a class from being inherited?'), 'abstract', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which keyword prevents a class from being inherited?'), 'readonly', 0);

-- Insert 10 MVC questions
INSERT INTO QUESTIONS (QnText, CategoryId) VALUES
('What does MVC stand for?', 2),
('Which component in MVC handles user input?', 2),
('In ASP.NET MVC, which file defines routing rules?', 2),
('What is the default return type of a controller action in ASP.NET MVC?', 2),
('Which attribute is used to restrict access to a controller action in MVC?', 2),
('Which method is used to return JSON data from a controller in MVC?', 2),
('Which Razor syntax is used to write C# code in a .cshtml file?', 2),
('In MVC, where are the HTML helper methods typically used?', 2),
('Which folder contains the view files in an ASP.NET MVC application?', 2),
('What is the purpose of the TempData dictionary in MVC?', 2);


-- Q1: What does MVC stand for?
INSERT INTO Answers (QuestionId, AnswerText, IsCorrect) VALUES
((SELECT QId FROM QUESTIONS WHERE QnText = 'What does MVC stand for?'), 'Model View Controller', 1),
((SELECT QId FROM QUESTIONS WHERE QnText = 'What does MVC stand for?'), 'Module View Compiler', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'What does MVC stand for?'), 'Main Visual Control', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'What does MVC stand for?'), 'Model Version Code', 0);

-- Q2: Which component in MVC handles user input?
INSERT INTO Answers (QuestionId, AnswerText, IsCorrect) VALUES
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which component in MVC handles user input?'), 'Model', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which component in MVC handles user input?'), 'View', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which component in MVC handles user input?'), 'Controller', 1),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which component in MVC handles user input?'), 'RouteConfig', 0);

-- Q3: In ASP.NET MVC, which file defines routing rules?
INSERT INTO Answers (QuestionId, AnswerText, IsCorrect) VALUES
((SELECT QId FROM QUESTIONS WHERE QnText = 'In ASP.NET MVC, which file defines routing rules?'), 'Global.asax', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'In ASP.NET MVC, which file defines routing rules?'), 'Web.config', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'In ASP.NET MVC, which file defines routing rules?'), 'RouteConfig.cs', 1),
((SELECT QId FROM QUESTIONS WHERE QnText = 'In ASP.NET MVC, which file defines routing rules?'), 'Startup.cs', 0);

-- Q4: What is the default return type of a controller action in ASP.NET MVC?
INSERT INTO Answers (QuestionId, AnswerText, IsCorrect) VALUES
((SELECT QId FROM QUESTIONS WHERE QnText = 'What is the default return type of a controller action in ASP.NET MVC?'), 'void', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'What is the default return type of a controller action in ASP.NET MVC?'), 'JsonResult', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'What is the default return type of a controller action in ASP.NET MVC?'), 'ActionResult', 1),
((SELECT QId FROM QUESTIONS WHERE QnText = 'What is the default return type of a controller action in ASP.NET MVC?'), 'ViewResult', 0);

-- Q5: Which attribute is used to restrict access to a controller action in MVC?
INSERT INTO Answers (QuestionId, AnswerText, IsCorrect) VALUES
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which attribute is used to restrict access to a controller action in MVC?'), '[Authorize]', 1),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which attribute is used to restrict access to a controller action in MVC?'), '[AllowAll]', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which attribute is used to restrict access to a controller action in MVC?'), '[HttpPost]', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which attribute is used to restrict access to a controller action in MVC?'), '[Access]', 0);

-- Q6: Which method is used to return JSON data from a controller in MVC?
INSERT INTO Answers (QuestionId, AnswerText, IsCorrect) VALUES
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which method is used to return JSON data from a controller in MVC?'), 'View()', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which method is used to return JSON data from a controller in MVC?'), 'Content()', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which method is used to return JSON data from a controller in MVC?'), 'Json()', 1),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which method is used to return JSON data from a controller in MVC?'), 'PartialView()', 0);

-- Q7: Which Razor syntax is used to write C# code in a .cshtml file?
INSERT INTO Answers (QuestionId, AnswerText, IsCorrect) VALUES
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which Razor syntax is used to write C# code in a .cshtml file?'), '#{ }', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which Razor syntax is used to write C# code in a .cshtml file?'), '@', 1),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which Razor syntax is used to write C# code in a .cshtml file?'), '<%', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which Razor syntax is used to write C# code in a .cshtml file?'), '$', 0);

-- Q8: In MVC, where are the HTML helper methods typically used?
INSERT INTO Answers (QuestionId, AnswerText, IsCorrect) VALUES
((SELECT QId FROM QUESTIONS WHERE QnText = 'In MVC, where are the HTML helper methods typically used?'), 'Controllers', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'In MVC, where are the HTML helper methods typically used?'), 'Models', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'In MVC, where are the HTML helper methods typically used?'), 'Views', 1),
((SELECT QId FROM QUESTIONS WHERE QnText = 'In MVC, where are the HTML helper methods typically used?'), 'RouteConfig', 0);

-- Q9: Which folder contains the view files in an ASP.NET MVC application?
INSERT INTO Answers (QuestionId, AnswerText, IsCorrect) VALUES
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which folder contains the view files in an ASP.NET MVC application?'), 'Models', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which folder contains the view files in an ASP.NET MVC application?'), 'Controllers', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which folder contains the view files in an ASP.NET MVC application?'), 'Views', 1),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which folder contains the view files in an ASP.NET MVC application?'), 'App_Data', 0);

-- Q10: What is the purpose of the TempData dictionary in MVC?
INSERT INTO Answers (QuestionId, AnswerText, IsCorrect) VALUES
((SELECT QId FROM QUESTIONS WHERE QnText = 'What is the purpose of the TempData dictionary in MVC?'), 'Store data permanently', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'What is the purpose of the TempData dictionary in MVC?'), 'Store data between two requests', 1),
((SELECT QId FROM QUESTIONS WHERE QnText = 'What is the purpose of the TempData dictionary in MVC?'), 'Store session data', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'What is the purpose of the TempData dictionary in MVC?'), 'Store static data', 0);


-- Insert 10 SQL questions
INSERT INTO QUESTIONS (QnText, CategoryId) VALUES
('What does SQL stand for?', 3),
('Which SQL statement is used to extract data from a database?', 3),
('Which clause is used to filter records in SQL?', 3),
('What is the purpose of the GROUP BY clause in SQL?', 3),
('Which function returns the number of rows in SQL?', 3),
('What keyword is used to prevent duplicate records in a SELECT statement?', 3),
('Which operator is used to search for a pattern in SQL?', 3),
('What does the JOIN operation do in SQL?', 3),
('Which SQL keyword is used to sort the result-set?', 3),
('What type of join returns all records when there is a match in either table?', 3);


-- Q1: What does SQL stand for?
INSERT INTO Answers (QuestionId, AnswerText, IsCorrect) VALUES
((SELECT QId FROM QUESTIONS WHERE QnText = 'What does SQL stand for?'), 'Structured Query Language', 1),
((SELECT QId FROM QUESTIONS WHERE QnText = 'What does SQL stand for?'), 'Sequential Query Language', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'What does SQL stand for?'), 'Simple Query Language', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'What does SQL stand for?'), 'Server Query Language', 0);

-- Q2: Which SQL statement is used to extract data from a database?
INSERT INTO Answers (QuestionId, AnswerText, IsCorrect) VALUES
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which SQL statement is used to extract data from a database?'), 'GET', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which SQL statement is used to extract data from a database?'), 'EXTRACT', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which SQL statement is used to extract data from a database?'), 'SELECT', 1),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which SQL statement is used to extract data from a database?'), 'READ', 0);

-- Q3: Which clause is used to filter records in SQL?
INSERT INTO Answers (QuestionId, AnswerText, IsCorrect) VALUES
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which clause is used to filter records in SQL?'), 'WHERE', 1),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which clause is used to filter records in SQL?'), 'ORDER BY', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which clause is used to filter records in SQL?'), 'GROUP BY', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which clause is used to filter records in SQL?'), 'HAVING', 0);

-- Q4: What is the purpose of the GROUP BY clause in SQL?
INSERT INTO Answers (QuestionId, AnswerText, IsCorrect) VALUES
((SELECT QId FROM QUESTIONS WHERE QnText = 'What is the purpose of the GROUP BY clause in SQL?'), 'Sorts data', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'What is the purpose of the GROUP BY clause in SQL?'), 'Filters rows', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'What is the purpose of the GROUP BY clause in SQL?'), 'Groups rows that have the same values', 1),
((SELECT QId FROM QUESTIONS WHERE QnText = 'What is the purpose of the GROUP BY clause in SQL?'), 'Deletes duplicate rows', 0);

-- Q5: Which function returns the number of rows in SQL?
INSERT INTO Answers (QuestionId, AnswerText, IsCorrect) VALUES
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which function returns the number of rows in SQL?'), 'SUM()', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which function returns the number of rows in SQL?'), 'COUNT()', 1),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which function returns the number of rows in SQL?'), 'MAX()', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which function returns the number of rows in SQL?'), 'ROWS()', 0);

-- Q6: What keyword is used to prevent duplicate records in a SELECT statement?
INSERT INTO Answers (QuestionId, AnswerText, IsCorrect) VALUES
((SELECT QId FROM QUESTIONS WHERE QnText = 'What keyword is used to prevent duplicate records in a SELECT statement?'), 'UNIQUE', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'What keyword is used to prevent duplicate records in a SELECT statement?'), 'ONLY', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'What keyword is used to prevent duplicate records in a SELECT statement?'), 'DISTINCT', 1),
((SELECT QId FROM QUESTIONS WHERE QnText = 'What keyword is used to prevent duplicate records in a SELECT statement?'), 'NO DUPLICATES', 0);

-- Q7: Which operator is used to search for a pattern in SQL?
INSERT INTO Answers (QuestionId, AnswerText, IsCorrect) VALUES
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which operator is used to search for a pattern in SQL?'), '=', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which operator is used to search for a pattern in SQL?'), 'LIKE', 1),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which operator is used to search for a pattern in SQL?'), 'MATCHES', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which operator is used to search for a pattern in SQL?'), 'PATTERN', 0);

-- Q8: What does the JOIN operation do in SQL?
INSERT INTO Answers (QuestionId, AnswerText, IsCorrect) VALUES
((SELECT QId FROM QUESTIONS WHERE QnText = 'What does the JOIN operation do in SQL?'), 'Deletes rows in two tables', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'What does the JOIN operation do in SQL?'), 'Updates two tables at once', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'What does the JOIN operation do in SQL?'), 'Combines rows from two or more tables', 1),
((SELECT QId FROM QUESTIONS WHERE QnText = 'What does the JOIN operation do in SQL?'), 'Creates new indexes', 0);

-- Q9: Which SQL keyword is used to sort the result-set?
INSERT INTO Answers (QuestionId, AnswerText, IsCorrect) VALUES
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which SQL keyword is used to sort the result-set?'), 'GROUP BY', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which SQL keyword is used to sort the result-set?'), 'SORT', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which SQL keyword is used to sort the result-set?'), 'ORDER BY', 1),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which SQL keyword is used to sort the result-set?'), 'ARRANGE BY', 0);

-- Q10: What type of join returns all records when there is a match in either table?
INSERT INTO Answers (QuestionId, AnswerText, IsCorrect) VALUES
((SELECT QId FROM QUESTIONS WHERE QnText = 'What type of join returns all records when there is a match in either table?'), 'INNER JOIN', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'What type of join returns all records when there is a match in either table?'), 'LEFT JOIN', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'What type of join returns all records when there is a match in either table?'), 'RIGHT JOIN', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'What type of join returns all records when there is a match in either table?'), 'FULL OUTER JOIN', 1);

-- Insert 10 ADO.NET questions
INSERT INTO QUESTIONS (QnText, CategoryId) VALUES
('What does ADO.NET stand for?', 4),
('Which class is used to open a connection to a SQL Server database in ADO.NET?', 4),
('Which object in ADO.NET is used to read data in a forward-only, read-only manner?', 4),
('Which ADO.NET object is used to fill data into a DataSet?', 4),
('Which method is used to execute a query that returns a single value?', 4),
('Which method is used to execute INSERT, UPDATE, or DELETE commands?', 4),
('Which namespace is commonly used for ADO.NET?', 4),
('What is the purpose of the DataSet in ADO.NET?', 4),
('Which ADO.NET object represents a SQL command to be executed?', 4),
('Which property of SqlConnection is used to check the state of the connection?', 4);


-- Q1: What does ADO.NET stand for?
INSERT INTO Answers (QuestionId, AnswerText, IsCorrect) VALUES
((SELECT QId FROM QUESTIONS WHERE QnText = 'What does ADO.NET stand for?'), 'ActiveX Data Objects .NET', 1),
((SELECT QId FROM QUESTIONS WHERE QnText = 'What does ADO.NET stand for?'), 'Application Data Objects .NET', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'What does ADO.NET stand for?'), 'Advanced Data Output .NET', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'What does ADO.NET stand for?'), 'Access Data Operation .NET', 0);

-- Q2: Which class is used to open a connection to a SQL Server database in ADO.NET?
INSERT INTO Answers (QuestionId, AnswerText, IsCorrect) VALUES
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which class is used to open a connection to a SQL Server database in ADO.NET?'), 'SqlCommand', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which class is used to open a connection to a SQL Server database in ADO.NET?'), 'SqlConnection', 1),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which class is used to open a connection to a SQL Server database in ADO.NET?'), 'SqlDataAdapter', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which class is used to open a connection to a SQL Server database in ADO.NET?'), 'SqlReader', 0);

-- Q3: Which object in ADO.NET is used to read data in a forward-only, read-only manner?
INSERT INTO Answers (QuestionId, AnswerText, IsCorrect) VALUES
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which object in ADO.NET is used to read data in a forward-only, read-only manner?'), 'DataSet', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which object in ADO.NET is used to read data in a forward-only, read-only manner?'), 'SqlCommand', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which object in ADO.NET is used to read data in a forward-only, read-only manner?'), 'SqlDataReader', 1),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which object in ADO.NET is used to read data in a forward-only, read-only manner?'), 'SqlDataAdapter', 0);

-- Q4: Which ADO.NET object is used to fill data into a DataSet?
INSERT INTO Answers (QuestionId, AnswerText, IsCorrect) VALUES
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which ADO.NET object is used to fill data into a DataSet?'), 'SqlCommand', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which ADO.NET object is used to fill data into a DataSet?'), 'SqlConnection', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which ADO.NET object is used to fill data into a DataSet?'), 'SqlDataAdapter', 1),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which ADO.NET object is used to fill data into a DataSet?'), 'SqlDataReader', 0);

-- Q5: Which method is used to execute a query that returns a single value?
INSERT INTO Answers (QuestionId, AnswerText, IsCorrect) VALUES
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which method is used to execute a query that returns a single value?'), 'ExecuteReader()', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which method is used to execute a query that returns a single value?'), 'ExecuteScalar()', 1),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which method is used to execute a query that returns a single value?'), 'ExecuteNonQuery()', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which method is used to execute a query that returns a single value?'), 'ExecuteAdapter()', 0);

-- Q6: Which method is used to execute INSERT, UPDATE, or DELETE commands?
INSERT INTO Answers (QuestionId, AnswerText, IsCorrect) VALUES
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which method is used to execute INSERT, UPDATE, or DELETE commands?'), 'ExecuteReader()', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which method is used to execute INSERT, UPDATE, or DELETE commands?'), 'ExecuteScalar()', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which method is used to execute INSERT, UPDATE, or DELETE commands?'), 'ExecuteNonQuery()', 1),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which method is used to execute INSERT, UPDATE, or DELETE commands?'), 'ExecuteXmlReader()', 0);

-- Q7: Which namespace is commonly used for ADO.NET?
INSERT INTO Answers (QuestionId, AnswerText, IsCorrect) VALUES
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which namespace is commonly used for ADO.NET?'), 'System.Data.SqlClient', 1),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which namespace is commonly used for ADO.NET?'), 'System.Web.SqlClient', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which namespace is commonly used for ADO.NET?'), 'System.Data.Common', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which namespace is commonly used for ADO.NET?'), 'System.Linq', 0);

-- Q8: What is the purpose of the DataSet in ADO.NET?
INSERT INTO Answers (QuestionId, AnswerText, IsCorrect) VALUES
((SELECT QId FROM QUESTIONS WHERE QnText = 'What is the purpose of the DataSet in ADO.NET?'), 'Connects to the database directly', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'What is the purpose of the DataSet in ADO.NET?'), 'Stores data in-memory as tables', 1),
((SELECT QId FROM QUESTIONS WHERE QnText = 'What is the purpose of the DataSet in ADO.NET?'), 'Reads single row only', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'What is the purpose of the DataSet in ADO.NET?'), 'Executes SQL commands', 0);

-- Q9: Which ADO.NET object represents a SQL command to be executed?
INSERT INTO Answers (QuestionId, AnswerText, IsCorrect) VALUES
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which ADO.NET object represents a SQL command to be executed?'), 'SqlConnection', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which ADO.NET object represents a SQL command to be executed?'), 'SqlDataAdapter', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which ADO.NET object represents a SQL command to be executed?'), 'SqlCommand', 1),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which ADO.NET object represents a SQL command to be executed?'), 'SqlDataReader', 0);

-- Q10: Which property of SqlConnection is used to check the state of the connection?
INSERT INTO Answers (QuestionId, AnswerText, IsCorrect) VALUES
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which property of SqlConnection is used to check the state of the connection?'), 'Status', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which property of SqlConnection is used to check the state of the connection?'), 'Open', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which property of SqlConnection is used to check the state of the connection?'), 'State', 1),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which property of SqlConnection is used to check the state of the connection?'), 'ConnectionStatus', 0);

-- Insert 10 ASP.NET questions
INSERT INTO QUESTIONS (QnText, CategoryId) VALUES
('What does ASP stand for in ASP.NET?', 5),
('Which of the following is a server-side technology?', 5),
('What file extension is used for ASP.NET web forms?', 5),
('Which method is used to redirect to another page in ASP.NET?', 5),
('Which object is used to store user-specific information in ASP.NET?', 5),
('Which event is triggered when a page is first requested?', 5),
('What is the default authentication mode in ASP.NET?', 5),
('Which directive is used to bind a code-behind file to an .aspx page?', 5),
('What is ViewState used for in ASP.NET?', 5),
('Which control is used to post data back to the server in ASP.NET?', 5);

-- Q1: What does ASP stand for in ASP.NET?
INSERT INTO Answers (QuestionId, AnswerText, IsCorrect) VALUES
((SELECT QId FROM QUESTIONS WHERE QnText = 'What does ASP stand for in ASP.NET?'), 'Active Server Pages', 1),
((SELECT QId FROM QUESTIONS WHERE QnText = 'What does ASP stand for in ASP.NET?'), 'Application Service Pages', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'What does ASP stand for in ASP.NET?'), 'Active Script Pages', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'What does ASP stand for in ASP.NET?'), 'Advanced Server Protocol', 0);

-- Q2: Which of the following is a server-side technology?
INSERT INTO Answers (QuestionId, AnswerText, IsCorrect) VALUES
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which of the following is a server-side technology?'), 'HTML', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which of the following is a server-side technology?'), 'CSS', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which of the following is a server-side technology?'), 'JavaScript', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which of the following is a server-side technology?'), 'ASP.NET', 1);

-- Q3: What file extension is used for ASP.NET web forms?
INSERT INTO Answers (QuestionId, AnswerText, IsCorrect) VALUES
((SELECT QId FROM QUESTIONS WHERE QnText = 'What file extension is used for ASP.NET web forms?'), '.html', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'What file extension is used for ASP.NET web forms?'), '.aspx', 1),
((SELECT QId FROM QUESTIONS WHERE QnText = 'What file extension is used for ASP.NET web forms?'), '.cs', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'What file extension is used for ASP.NET web forms?'), '.xml', 0);

-- Q4: Which method is used to redirect to another page in ASP.NET?
INSERT INTO Answers (QuestionId, AnswerText, IsCorrect) VALUES
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which method is used to redirect to another page in ASP.NET?'), 'Response.Transfer()', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which method is used to redirect to another page in ASP.NET?'), 'Server.Transfer()', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which method is used to redirect to another page in ASP.NET?'), 'Response.Redirect()', 1),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which method is used to redirect to another page in ASP.NET?'), 'Page.Redirect()', 0);

-- Q5: Which object is used to store user-specific information in ASP.NET?
INSERT INTO Answers (QuestionId, AnswerText, IsCorrect) VALUES
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which object is used to store user-specific information in ASP.NET?'), 'ViewState', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which object is used to store user-specific information in ASP.NET?'), 'Session', 1),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which object is used to store user-specific information in ASP.NET?'), 'Application', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which object is used to store user-specific information in ASP.NET?'), 'Cache', 0);

-- Q6: Which event is triggered when a page is first requested?
INSERT INTO Answers (QuestionId, AnswerText, IsCorrect) VALUES
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which event is triggered when a page is first requested?'), 'Page_Init', 1),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which event is triggered when a page is first requested?'), 'Page_Load', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which event is triggered when a page is first requested?'), 'Page_PreRender', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which event is triggered when a page is first requested?'), 'Page_Unload', 0);

-- Q7: What is the default authentication mode in ASP.NET?
INSERT INTO Answers (QuestionId, AnswerText, IsCorrect) VALUES
((SELECT QId FROM QUESTIONS WHERE QnText = 'What is the default authentication mode in ASP.NET?'), 'Forms', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'What is the default authentication mode in ASP.NET?'), 'Windows', 1),
((SELECT QId FROM QUESTIONS WHERE QnText = 'What is the default authentication mode in ASP.NET?'), 'Passport', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'What is the default authentication mode in ASP.NET?'), 'None', 0);

-- Q8: Which directive is used to bind a code-behind file to an .aspx page?
INSERT INTO Answers (QuestionId, AnswerText, IsCorrect) VALUES
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which directive is used to bind a code-behind file to an .aspx page?'), '@CodeBehind', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which directive is used to bind a code-behind file to an .aspx page?'), '@Page', 1),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which directive is used to bind a code-behind file to an .aspx page?'), '@Bind', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which directive is used to bind a code-behind file to an .aspx page?'), '@Model', 0);

-- Q9: What is ViewState used for in ASP.NET?
INSERT INTO Answers (QuestionId, AnswerText, IsCorrect) VALUES
((SELECT QId FROM QUESTIONS WHERE QnText = 'What is ViewState used for in ASP.NET?'), 'Store data in the server memory', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'What is ViewState used for in ASP.NET?'), 'Maintain data during page round trips', 1),
((SELECT QId FROM QUESTIONS WHERE QnText = 'What is ViewState used for in ASP.NET?'), 'Store data in cookies', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'What is ViewState used for in ASP.NET?'), 'Enable multi-threading', 0);

-- Q10: Which control is used to post data back to the server in ASP.NET?
INSERT INTO Answers (QuestionId, AnswerText, IsCorrect) VALUES
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which control is used to post data back to the server in ASP.NET?'), 'TextBox', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which control is used to post data back to the server in ASP.NET?'), 'Label', 0),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which control is used to post data back to the server in ASP.NET?'), 'Button', 1),
((SELECT QId FROM QUESTIONS WHERE QnText = 'Which control is used to post data back to the server in ASP.NET?'), 'Literal', 0);

