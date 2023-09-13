

using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Nuvem.PharmacyManagement.PharmacyServices.Models;
namespace Nuvem.PharmacyManagement.PharmacyServices.DatabaseContext;
public partial class PharmacyDbContext : DbContext
    {
        public virtual DbSet<PharmacistMTDReport> PharmacistMTDReportList { get; set; }

    // We’ll add subsequent changes here

    //Task<int> SaveChangesAsync()
    public async Task<IEnumerable<PharmacistMTDReport>> sp_PharmacistDrugMTDReport(int pharmacyId)
    {
        var pharmacy = new SqlParameter("PharmacyId", pharmacyId);
        return await PharmacistMTDReportList
        .FromSqlInterpolated($"Execute [dbo].[sp_PharmacistDrugMTDReport] {pharmacy}")
        .ToArrayAsync();

    }
}