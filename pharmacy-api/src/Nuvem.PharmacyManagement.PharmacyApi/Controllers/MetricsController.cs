

using System.Net;
using Microsoft.AspNetCore.Mvc;
using Nuvem.PharmacyManagement.PharmacyServices.Exceptions;
using Swashbuckle.AspNetCore.Annotations;
using Nuvem.PharmacyManagement.PharmacyServices;

namespace Nuvem.PharmacyManagement.PharmacyApi.Controllers;

[ApiController]
[Route("[controller]")]
public class MetricsController : ControllerBase
{
    private readonly IMetricsService _MetricsService;
    private readonly ILogger<MetricsController> _logger;
    public MetricsController(IMetricsService MetricsService, ILogger<MetricsController> logger)
    {
        _MetricsService = MetricsService;
        _logger = logger;
    }

    [HttpGet("/PharmacySales")]
    [SwaggerOperation("Get Pharmacy Report")]
    [SwaggerResponse((int)HttpStatusCode.OK)]
    [SwaggerResponse((int)HttpStatusCode.NotFound)]
    public async Task<ActionResult> GetPharmacySalesReport()
    {
        _logger.LogInformation("In Get Pharmacy report action method!");
        var report = await _MetricsService.GetPharmacySalesReport();
        if (report is null)
        {
            throw new NotFoundException("Pharmacy Report not found!");
        }
        return Ok(report);
    }


    [HttpGet("/MostDemandedDrug")]
    [SwaggerOperation("Get Most Demanded Drug")]
    [SwaggerResponse((int)HttpStatusCode.OK)]
    [SwaggerResponse((int)HttpStatusCode.NotFound)]
    public async Task<ActionResult> GetMostDemandedDrug()
    {
        _logger.LogInformation("In Get Pharmacy report action method!");
        var report = await _MetricsService.GetMostDemandedDrug();
        if (report is null)
        {
            throw new NotFoundException("Most Demanded drug not found!");
        }
        return Ok(report);
    }





    [HttpGet("/GetTop5DrugsAtPharmacy/{id}")]
    [SwaggerOperation("Get Most Demanded Drug")]
    [SwaggerResponse((int)HttpStatusCode.OK)]
    [SwaggerResponse((int)HttpStatusCode.NotFound)]
    public async Task<ActionResult> GetTop5DrugsAtPharmacy(int id)
    {
        _logger.LogInformation("In Get Pharmacy report action method!");
        var report = await _MetricsService.GetTop5DrugsAtPharmacy(id);
        if (report is null)
        {
            throw new NotFoundException("Most Demanded drug not found!");
        }
        return Ok(report);
    }
}