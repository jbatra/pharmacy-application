using Nuvem.PharmacyManagement.PharmacyServices.DatabaseContext.EFEntities;
using Nuvem.PharmacyManagement.PharmacyServices.Models;

namespace Nuvem.PharmacyManagement.PharmacyServices;
public interface IPharmacyService
{
    Task<List<Pharmacy>> GetPharmacieListAsync();
    Task<Pharmacy?> GetPharmacyByIdAsync(int id);
    Task<Pharmacy?> UpdatePharmacyAsync(Pharmacy pharmacy);
    Task<PharmacyDisplayResult<Pharmacy>?> PaginatedPharmacyListAsync(ParameterCollection param);
    Task<PharmacistDisplayResult<PharmacistMTDReport>?> GetPharmacistListByPharmacyIdAsync(int pharmacyId,ParameterCollection parameters);
}
