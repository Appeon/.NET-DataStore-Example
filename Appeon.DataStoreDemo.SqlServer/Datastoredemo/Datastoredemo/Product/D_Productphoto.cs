using SnapObjects.Data;
using System;
using System.ComponentModel.DataAnnotations;

namespace Appeon.DataStoreDemo.SqlServer
{
    [FromTable("ProductPhoto", Schema = "Production")]
    [UpdateWhereStrategy(UpdateWhereStrategy.KeyAndConcurrencyCheckColumns)]
    public class D_Productphoto
    {
        [Key]
        [Identity]
        public Int32 Productphotoid { get; set; }

        public String Largephotofilename { get; set; }

        public DateTime Modifieddate { get; set; }

    }
}
