using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Nuvem.PharmacyManagement.PharmacyApi.Exceptions;
using Nuvem.PharmacyManagement.PharmacyServices;
using Nuvem.PharmacyManagement.PharmacyServices.DatabaseContext;
using Serilog;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers(options =>
{
    options.Filters.Add(new ProducesAttribute("application/json"));
    options.Filters.Add(new ConsumesAttribute("application/json"));
});
builder.Services.AddTransient<ExceptionHandlingMiddleware>();
builder.Services.AddSwaggerGen();


// //Test: Register as Scoped lifetime...
// DbContext is not thread-safe. Do not share contexts between threads. 
// https://learn.microsoft.com/en-us/ef/core/dbcontext-configuration/
// builder.Services.AddDbContext<IPharmacyDbContext, PharmacyDbContext>(options =>
//                     options.UseSqlServer(builder.Configuration.GetConnectionString("EFConnectionString"),
//                     ef => ef.MigrationsAssembly("Nuvem.PharmacyManagement.PharmacyServices")));


// Register as Singleton Lifetime....Good for performance. AS each context instance does set up 
// various internal services and objects necessary for performing its duties,
//  and the overhead of continuously doing so may be significant in high-performance scenarios.
//https://learn.microsoft.com/en-us/ef/core/performance/advanced-performance-topics?tabs=with-di%2Cexpression-api-with-constant#dbcontext-pooling

builder.Services.AddDbContextPool<IPharmacyDbContext, PharmacyDbContext>(options =>
        options.UseSqlServer(builder.Configuration.GetConnectionString("EFConnectionString"),
        ef => ef.MigrationsAssembly("Nuvem.PharmacyManagement.PharmacyServices")));

builder.Services.AddSwaggerGen(e => e.EnableAnnotations());
builder.Services.AddTransient<IPharmacyService, PharmacyService>();
builder.Services.AddTransient<IMetricsService, MetricsService>();

AppSettingsConfiguraion appConfig = new();
builder.Configuration.GetSection("ConnectionStrings").Bind(appConfig);
builder.Services.AddSingleton(appConfig);

var allowUrls = builder.Configuration.GetSection("AllowedOrigins").Get<string[]>();
builder.Services.AddCors(options =>
            {
                options.AddDefaultPolicy(policy =>
                {
                    if (allowUrls is not null)
                    {
                        policy.WithOrigins(allowUrls)
                            .WithMethods("GET", "POST", "PUT");
                    }
                });
            });

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();
app.UseMiddleware<ExceptionHandlingMiddleware>();
app.UseAuthorization();


app.UseCors();
app.MapControllers();

app.Run();
