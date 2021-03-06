using DWNet.Data;
using SnapObjects.Data;
using System.Collections.Generic;

namespace Appeon.DataStoreDemo.SqlServer
{
    [DataWindow("d_subcategorysalesreport_m", DwStyle.Composite)]
    [DwKeyModificationStrategy(UpdateSqlStrategy.Update)]
    public class D_Subcategorysalesreport_M
    {
        [PropertySave(SaveStrategy.Ignore)]
        public string A { get; set; }

        [DwReport(typeof(D_Subcategorysalesreport))]
        public IList<D_Subcategorysalesreport> Dw_Subcategorysalesreport { get; set; }

        [DwReport(typeof(D_Subcategorysalesreport_Graph))]
        public IList<D_Subcategorysalesreport_Graph> Dw_Subcategorysalesreport_Graph { get; set; }

        [DwReport(typeof(D_Productsalesreport))]
        public IList<D_Productsalesreport> Dw_Productsalesreport { get; set; }

    }

}
