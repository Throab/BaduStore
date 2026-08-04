using Microsoft.AspNetCore.Mvc;
using System.ComponentModel.DataAnnotations.Schema;

namespace Service.Models
{
    [Table("Attributes")]
    public class Attribute
    {
        public int id { get; set; }
        public required string name { get; set; }
        public required string value { get; set; }

    }
}
