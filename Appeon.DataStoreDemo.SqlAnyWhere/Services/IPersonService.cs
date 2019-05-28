using PowerBuilder.Data;

namespace Appeon.DataStoreDemo.SqlAnyWhere.Services
{
    public interface IPersonService : IServiceBase
    {
        int SavePerson(IDataStore person, IDataStore addresses, IDataStore phones, IDataStore customers);

        string DeletePerson(int personId);

    }
}
