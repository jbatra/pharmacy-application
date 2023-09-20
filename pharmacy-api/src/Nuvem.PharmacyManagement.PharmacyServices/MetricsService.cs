using System.Data;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Nuvem.PharmacyManagement.PharmacyServices.DatabaseContext;

namespace Nuvem.PharmacyManagement.PharmacyServices;
public class MetricsService : IMetricsService
{
    private readonly IPharmacyDbContext _dbContext;
    private readonly ILogger<MetricsService> _logger;
    public MetricsService(IPharmacyDbContext dbContext, ILogger<MetricsService> logger)
    {
        _dbContext = dbContext;
        _logger = logger;
    }

    public async Task<ICollection<object>> GetPharmacySalesReport()
    {
        string sprocName = "sp_MTD_YTD_Pharmacy_Report";
        {
            ICollection<object> PharmacySalesReport = new List<object>();
            using (var command = _dbContext.Instance.Database.GetDbConnection().CreateCommand())
            {
                command.CommandText = sprocName;
                command.CommandType = CommandType.StoredProcedure;

                await _dbContext.Instance.Database.OpenConnectionAsync();

                using (var reader = await command.ExecuteReaderAsync())
                {
                    while (await reader.ReadAsync())
                    {
                        PharmacySalesReport.Add(new
                        {
                            PharmacyId = reader.GetFieldValueAsync<int>(0).Result,
                            Pharmacy = reader.GetFieldValueAsync<string>(1).Result,
                            SaleMonth = reader.GetFieldValueAsync<string>(2).Result,
                            TotalSalesMTD = reader.GetFieldValueAsync<decimal>(3).Result,
                            SaleYear = reader.GetFieldValueAsync<int>(4).Result,
                            TotalSalesYTD = reader.GetFieldValueAsync<decimal>(5).Result
                        });
                    }
                }
            }
            return PharmacySalesReport;
        }
    }

    public async Task<ICollection<object>> GetMostDemandedDrug()
    {
        string sprocName = "sp_MostDemandedDrug";
        {
            ICollection<object> MostDemandedDrug = new List<object>();
            using (var command = _dbContext.Instance.Database.GetDbConnection().CreateCommand())
            {
                command.CommandText = sprocName;
                command.CommandType = CommandType.StoredProcedure;

                await _dbContext.Instance.Database.OpenConnectionAsync();

                using (var reader = await command.ExecuteReaderAsync())
                {
                    while (await reader.ReadAsync())
                    {
                        MostDemandedDrug.Add(new
                        {
                            PharmacyId = reader.GetFieldValueAsync<int>(0).Result,
                            Pharmacy = reader.GetFieldValueAsync<string>(1).Result,
                            Drug = reader.GetFieldValueAsync<string>(2).Result,
                            QuantitySold = reader.GetFieldValueAsync<int>(3).Result,
                            Sales = reader.GetFieldValueAsync<decimal>(4).Result,
                        });
                    }
                }
            }
            return MostDemandedDrug;
        }
    }

    public async Task<ICollection<object>> GetTop5DrugsAtPharmacy(int id)
    {
        string sprocName = "sp_Top5DrugsAtPharmacy";
        {
            ICollection<object> MostDemandedDrug = new List<object>();
            using (var command = _dbContext.Instance.Database.GetDbConnection().CreateCommand())
            {
                command.CommandText = sprocName;
                command.CommandType = CommandType.StoredProcedure;
                var pharmacy = new SqlParameter("PharmacyId", id);
                command.Parameters.Add(pharmacy);



                // var pharmacy = new SqlParameter("PharmacyId", pharmacyId);

                await _dbContext.Instance.Database.OpenConnectionAsync();

                using (var reader = await command.ExecuteReaderAsync())
                {
                    while (await reader.ReadAsync())
                    {
                        MostDemandedDrug.Add(new
                        {
                            PharmacyId = reader.GetFieldValueAsync<int>(0).Result,
                            Pharmacy = reader.GetFieldValueAsync<string>(1).Result,
                            Drug = reader.GetFieldValueAsync<string>(2).Result,
                            QuantitySold = reader.GetFieldValueAsync<int>(3).Result,
                        });
                    }
                }
            }
            return MostDemandedDrug;
        }
    }
}