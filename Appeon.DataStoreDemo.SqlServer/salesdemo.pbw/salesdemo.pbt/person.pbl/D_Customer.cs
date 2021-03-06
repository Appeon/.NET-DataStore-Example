using DWNet.Data;
using SnapObjects.Data;
using System;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Appeon.DataStoreDemo.SqlServer
{
    [DataWindow("d_customer", DwStyle.Default)]
    [Table("Customer", Schema = "Sales")]
    #region DwSelectAttribute  
    [DwSelect("PBSELECT( VERSION(400) TABLE(NAME=\"Sales.Customer\" ) COLUMN(NAME=\"Sales.Customer.customerid\") COLUMN(NAME=\"Sales.Customer.personid\") COLUMN(NAME=\"Sales.Customer.storeid\") COLUMN(NAME=\"Sales.Customer.territoryid\") COLUMN(NAME=\"Sales.Customer.accountnumber\") COLUMN(NAME=\"Sales.Customer.modifieddate\")WHERE(    EXP1 =\"Sales.Customer.PersonID\"   OP =\"=\"    EXP2 =\":ai_id\" ) ) ARG(NAME = \"ai_id\" TYPE = number) ")]
    #endregion
    [DwParameter("ai_id", typeof(decimal?))]
    [UpdateWhereStrategy(UpdateWhereStrategy.KeyColumns)]
    [DwKeyModificationStrategy(UpdateSqlStrategy.DeleteThenInsert)]
    public class D_Customer
    {
        [Identity]
        [Key]
        [DefaultValue("0")]
        public int Customerid { get; set; }

        [DefaultValue("0")]
        public int? Personid { get; set; }

        [DwChild("Businessentityid", "Name", typeof(D_Dddw_Store))]
        public int? Storeid { get; set; }

        [DwChild("Territoryid", "Name", typeof(D_Dddw_Territory))]
        public int? Territoryid { get; set; }

        [PropertySave(SaveStrategy.Ignore)]
        public string Accountnumber { get; set; }

        [SqlDefaultValue("1990/1/1")]
        public DateTime Modifieddate { get; set; }

    }

}
