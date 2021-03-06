using DWNet.Data;
using SnapObjects.Data;
using System;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Appeon.DataStoreDemo.SqlServer
{
    [DataWindow("d_subcategory", DwStyle.Grid)]
    [Table("ProductSubcategory", Schema = "Production")]
    #region DwSelectAttribute  
    [DwSelect("SELECT production.productsubcategory.productsubcategoryid, "
                  + "production.productsubcategory.productcategoryid, "
                  + "production.productsubcategory.name, "
                  + "production.productsubcategory.modifieddate "
                  + "FROM production.productsubcategory "
                  + "WHERE (production.productsubcategory.productsubcategoryid = :ai_id or :ai_id = 0)")]
    #endregion
    [DwParameter("ai_id", typeof(decimal?))]
    [DwSort("productcategoryid A productsubcategoryid A ")]
    [UpdateWhereStrategy(UpdateWhereStrategy.KeyAndConcurrencyCheckColumns)]
    [DwKeyModificationStrategy(UpdateSqlStrategy.DeleteThenInsert)]
    public class D_Subcategory
    {
        [Identity]
        [Key]
        [DefaultValue("0")]
        public int Productsubcategoryid { get; set; }

        [ConcurrencyCheck]
        [DwChild("Productcategoryid", "Name", typeof(D_Dddw_Category))]
        public int Productcategoryid { get; set; }

        [ConcurrencyCheck]
        public string Name { get; set; }

        [ConcurrencyCheck]
        [SqlDefaultValue("(getdate())")]
        public DateTime Modifieddate { get; set; }

        [DwCompute("getrow()")]
        public object Compute_1 { get; set; }

    }

}
