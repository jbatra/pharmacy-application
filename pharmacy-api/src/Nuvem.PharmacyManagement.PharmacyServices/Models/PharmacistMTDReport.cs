

public class PharmacistMTDReport
{    
    public string? Pharmacist { get; set; }
    public int PharmacyId {get; set;}
    public string? Pharmacy { get; set; }
    public string? PrimaryDrug { get; set; }
    public int PrimaryUnitCount { get; set; }
    public decimal PrimarySales { get; set; }
    public int NonPrimaryUnitCount { get; set; }
    public decimal OtherSales { get; set; }
}