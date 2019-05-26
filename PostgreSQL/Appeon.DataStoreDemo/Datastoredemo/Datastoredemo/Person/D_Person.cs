using SnapObjects.Data;
using System;
using System.ComponentModel.DataAnnotations;

namespace Appeon.DataStoreDemo
{
    [FromTable("Person", Schema = "Person")]
    [UpdateWhereStrategy(UpdateWhereStrategy.KeyColumns)]
    public class D_Person
    {
        [Key]
        public Int32 Businessentityid { get; set; }

        public String Persontype { get; set; }

        public Boolean Namestyle { get; set; }

        public String Title { get; set; }

        public String Firstname { get; set; }

        public String Middlename { get; set; }

        public String Lastname { get; set; }

        public String Suffix { get; set; }

        public Int32 Emailpromotion { get; set; }

        public DateTime Modifieddate { get; set; }

    }
}
