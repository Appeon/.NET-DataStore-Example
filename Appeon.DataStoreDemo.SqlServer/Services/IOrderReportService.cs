using DWNet.Data;

namespace Appeon.DataStoreDemo.SqlServer.Services
{
    public interface IOrderReportService : IServiceBase
    {
        IDataStore RetrieveSubCategorySalesReport(params object[] salesmonth);
    }
}

