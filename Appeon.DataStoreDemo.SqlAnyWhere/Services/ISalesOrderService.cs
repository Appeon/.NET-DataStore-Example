using PowerBuilder.Data;

namespace Appeon.DataStoreDemo.SqlAnyWhere.Services
{
    public interface ISalesOrderService : IServiceBase
    {
        int SaveSalesOrderAndDetail(IDataStore salesOrderHeaders, IDataStore salesOrderDetails);

        string DeleteSalesOrder(int saleOrderId);

    }
}
