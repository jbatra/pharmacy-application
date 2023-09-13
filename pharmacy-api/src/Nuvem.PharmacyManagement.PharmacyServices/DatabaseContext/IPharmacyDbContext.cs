using Microsoft.EntityFrameworkCore;
using Nuvem.PharmacyManagement.PharmacyServices.DatabaseContext.EFEntities;
using Nuvem.PharmacyManagement.PharmacyServices.Models;

namespace Nuvem.PharmacyManagement.PharmacyServices.DatabaseContext;

public interface IPharmacyDbContext : IDisposable
{   
    DbSet<Pharmacy> Pharmacy { get; set; }    
    DbSet<PharmacistMTDReport> PharmacistMTDReportList { get; set; }
    Task<int> SaveChangesAsync();
    Task<IEnumerable<PharmacistMTDReport>> sp_PharmacistDrugMTDReport(int pharmacyId);
    DbContext Instance{get;}
    string? connString {get; set;}
}
