using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Nuvem.PharmacyManagement.PharmacyServices;
using Nuvem.PharmacyManagement.PharmacyServices.DatabaseContext;
using Nuvem.PharmacyManagement.PharmacyServices.DatabaseContext.EFEntities;
using Nuvem.PharmacyManagement.PharmacyServices.Models;

public interface IPharmacyService
{
    Task<List<Pharmacy>> GetAllPharmaciesAsync();
    Task<Pharmacy?> GetPharmacyByIdAsync(int id);
    Task<Pharmacy?> UpdatePharmacyAsync(Pharmacy pharmacy);
    Task<DataGridResult?> PaginatedPharmacyListAsync(PaginationParameters param);
  
}
public class PharmacyService : IPharmacyService
{
    private readonly IPharmacyDbContext _dbContext;
    private readonly AppSettingsConfiguraion _appConfig;
    private readonly ILogger _logger;
    public PharmacyService(IPharmacyDbContext dbContext, AppSettingsConfiguraion appConfig, ILogger<PharmacyService> logger)
    {
        _dbContext = dbContext;  
        _appConfig = appConfig;
        _dbContext.connString = _appConfig.EFConnectionString;
        _logger = logger;
    }
    public async Task<List<Pharmacy>> GetAllPharmaciesAsync()
    {
        return await Task.FromResult( _dbContext.Pharmacy.ToList());
    }

    public async Task<Pharmacy?> GetPharmacyByIdAsync(int id)
    {
        return await _dbContext.Pharmacy.FirstOrDefaultAsync(x => x.PharmacyId == id);
        }

    public async Task<Pharmacy?> UpdatePharmacyAsync(Pharmacy pharmacy)
    {
        var existingPharmacy = await GetPharmacyByIdAsync(pharmacy.PharmacyId);
            if (existingPharmacy is null) 
            {
                _logger.LogInformation("Pharmacy to update not found!");
                return null;
            }
            pharmacy.UpdatedDate = DateTime.Now;

            _dbContext.Pharmacy.Attach(existingPharmacy);

            var entry = _dbContext.Instance.Entry(existingPharmacy);
            entry.CurrentValues.SetValues(pharmacy);

            entry.Property("PharmacyId").IsModified = false;
            entry.Property("CreatedDate").IsModified = false;   

            await _dbContext.SaveChangesAsync();  
            return existingPharmacy; 
    }   

    public async Task<DataGridResult?> PaginatedPharmacyListAsync(PaginationParameters parameters)
    {
        DataGridResult result = new();
        List<Pharmacy> pharmacyList = await GetAllPharmaciesAsync();
        result.TotalCount = pharmacyList.Count;
        int skip = parameters.Page * parameters.PageSize;
        var canPage = skip < pharmacyList.Count;
        if(!canPage) return null;
        result.PharmacyList = pharmacyList.Select(p=> p)
                        .Skip(skip)
                        .Take(parameters.PageSize)
                        .ToList();

        return result;
    }
}