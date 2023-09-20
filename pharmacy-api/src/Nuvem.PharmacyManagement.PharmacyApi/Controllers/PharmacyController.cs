using Microsoft.AspNetCore.Mvc;
using Swashbuckle.AspNetCore.Annotations;
using System.Net;
using Nuvem.PharmacyManagement.PharmacyServices.Models;
using Nuvem.PharmacyManagement.PharmacyServices.DatabaseContext.EFEntities;
using Nuvem.PharmacyManagement.PharmacyServices.Exceptions;
using Nuvem.PharmacyManagement.PharmacyServices;


namespace Nuvem.PharmacyManagement.PharmacyApi.Controllers;

[ApiController]
[Route("[controller]")]
public class PharmacyController : ControllerBase
{
    private readonly IPharmacyService _pharmacyService;
    private readonly ILogger _logger;
    public PharmacyController(IPharmacyService pharmacyService, ILogger<PharmacyController> logger)
    {
        _pharmacyService = pharmacyService;
        _logger = logger;
    }

    /// <summary>
    /// Get single or List of Pharmacy
    /// </summary>
    /// <param name="id">Id for single Pharmacy</param>
    /// <returns>List containing single/list of pharmacy</returns>
    /// <exception cref="NotFoundException"></exception>
    [HttpGet]
    [HttpGet("{id}")]
    [SwaggerOperation("Get Pharmacy(s)")]
    [SwaggerResponse((int)HttpStatusCode.OK)]
    [SwaggerResponse((int)HttpStatusCode.NotFound)]
    public async Task<ActionResult> GetPharmacyList(int? id = null)
    {
        _logger.LogInformation("In GetPharmacyList action method!");
        var pharmacyList = await _pharmacyService.GetPharmacieListAsync(id);
        if (pharmacyList is null)
        {
            throw new NotFoundException("Pharmacy(s) Not found!");
        }
        return Ok(pharmacyList);
    }

    /// <summary>
    /// Get MTD report for all the Pharmacists with the given pharmacy 
    /// </summary>
    /// <param name="id">Pharmacy id</param>
    /// <param name="pageParams">page number and page size</param>
    /// <returns>List of MTD report for Pharmacist and total count</returns>
    [HttpPost("{id}/Pharmacist")]
    [SwaggerOperation("Get pharmacist for given pharmacy id")]
    [SwaggerResponse((int)HttpStatusCode.OK)]
    [SwaggerResponse((int)HttpStatusCode.NoContent)]
    public async Task<ActionResult> GetPharmacistListByPharmacyId(int id, [FromBody] ParameterCollection pageParams)
    {
        _logger.LogInformation("In Get pharmacist List For given Pharmacy Id action method!");

        var PharmacistList = await _pharmacyService.GetPharmacistListByPharmacyIdAsync(id, pageParams);
        if (PharmacistList is null)
        {
            return NoContent();
        }
        return Ok(PharmacistList);

    }

    /// <summary>
    /// Paginated Pharmacy List
    /// </summary>
    /// <param name="pageParams">Page number and Page size</param>
    /// <returns>Paginated list of Pharmacy and total count</returns>
    /// <exception cref="NotFoundException"></exception>
    [HttpPost("")]
    [SwaggerOperation("Get PharmacyList by pagesize")]
    [SwaggerResponse((int)HttpStatusCode.OK)]
    [SwaggerResponse((int)HttpStatusCode.NotFound)]
    public async Task<ActionResult> PaginatedPharmacyList([FromBody] ParameterCollection pageParams)
    {
        PharmacyDisplayResult<Pharmacy>? result = await _pharmacyService.PaginatedPharmacyListAsync(pageParams);
        if (result is null || result.List is null)
        {
            throw new NotFoundException("Pharmacy list not found!");
        }
        return Ok(result);
    }

    /// <summary>
    /// Update the Pharmacy
    /// </summary>
    /// <param name="id">PharmacyId</param>
    /// <param name="">Values to update the existing pharmacy</param>
    /// <returns>Updated pharmacy</returns>
    [HttpPut]
    [SwaggerOperation("Updates Pharmacy")]
    [SwaggerResponse((int)HttpStatusCode.OK)]
    [SwaggerResponse((int)HttpStatusCode.BadRequest)]
    [SwaggerResponse((int)HttpStatusCode.NotFound)]
    public async Task<ActionResult> UpdatePharmacyById([FromBody] Pharmacy pharmacy)
    {
        if (!ModelState.IsValid)
        {
            var modelStateErrors = string.Join(" | ", ModelState.Values
                                       .SelectMany(v => v.Errors)
                                       .Select(e => e.ErrorMessage));
            throw new BadRequestException(modelStateErrors);
        }
        if (pharmacy.PharmacyId < 1)
        {
            throw new KeyNotFoundException($"Invalid pharmacy id: {pharmacy.PharmacyId}.");
        }
        var updatedPharmacy = await _pharmacyService.UpdatePharmacyAsync(pharmacy);
        if (updatedPharmacy is null)
        {
            throw new NotFoundException("Pharmacy not found!");
        }
        return Ok(updatedPharmacy);
    }

}