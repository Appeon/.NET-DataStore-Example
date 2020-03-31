# <b>NET DataStore Example</b>

This C# project uses .NET DataStore from [DWNet.Data](<https://www.nuget.org/packages/DWNet.Data/>) for creating Web APIs.  It makes use of the latest released Appeon PowerBuilder 2019 R2 and SnapDevelop 2019 R2, and shows how CRUD operations and transaction management works in .NET DataStore.

##### Sample Project Structure

This is C# project. This project uses .NET DataStore from [DWNet.Data](<https://www.nuget.org/packages/DWNet.Data/>). 

Four different sets of project files are included, respectively for working with different databases (SQL Server, Oracle, SQL Anywhere, and PostgreSQL).

The project is structured as follows.

```
|—— .NET-DataStore-Example		Implemented with .NET DataStore from DWNet.Data
    |—— Appeon.DataStoreDemo.SqlServer       For working with SQL Server
```

There is a ready-to-use example client application for you to test the Web APIs created from the project:

- [PowerBuilder project](https://github.com/Appeon/PowerBuilder-RestClient-Example). Download this PowerBuilder demo application, and use RESTClient in the application to call the Web APIs.

##### Setting Up the Project

1. Open the PowerBuilder project in PowerBuilder 2019 R2.

2. Open the C# project in SnapDevelop 2019 R2. 

3. In NuGet Package Manager window in SnapDevelop, make sure that Internet connection is available and the option "Include prerelease" is selected, so that the NuGet package can be restored.

4. Download the SQL server backup file from [.NET-Project-Example-Database](https://github.com/Appeon/.NET-Project-Example-Database), and restore the database using the downloaded database backup file.

5. Open the configuration file *appsettings.json* in the project, modify the ConnectionStrings with the actual database connection information. 

   ```json
   //Keep the database connection name as the default “AdventureWorks” or change it to a name you prefer to use, and change the Data Source, User ID, Password and Initial Catalog according to the actual settings
   "ConnectionStrings": { "AdventureWorks": "Data Source=127.0.0.1; Initial Catalog=AdventureWorks; Integrated Security=False; User ID=sa; Password=123456; Pooling=True; Min Pool Size=0; Max Pool Size=100; ApplicationIntent=ReadWrite" } 
   ```

6. In the ConfigureServices method of *Startup.cs*, go to the following line, and make sure the ConnectionString name is the same as the database connection name specified in step #5.

   ```C#
   //Note: Change "OrderContext" if you have changed the default DataContext file name; change the "AdventureWorks" if you have changed the database connection name in appsettings.json 
   services.AddDataContext<OrderContext>(m => m.UseSqlServer(Configuration["ConnectionStrings:AdventureWorks"])); 
   ```

