using SnapObjects.Data;
using System;
using System.ComponentModel.DataAnnotations;

namespace Appeon.DataStoreDemo.PostgreSQL
{
    [FromTable("Product", Schema = "Production")]
    [UpdateWhereStrategy(UpdateWhereStrategy.KeyColumns)]
    public class D_Product_Detail
    {
        [Key]
        [Identity]
        public Int32 Productid { get; set; }
        
        public String Name { get; set; }
        
        public String Productnumber { get; set; }
        
        public Boolean Makeflag { get; set; }
        
        public String Color { get; set; }
        
        public Int16 Safetystocklevel { get; set; }
        
        public Int16 Reorderpoint { get; set; }
        
        public Decimal Standardcost { get; set; }
        
        public Decimal Listprice { get; set; }
        
        public String Size { get; set; }
        
        public String Sizeunitmeasurecode { get; set; }
        
        public String Weightunitmeasurecode { get; set; }
        
        public Decimal? Weight { get; set; }
        
        public Int32 Daystomanufacture { get; set; }
        
        public String Productline { get; set; }
        
        public String Class { get; set; }
        
        public String Style { get; set; }
        
        public Int32? Productsubcategoryid { get; set; }
        
        public Int32? Productmodelid { get; set; }

        public DateTime Sellstartdate { get; set; }

        public DateTime? Sellenddate { get; set; }
        
        public DateTime Modifieddate { get; set; }

        public Boolean Finishedgoodsflag { get; set; }

    }
}
