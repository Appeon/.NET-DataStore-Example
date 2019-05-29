using SnapObjects.Data;
using SnapObjects.Data.SqlServer;

namespace Appeon.DataStoreDemo.SqlServer
{
    public class OrderContext : SqlServerDataContext
    {
        
        public OrderContext(string connectionString)
            : this(new SqlServerDataContextOptions<OrderContext>(connectionString))
        {
        }

        public OrderContext(IDataContextOptions<OrderContext> options)
            : base(options)
        {
        }

        public OrderContext(IDataContextOptions options)
            : base(options)
        {
        }
    }
}
