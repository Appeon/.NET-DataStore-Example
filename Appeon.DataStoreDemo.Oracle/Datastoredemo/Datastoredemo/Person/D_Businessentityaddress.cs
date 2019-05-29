using SnapObjects.Data;
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Appeon.DataStoreDemo.Oracle
{
    [Table("BusinessEntityAddress", Schema = "Person")]
    [UpdateWhereStrategy(UpdateWhereStrategy.KeyAndConcurrencyCheckColumns)]
    public class D_Businessentityaddress
    {
        [Key]
        public Int32 Businessentityid { get; set; }

        [Key]
        public Int32 Addressid { get; set; }

        [Key]
        public Int32 Addresstypeid { get; set; }

        [ConcurrencyCheck]
        public DateTime Modifieddate { get; set; }

    }
}
