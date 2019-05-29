using SnapObjects.Data;
using System;
using System.ComponentModel.DataAnnotations;

namespace Appeon.DataStoreDemo.SqlServer
{
    [FromTable("BusinessEntity", Schema = "Person")]
    [UpdateWhereStrategy(UpdateWhereStrategy.KeyAndConcurrencyCheckColumns)]
    public class D_Businessentity
    {
        [Key]
        [Identity]
        public Int32 Businessentityid { get; set; }

        [ConcurrencyCheck]
        [SqlDefaultValue("(newid())")]
        public Guid Rowguid { get; set; }

        [ConcurrencyCheck]
        public DateTime Modifieddate { get; set; }
        
    }
}
