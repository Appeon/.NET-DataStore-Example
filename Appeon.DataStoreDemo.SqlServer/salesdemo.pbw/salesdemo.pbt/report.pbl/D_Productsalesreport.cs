using DWNet.Data;
using SnapObjects.Data;
using System;
using System.ComponentModel.DataAnnotations.Schema;

namespace Appeon.DataStoreDemo.SqlServer
{
    [DataWindow("d_productsalesreport", DwStyle.Default)]
    [Table("SalesOrderDetail", Schema = "Sales")]
    #region DwSelectAttribute  
    [DwSelect("select top 5 Product.Name as ProductName, "
                  + "sum(SalesOrderDetail.orderqty) as TotalSalesqty, "
                  + "sum(SalesOrderDetail.linetotal) as TotalSaleroom "
                  + "from Sales.SalesOrderDetail SalesOrderDetail "
                  + "inner join Sales.SalesOrderHeader SalesOrderHeader on SalesOrderDetail.SalesOrderID = SalesOrderHeader.SalesOrderID "
                  + "inner join Production.Product Product on SalesOrderDetail.ProductID = Product.ProductID "
                  + "inner join Production.ProductSubcategory ProductSubcategory on Product.ProductSubcategoryID = ProductSubcategory.ProductSubcategoryID "
                  + "where SalesOrderHeader.Status in(1,2,5) and "
                  + "(ProductSubcategory.ProductSubcategoryID = :subCategoryId) and "
                  + "(SalesOrderHeader.OrderDate between :dateFrom and :dateTo) "
                  + "group by Product.ProductID, Product.Name "
                  + "order by sum(SalesOrderDetail.linetotal) desc")]
    #endregion
    [DwParameter("subCategoryId", typeof(decimal?))]
    [DwParameter("dateFrom", typeof(DateTime?))]
    [DwParameter("dateTo", typeof(DateTime?))]
    [DwKeyModificationStrategy(UpdateSqlStrategy.Update)]
    public class D_Productsalesreport
    {
        [PropertySave(SaveStrategy.Ignore)]
        public string Productname { get; set; }

        [PropertySave(SaveStrategy.Ignore)]
        public int? Totalsalesqty { get; set; }

        [PropertySave(SaveStrategy.Ignore)]
        public decimal? Totalsaleroom { get; set; }

    }

}
