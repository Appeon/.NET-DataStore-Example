using DWNet.Data;
using SnapObjects.Data;
using System.Collections.Generic;

namespace Appeon.DataStoreDemo.SqlServer
{
    [DataWindow("d_setup", DwStyle.Default)]
    [DwKeyModificationStrategy(UpdateSqlStrategy.Update)]
    [DwData(typeof(D_Setup_Data))]
    public class D_Setup
    {
        [PropertySave(SaveStrategy.Ignore)]
        public string Hosttype { get; set; }

        [PropertySave(SaveStrategy.Ignore)]
        public string Modeltype { get; set; }

        [PropertySave(SaveStrategy.Ignore)]
        public string Url { get; set; }

    }

    #region D_Setup_Data
    public class D_Setup_Data : DwDataInitializer<D_Setup>
    {
        public override IList<D_Setup> GetDefaultData()
        {
            var datas = new List<D_Setup>()
            {
                 new D_Setup() { Hosttype = "null", Modeltype = null, Url = null },
            };

            return datas;
        }
    }
    #endregion
}
