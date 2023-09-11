using Nuvem.PharmacyManagement.PharmacyServices.DatabaseContext.EFEntities;
using Nuvem.PharmacyManagement.PharmacyServices.Models;

namespace Nuvem.PharmacyManagement.PharmacyServices;
public interface IPharmacyService
{
    Task<List<Pharmacy>> GetAllPharmaciesAsync();
    Task<Pharmacy?> GetPharmacyByIdAsync(int id);
    Task<Pharmacy?> UpdatePharmacyAsync(Pharmacy pharmacy);
    Task<PharmacyDisplayResult<Pharmacy>?> PaginatedPharmacyListAsync(ParameterCollection param);
    Task<PharmacistDisplayResult<PharmacistMTDReport>?> GetPharmacistsByPharmacyIdAsync(int pharmacyId,ParameterCollection parameters);
}
