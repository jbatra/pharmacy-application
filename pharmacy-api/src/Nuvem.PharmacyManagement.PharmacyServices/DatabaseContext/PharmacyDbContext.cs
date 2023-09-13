using Microsoft.EntityFrameworkCore;
using Nuvem.PharmacyManagement.PharmacyServices.DatabaseContext.EFEntities;
using Nuvem.PharmacyManagement.PharmacyServices.Models;

namespace Nuvem.PharmacyManagement.PharmacyServices.DatabaseContext;

public partial class PharmacyDbContext : DbContext, IPharmacyDbContext
{
    public PharmacyDbContext()
    {
    }

    public PharmacyDbContext(DbContextOptions<PharmacyDbContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Pharmacy> Pharmacy { get; set; }

    public DbContext Instance => this;

    public string? connString { get; set;}
   
    public Task<int> SaveChangesAsync()
    {
        return base.SaveChangesAsync();
    }
   
    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        if(!optionsBuilder.IsConfigured)
        {
            optionsBuilder.UseSqlServer(connString);
        }
    }
    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Pharmacy>(entity =>
        {
            entity.HasKey(e => e.PharmacyId).HasName("PK_dbo.Pharmacy");
        });
        modelBuilder.Entity<PharmacistMTDReport>(entity => 
        entity.HasNoKey());  

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
