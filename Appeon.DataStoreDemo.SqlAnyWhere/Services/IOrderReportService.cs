using PowerBuilder.Data;

namespace Appeon.DataStoreDemo.SqlAnyWhere.Services
{
    public interface IOrderReportService : IServiceBase
    {
        IDataStore RetrieveSubCategorySalesReport(params object[] salesmonth);
    }
}

