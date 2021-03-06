using DWNet.Data;
using SnapObjects.Data;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Appeon.DataStoreDemo.SqlServer
{
    [DataWindow("d_dddw_product", DwStyle.Grid)]
    [Table("Product", Schema = "Production")]
    #region DwSelectAttribute  
    [DwSelect("PBSELECT( VERSION(400) TABLE(NAME=\"production.product\" ) COLUMN(NAME=\"production.product.productid\") COLUMN(NAME=\"production.product.name\")) ")]
    #endregion
    [UpdateWhereStrategy(UpdateWhereStrategy.KeyAndConcurrencyCheckColumns)]
    [DwKeyModificationStrategy(UpdateSqlStrategy.DeleteThenInsert)]
    public class D_Dddw_Product
    {
        [Identity]
        [Key]
        public int Productid { get; set; }

        [ConcurrencyCheck]
        public string Name { get; set; }

    }

}
