using SnapObjects.Data;
using System;

namespace Appeon.DataStoreDemo.SqlAnyWhere
{
    [FromTable("vStoreWithContacts", Schema= "Sales")]
    [UpdateWhereStrategy(UpdateWhereStrategy.KeyColumns)]
    public class D_Dddw_Persontype
    {
        public String Persontype { get; set; }

        public String Typedesc { get; set; }

    }
}
