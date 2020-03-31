namespace Appeon.DataStoreDemo.SqlServer.Services
{
    /// <summary>
    /// This Service needs to be injected into the ConfigureServices method of the Startup class. Sample code as follows:
    /// services.AddScoped<IAddressService, AddressService>();
    /// </summary>
    public class AddressService : ServiceBase, IAddressService
    {
        public AddressService(OrderContext context)
            : base(context)
        {
        }
    }
}
