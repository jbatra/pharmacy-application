
namespace Nuvem.PharmacyManagement.PharmacyServices;
public interface IMetricsService
{
    Task<ICollection<object>> GetPharmacySalesReport();
    Task<ICollection<object>> GetMostDemandedDrug();
    Task<ICollection<object>> GetTop5DrugsAtPharmacy(int id);
}