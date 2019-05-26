using SnapObjects.Data;
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Appeon.DataStoreDemo
{
    [Table("SalesOrderHeader", Schema = "Sales")]
    [UpdateWhereStrategy(UpdateWhereStrategy.KeyAndConcurrencyCheckColumns)]
    public class D_Order_Header_Free
    {
        [Key]
        [Identity]
        public Int32 Salesorderid { get; set; }
        
        public int Revisionnumber { get; set; }
        
        public DateTime Orderdate { get; set; }
        
        public DateTime Duedate { get; set; }
        
        public DateTime? Shipdate { get; set; }
        
        public int Status { get; set; }
        
        public Boolean Onlineorderflag { get; set; }

        [SqlCompute("(isnull(N'SO'+CONVERT([nvarchar](23),[SalesOrderID]),N'*** ERROR ***'))")]
        public String Salesordernumber { get; set; }
        
        public String Purchaseordernumber { get; set; }
        
        public String Accountnumber { get; set; }
        
        public Int32 Customerid { get; set; }
        
        public Int32? Salespersonid { get; set; }
        
        public Int32? Territoryid { get; set; }
        
        public Int32 Billtoaddressid { get; set; }
        
        public Int32 Shiptoaddressid { get; set; }
        
        public Int32 Shipmethodid { get; set; }
        
        public Int32? Creditcardid { get; set; }
        
        public String Creditcardapprovalcode { get; set; }
        
        public Int32? Currencyrateid { get; set; }
        
        public Decimal? Subtotal { get; set; }
        
        public Decimal? Taxamt { get; set; }
        
        public Decimal? Freight { get; set; }

        [SqlColumn("Totaldue")]
        public Decimal? Totaldue { get; set; }
        
        public String Comment { get; set; }
        
        public DateTime? Modifieddate { get; set; }

    }
}
