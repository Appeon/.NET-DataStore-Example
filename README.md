# <b>NET DataStore Example</b>

This C# project uses .NET DataStore from [PowerBuilder.Data](<https://www.nuget.org/packages/PowerBuilder.Data/>) for creating Web APIs.  It makes use of the latest released Appeon PowerBuilder 2019, including SnapObjects (PB Edition), and shows how CRUD operations and transaction management works in .NET DataStore.

##### Sample Project Structure

This is C# project. This project uses .NET DataStore from [PowerBuilder.Data](<https://www.nuget.org/packages/PowerBuilder.Data/>). 

Four different sets of project files are included, respectively for working with different databases (SQL Server, Oracle, SQL Anywhere, and PostgreSQL).

The project is structured as follows.

```
|—— .NET-DataStore-Example		Implemented with .NET DataStore from PowerBuilder.Data
    |—— Appeon.DataStoreDemo.SqlServer       For working with SQL Server
    |—— Appeon.DataStoreDemo.Oracle          For working with Oracle
    |—— Appeon.DataStoreDemo.SqlAnywhere     For working with SQL Anywhere
    |—— Appeon.DataStoreDemo.PostgreSQL      For working with PostgreSQL
```

There is a ready-to-use example client application for you to test the Web APIs created from the project:

- [PowerBuilder project](https://github.com/Appeon/PowerBuilder-RestClient-Example-Repository). Download this PowerBuilder demo application, and use RESTClient in the application to call the Web APIs.

##### Setting Up the Project

1. Open the PowerBuilder project in PowerBuilder 2019.

2. Open the C# project in SnapDevelop (PB Edition). 

3. In NuGet Package Manager window in SnapDevelop, make sure that Internet connection is available and the option "Include prerelease" is selected, so that the NuGet package can be restored.

4. Download the database backup file from [.NET-Project-Example-Database](https://github.com/Appeon/.NET-Project-Example-Database) according to the database you are using, and restore the database using the downloaded database backup file.

5. In SnapDevelop (PB Edition), keep the C# project that works with the database you have installed, and remove the other C# projects. 

   For example, if you have installed the Oracle database, keep the Appeon.DataStoreDemo.Oracle project, and remove the Appeon.DataStoreDemo.PostgreSQL, Appeon.DataStoreDemo.SqlAnywhere, and Appeon.DataStoreDemo.SqlServer projects.

6. Open the configuration file *appsettings.json* in the project, modify the ConnectionStrings with the actual database connection information. 

   If your project is Appeon.DataStoreDemo.SqlServer:

   ```json
   //Keep the database connection name as the default “AdventureWorks” or change it to a name you prefer to use, and change the Data Source, User ID, Password and Initial Catalog according to the actual settings
   "ConnectionStrings": { "AdventureWorks": "Data Source=127.0.0.1; Initial Catalog=AdventureWorks; Integrated Security=False; User ID=sa; Password=123456; Pooling=True; Min Pool Size=0; Max Pool Size=100; ApplicationIntent=ReadWrite" } 
   ```

   If your project is Appeon.DataStoreDemo.Oracle:

   ```json
   //Keep the database connection name as the default “AdventureWorks” or change it to a name you prefer to use, and change the HOST, User ID, Password to the actual settings
   "ConnectionStrings": { "AdventureWorks": "User Id=sa;Password=123456; Data Source=(DESCRIPTIOn=(ADDRESS=(PROTOCOL=Tcp)(HOST=127.0.0.1)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=ADVENTUREWORKS)));"  }   
   ```
   If your project is Appeon.DataStoreDemo.SqlAnywhere:

   ```json
   //Keep the database connection name as the default “AdventureWorks” or change it to a name you prefer to use, and change the uid, pwd to the actual settings
   "ConnectionStrings": { "AdventureWorks": "DSN=ASA_AdventureWorks;uid=sa;pwd=123456"  } 
   ```

   If your project is Appeon.DataStoreDemo.PostgreSQL:

   ```json
   //Keep the database connection name as the default “AdventureWorks” or change it to a name you prefer to use, and change the HOST, User ID, Password to the actual settings
   "ConnectionStrings": { "AdventureWorks":  "PORT=5432;DATABASE=AdventureWorks;HOST=127.0.0.1;PASSWORD=sa;USER ID=123456"  } 
   ```

7. In the ConfigureServices method of *Startup.cs*, go to the following line, and make sure the ConnectionString name is the same as the database connection name specified in step #6.

   If your project is Appeon.DataStoreDemo.SqlServer:

   ```C#
   //Note: Change "OrderContext" if you have changed the default DataContext file name; change the "AdventureWorks" if you have changed the database connection name in appsettings.json 
   services.AddDataContext<OrderContext>(m => m.UseSqlServer(Configuration["ConnectionStrings:AdventureWorks"])); 
   ```

   If your project is Appeon.DataStoreDemo.Oracle:

   ```C#
   //Note: Change "OrderContext" if you have changed the default DataContext file name; change the "AdventureWorks" if you have changed the database connection name in appsettings.json 
   services.AddDataContext<OrderContext>(m => m.UseOracle(Configuration["ConnectionStrings:AdventureWorks"]));  
   ```

   If your project is Appeon.DataStoreDemo.SqlAnywhere:

   ```C#
   //Note: Change "OrderContext" if you have changed the default DataContext file name; change the "AdventureWorks" if you have changed the database connection name in appsettings.json
   services.AddDataContext<OrderContext>(m => m.UseOdbc(Configuration["ConnectionStrings:AdventureWorks"])); 
   ```

   If your project is Appeon.DataStoreDemo.PostgreSQL:

   ```C#
   //Note: Change "OrderContext" if you have changed the default DataContext file name; change the "AdventureWorks" if you have changed the database connection name in appsettings.json
   services.AddDataContext<OrderContext>(m => m.UsePostgreSql(Configuration["ConnectionStrings:AdventureWorks"])); 
   ```

