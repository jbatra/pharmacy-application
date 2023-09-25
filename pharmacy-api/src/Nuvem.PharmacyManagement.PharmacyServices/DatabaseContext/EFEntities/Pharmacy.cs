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

    [Required, MaxLength(200),MinLength(5)]
    public string Name { get; set; } = null!;

     [MaxLength(200),MinLength(5)]
    public string? Address { get; set; }

    [MaxLength(200),MinLength(3)]
    public string? City { get; set; }

     [MaxLength(200),MinLength(2)]
    public string? State { get; set; }

     [RegularExpression(@"^\d{5}(?:[-\s]\d{4})?$")]
    public string? Zip { get; set; }

    public int? RxFilledMtd { get; set; }

    public DateTime CreatedDate { get; set; }

    public DateTime? UpdatedDate { get; set; }
}
