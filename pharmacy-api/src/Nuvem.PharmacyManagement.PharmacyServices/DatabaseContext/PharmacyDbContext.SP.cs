

using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
namespace Nuvem.PharmacyManagement.PharmacyServices.DatabaseContext;
public partial class PharmacyDbContext : DbContext
    {
        public virtual DbSet<PharmacistMTDReport> PharmacistMTDReportList { get; set; }

    // We’ll add subsequent changes here

    //Task<int> SaveChangesAsync()
    public async Task<IEnumerable<PharmacistMTDReport>> sp_PharmacistMTDReport(int pharmacyId)
    {
        var pharmacy = new SqlParameter("PharmacyId", pharmacyId);
        return await PharmacistMTDReportList
        .FromSqlInterpolated($"Execute [dbo].[sp_PharmacistMTDReport] {pharmacy}")
        .ToArrayAsync();

    }
}