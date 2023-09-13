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

        [HttpGet]
        [HttpGet("{id}")]
        [SwaggerOperation("Get Pharmacy(s)")]
        [SwaggerResponse((int)HttpStatusCode.OK)]
        [SwaggerResponse((int)HttpStatusCode.NotFound)]
        public async Task<ActionResult> GetPharmacyList(int? id=null)
        {
            _logger.LogInformation("In GetPharmacyList action method!");
            if(id is null)
            {
                return Ok(await _pharmacyService.GetPharmacieListAsync());
            }
            else
            {
                Pharmacy? pharmacy = await _pharmacyService.GetPharmacyByIdAsync(id.GetValueOrDefault());
                if(pharmacy is null)
                {
                    throw new NotFoundException("Pharmacy Not found!");
                } 
                return Ok(pharmacy);
            }
        }

        [HttpPost("{id}/Pharmacist")]
        [SwaggerOperation("Get pharmacist for given pharmacy id")]
        [SwaggerResponse((int)HttpStatusCode.OK)]
        [SwaggerResponse((int)HttpStatusCode.NoContent)]
    // public async Task<ActionResult> PaginatedPharmacyList([FromBody]ParameterCollection pageParams)
    // {
    public async Task<ActionResult> GetPharmacistListByPharmacyId(int id, [FromBody] ParameterCollection pageParams)
        {
            _logger.LogInformation("In Get pharmacist List For given Pharmacy Id action method!");
            
            var PharmacistList = await _pharmacyService.GetPharmacistListByPharmacyIdAsync(id, pageParams);
            if(PharmacistList is null)
            {
                return NoContent();
            } 
            return Ok(PharmacistList);
            
        }

        [HttpPost("")]        
        [SwaggerOperation("Get PharmacyList by pagesize")]
        [SwaggerResponse((int)HttpStatusCode.OK)]
        [SwaggerResponse((int)HttpStatusCode.NotFound)]
        public async Task<ActionResult> PaginatedPharmacyList([FromBody]ParameterCollection pageParams)
        {
            PharmacyDisplayResult<Pharmacy>? result = await _pharmacyService.PaginatedPharmacyListAsync(pageParams);
            if(result is null || result.List is null)
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
        /// <returns></returns>
        [HttpPut]
        [SwaggerOperation("Updates Pharmacy")]
        [SwaggerResponse((int)HttpStatusCode.OK)]
        [SwaggerResponse((int)HttpStatusCode.BadRequest)]
        [SwaggerResponse((int)HttpStatusCode.NotFound)]
        public async Task<ActionResult> UpdatePharmacyById([FromBody]Pharmacy pharmacy)
        {   
            if(!ModelState.IsValid)
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
            if(updatedPharmacy is null)
            {
                throw new NotFoundException("Pharmacy not found!");
            }
            return Ok(updatedPharmacy); 
        }
    }