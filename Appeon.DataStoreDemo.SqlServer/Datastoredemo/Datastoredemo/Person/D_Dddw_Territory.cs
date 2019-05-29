using SnapObjects.Data;
using System;

namespace Appeon.DataStoreDemo.SqlServer
{
    [FromTable("SalesTerritory", Schema= "Sales")]
    [UpdateWhereStrategy(UpdateWhereStrategy.KeyColumns)]
    [SqlOrderBy("Territoryid")]
    public class D_Dddw_Territory
    {
        public Int32 Territoryid { get; set; }

        public String Name { get; set; }

    }
}
