using DWNet.Data;
using SnapObjects.Data;
using System;

namespace Appeon.DataStoreDemo.SqlServer
{
    [DataWindow("d_categorysalesreport_d", DwStyle.Default)]
    #region DwSelectAttribute  
    [DwSelect("select ProductCategory.Name as ProductCategoryName, "
                  + "sum(SalesOrderDetail.orderqty) as TotalSalesqty, "
                  + "sum(SalesOrderDetail.linetotal) as TotalSaleroom "
                  + "from Sales.SalesOrderDetail SalesOrderDetail "
                  + "inner join Sales.SalesOrderHeader SalesOrderHeader on SalesOrderDetail.SalesOrderID = SalesOrderHeader.SalesOrderID "
                  + "inner join Production.Product Product on SalesOrderDetail.ProductID = Product.ProductID "
                  + "inner join Production.ProductSubcategory ProductSubcategory on Product.ProductSubcategoryID = ProductSubcategory.ProductSubcategoryID "
                  + "inner join Production.ProductCategory ProductCategory on ProductSubcategory.ProductCategoryID = ProductCategory.ProductCategoryID "
                  + "where SalesOrderHeader.Status in(1,2,5) and (SalesOrderHeader.OrderDate between :fromDate and :toDate) "
                  + "group by ProductCategory.ProductCategoryID, ProductCategory.Name "
                  + "order by ProductCategory.ProductCategoryID")]
    #endregion
    [DwParameter("fromDate", typeof(DateTime?))]
    [DwParameter("toDate", typeof(DateTime?))]
    [DwKeyModificationStrategy(UpdateSqlStrategy.Update)]
    public class D_Categorysalesreport_D
    {
        [PropertySave(SaveStrategy.Ignore)]
        public string Productcategoryname { get; set; }

        [PropertySave(SaveStrategy.Ignore)]
        public int? Totalsalesqty { get; set; }

        [PropertySave(SaveStrategy.Ignore)]
        public decimal? Totalsaleroom { get; set; }

    }

}
