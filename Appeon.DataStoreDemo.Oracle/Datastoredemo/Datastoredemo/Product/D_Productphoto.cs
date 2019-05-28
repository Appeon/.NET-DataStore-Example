using SnapObjects.Data;
using System;
using System.ComponentModel.DataAnnotations;

namespace Appeon.DataStoreDemo.Oracle
{
    [FromTable("ProductPhoto", Schema = "Production")]
    [UpdateWhereStrategy(UpdateWhereStrategy.KeyAndConcurrencyCheckColumns)]
    public class D_Productphoto
    {
        [Key]
        [Identity]
        public Int32 Productphotoid { get; set; }

        [ConcurrencyCheck]
        public String Largephotofilename { get; set; }

        [ConcurrencyCheck]
        public DateTime Modifieddate { get; set; }

    }
}
