using SnapObjects.Data;
using System;
using System.ComponentModel.DataAnnotations;

namespace Appeon.DataStoreDemo
{
    [FromTable("Store", Schema= "Sales")]
    [UpdateWhereStrategy(UpdateWhereStrategy.KeyColumns)]
    public class D_Dddw_Store
    {
        [Key]
        public Int32 Businessentityid { get; set; }

        public String Name { get; set; }

    }
}
