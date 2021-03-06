using DWNet.Data;
using SnapObjects.Data;
using System;

namespace Appeon.DataStoreDemo.SqlServer
{
    [DataWindow("d_salesorder_select", DwStyle.Default)]
    [DwKeyModificationStrategy(UpdateSqlStrategy.Update)]
    public class D_Salesorder_Select
    {
        [PropertySave(SaveStrategy.Ignore)]
        [DwChild("Customer_Customerid", "Full_Name", typeof(D_Dddw_Customer_Individual))]
        public decimal? Customer { get; set; }

        [PropertySave(SaveStrategy.Ignore)]
        public DateTime? Date_From { get; set; }

        [PropertySave(SaveStrategy.Ignore)]
        public DateTime? Date_To { get; set; }

    }

}
