using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace Nuvem.PharmacyManagement.PharmacyServices.DatabaseContext.EFEntities;

public partial class Pharmacy
{
    [Key]
    public int PharmacyId { get; set; }

    //[StringLength(200)]
    [Required, MaxLength(150),MinLength(5)]
    public string Name { get; set; } = null!;

    //[StringLength(200)]
     [MaxLength(150),MinLength(5)]
    public string? Address { get; set; }

    //[StringLength(200)]
    [MaxLength(150),MinLength(3)]
    public string? City { get; set; }

    //[StringLength(200)]
     [MaxLength(150),MinLength(3)]
    public string? State { get; set; }

    //[StringLength(12)]
     [RegularExpression(@"^\d{5}(?:[-\s]\d{4})?$")]
    public string? Zip { get; set; }

    public int? RxFilledMtd { get; set; }

    public DateTime CreatedDate { get; set; }

    public DateTime? UpdatedDate { get; set; }
}
