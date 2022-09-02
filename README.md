# <b>.NET DataStore Example</b>

This demo project targets .NET 6, and uses .NET DataStore to create the Web APIs that allow you to perform CRUD operations and transaction management with SQL Server. This demo also provides a PowerBuilder project that you can [download](https://github.com/Appeon/PowerBuilder-RestClient-Example) and use as a client application to call the Web APIs.   
Note that this demo implements the Web APIs with synchronous methods. Asynchronous methods are planned for a future release.

#### Prerequisites

- SnapDevelop 2022     
- PowerBuidler 2022    
- SQL Server 2019, 2017, or 2016  

#### Setting Up This Demo

1. Download the SQL Server backup file *AdventureWorks_for_sqlserver.zip* from [.NET-Project-Example-Database](https://github.com/Appeon/.NET-Project-Example-Database), and restore the database using the backup file.

2. Download and open this demo in SnapDevelop. Make sure you’re connected to the Internet so that the NuGet packages required by the project can be restored.

3. In the **Solution Explorer**, open the file *appsettings.json*, and modify the Data Source, Initial Catalog, User ID, and Password in the connection string based on your environment. Note that the value of the Initial Catalog must be the same as the name of database (AdventureWorks2012 by default) you restored in the SQL Server.

   ```json
   "ConnectionStrings": { "AdventureWorks": "Data Source=127.0.0.1; Initial Catalog=AdventureWorks2012; Integrated Security=False; User ID=sa; Password=123456; Pooling=True; Min Pool Size=0; Max Pool Size=100; ApplicationIntent=ReadWrite;Trust Server Certificate=True" }
   ```

   The code above also specifies the connection name as “AdventureWorks”. The connection name must be the same as the one in the ConfigureServices method of *Startup.cs*:

   ```C#
   services.AddDataContext<OrderContext>(m => m.UseSqlServer(Configuration, "AdventureWorks"));  
   ```



