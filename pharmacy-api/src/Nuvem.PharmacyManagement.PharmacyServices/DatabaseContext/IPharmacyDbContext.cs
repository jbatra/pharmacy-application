using Microsoft.EntityFrameworkCore;
using Nuvem.PharmacyManagement.PharmacyServices.DatabaseContext.EFEntities;

namespace Nuvem.PharmacyManagement.PharmacyServices.DatabaseContext;

public interface IPharmacyDbContext : IDisposable
{   
    DbSet<Pharmacy> Pharmacy { get; set; }    
    Task<int> SaveChangesAsync();
    DbContext Instance{get;}
    string? connString {get; set;}
}
