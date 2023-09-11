using Nuvem.PharmacyManagement.PharmacyServices.DatabaseContext.EFEntities;

namespace Nuvem.PharmacyManagement.PharmacyServices.Models;

public class PharmacyDisplayResult<T> : IDisplayResult<T> where T : Pharmacy
{
    public int TotalCount {get; set;}
    public IEnumerable<T>? List {get; set;}
}

public class PharmacistDisplayResult<T> : IDisplayResult<T> where T : PharmacistMTDReport
{
    public int TotalCount {get; set;}
    public IEnumerable<T>? List {get; set;}
}