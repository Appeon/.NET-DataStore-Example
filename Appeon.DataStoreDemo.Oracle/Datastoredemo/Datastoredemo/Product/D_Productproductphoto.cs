using SnapObjects.Data;
using System;
using System.ComponentModel.DataAnnotations;

namespace Appeon.DataStoreDemo.Oracle
{
    [FromTable("ProductProductPhoto",Schema ="Production")]
    [UpdateWhereStrategy(UpdateWhereStrategy.KeyAndConcurrencyCheckColumns)]
    public class D_Productproductphoto
    {
        [Key]
        public int Productid { get; set; }

        [Key]
        public Int32 Productphotoid { get; set; }

        [ConcurrencyCheck]
        public Int32 Primary { get; set; }

        [ConcurrencyCheck]
        public DateTime Modifieddate { get; set; }

    }
}
