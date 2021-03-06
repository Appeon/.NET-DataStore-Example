using DWNet.Data;
using SnapObjects.Data;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Appeon.DataStoreDemo.SqlServer
{
    [DataWindow("d_dddw_store", DwStyle.Grid)]
    [Table("Store", Schema = "Sales")]
    #region DwSelectAttribute  
    [DwSelect("PBSELECT( VERSION(400) TABLE(NAME=\"Sales.Store\" ) COLUMN(NAME=\"Sales.Store.BusinessEntityID\") COLUMN(NAME=\"Sales.Store.Name\")) ")]
    #endregion
    [DwSort("businessentityid A ")]
    [UpdateWhereStrategy(UpdateWhereStrategy.KeyColumns)]
    [DwKeyModificationStrategy(UpdateSqlStrategy.DeleteThenInsert)]
    public class D_Dddw_Store
    {
        [Key]
        public int Businessentityid { get; set; }

        public string Name { get; set; }

    }

}
