using Nuvem.PharmacyManagement.PharmacyServices.DatabaseContext.EFEntities;

namespace Nuvem.PharmacyManagement.PharmacyServices.Models;

public interface IDisplayResult<T> where T:class 
{
    IEnumerable<T>? List {get; set;}
    int TotalCount {get; set;}
}
