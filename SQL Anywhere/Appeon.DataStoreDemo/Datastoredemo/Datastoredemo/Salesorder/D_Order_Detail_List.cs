using SnapObjects.Data;
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Appeon.DataStoreDemo
{
    [Table("SalesOrderDetail",Schema ="Sales")]
    [UpdateWhereStrategy(UpdateWhereStrategy.KeyAndConcurrencyCheckColumns)]
    public class D_Order_Detail_List
    {
        [Key]
        public Int32 Salesorderid { get; set; }

        [Key]
        [Identity]
        public Int32 Salesorderdetailid { get; set; }

        [ConcurrencyCheck]
        public String Carriertrackingnumber { get; set; }

        [ConcurrencyCheck]
        public Int16 Orderqty { get; set; }

        [ConcurrencyCheck]
        public Int32 Productid { get; set; }

        [ConcurrencyCheck]
        public Int32 Specialofferid { get; set; }

        [ConcurrencyCheck]
        public Decimal Unitprice { get; set; }

        [ConcurrencyCheck]
        public Decimal Unitpricediscount { get; set; }

        [SqlCompute("Linetotal")]
        public Decimal Linetotal { get; set; }

        public DateTime Modifieddate { get; set; }

    }
}
