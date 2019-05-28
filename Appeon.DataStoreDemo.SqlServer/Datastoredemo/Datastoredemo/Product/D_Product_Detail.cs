using SnapObjects.Data;
using System;
using System.ComponentModel.DataAnnotations;

namespace Appeon.DataStoreDemo.SqlServer
{
    [FromTable("Product", Schema = "Production")]
    [UpdateWhereStrategy(UpdateWhereStrategy.KeyColumns)]
    public class D_Product_Detail
    {
        [Key]
        [Identity]
        public Int32 Productid { get; set; }

        [ConcurrencyCheck]
        public String Name { get; set; }

        [ConcurrencyCheck]
        public String Productnumber { get; set; }

        [ConcurrencyCheck]
        public Boolean Makeflag { get; set; }

        [ConcurrencyCheck]
        public String Color { get; set; }

        [ConcurrencyCheck]
        public Int16 Safetystocklevel { get; set; }

        [ConcurrencyCheck]
        public Int16 Reorderpoint { get; set; }

        [ConcurrencyCheck]
        public Decimal Standardcost { get; set; }

        [ConcurrencyCheck]
        public Decimal Listprice { get; set; }

        [ConcurrencyCheck]
        public String Size { get; set; }

        [ConcurrencyCheck]
        public String Sizeunitmeasurecode { get; set; }

        [ConcurrencyCheck]
        public String Weightunitmeasurecode { get; set; }

        [ConcurrencyCheck]
        public Decimal? Weight { get; set; }

        [ConcurrencyCheck]
        public Int32 Daystomanufacture { get; set; }

        [ConcurrencyCheck]
        public String Productline { get; set; }

        [ConcurrencyCheck]
        public String Class { get; set; }

        [ConcurrencyCheck]
        public String Style { get; set; }

        [ConcurrencyCheck]
        public Int32? Productsubcategoryid { get; set; }

        [ConcurrencyCheck]
        public Int32? Productmodelid { get; set; }

        public DateTime Sellstartdate { get; set; }

        public DateTime? Sellenddate { get; set; }

        [ConcurrencyCheck]
        public DateTime Modifieddate { get; set; }

        public Boolean Finishedgoodsflag { get; set; }

    }
}
