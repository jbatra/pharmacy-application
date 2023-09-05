using Newtonsoft.Json;
using Nuvem.PharmacyManagement.PharmacyServices.Exceptions;
using Serilog;
using Serilog.Context;
using System.Net;

namespace Nuvem.PharmacyManagement.PharmacyApi.Exceptions;

    public class ExceptionHandlingMiddleware : IMiddleware
    {
        public async Task InvokeAsync(HttpContext context, RequestDelegate next)
        {
            try
            {
                await next(context);
            }
            catch (KeyNotFoundException ex)
            {
                context.Response.StatusCode = (int)HttpStatusCode.NotFound;
                var json = JsonConvert.SerializeObject(ex.Message);
                await context.Response.WriteAsync(json);
            }
            catch (NotFoundException ex)
            {
                context.Response.StatusCode = (int)HttpStatusCode.NotFound;
                var json = JsonConvert.SerializeObject(ex.Message);
                await context.Response.WriteAsync(json);
            }
            catch (BadRequestException ex)
            {
                context.Response.StatusCode = (int)HttpStatusCode.BadRequest;
                var json = JsonConvert.SerializeObject(ex.Message);
                await context.Response.WriteAsync(json);
            }
            catch (Exception ex)
            {
                context.Response.StatusCode = (int)HttpStatusCode.InternalServerError;
                await context.Response.WriteAsync(ex.Message);                
            }
        }
    }

