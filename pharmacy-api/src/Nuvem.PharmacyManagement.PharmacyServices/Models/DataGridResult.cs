using Nuvem.PharmacyManagement.PharmacyServices.DatabaseContext.EFEntities;

namespace Nuvem.PharmacyManagement.PharmacyServices.Models;

public interface IDataGridResult
{
        int TotalCount {get; set;}
}

public class DataGridResult : IDataGridResult
{
    public IEnumerable<Pharmacy>? PharmacyList {get; set;}
    public int TotalCount {get; set;}
}