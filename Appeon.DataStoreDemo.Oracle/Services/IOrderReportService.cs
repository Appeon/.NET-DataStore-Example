using PowerBuilder.Data;

namespace Appeon.DataStoreDemo.Oracle.Services
{
    public interface IOrderReportService : IServiceBase
    {
        IDataStore RetrieveSubCategorySalesReport(params object[] salesmonth);
    }
}

