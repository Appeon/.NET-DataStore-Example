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
        
        public String Carriertrackingnumber { get; set; }
        
        public Int16 Orderqty { get; set; }
        
        public Int32 Productid { get; set; }
        
        public Int32 Specialofferid { get; set; }
        
        public Decimal Unitprice { get; set; }
        
        public Decimal Unitpricediscount { get; set; }

        [SqlCompute("Linetotal")]
        public Decimal Linetotal { get; set; }

        public DateTime Modifieddate { get; set; }

    }
}
