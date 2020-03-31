using DWNet.Data;

namespace Appeon.DataStoreDemo.SqlServer.Services
{
    public interface IPersonService : IServiceBase
    {
        int SavePerson(IDataStore person, IDataStore addresses, IDataStore phones, IDataStore customers);

        string DeletePerson(int personId);

    }
}
