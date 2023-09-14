using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Nuvem.PharmacyManagement.PharmacyServices.Migrations
{
    /// <inheritdoc />
    public partial class InitialCreate : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "PharmacistMTDReportList",
                columns: table => new
                {
                    PharmacyId = table.Column<int>(type: "int", nullable: false),
                    Pharmacy = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    PharmacistId = table.Column<int>(type: "int", nullable: false),
                    Pharmacist = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    DrugName = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    UnitCount = table.Column<int>(type: "int", nullable: false),
                    SaleAmount = table.Column<decimal>(type: "decimal(18,2)", nullable: false)
                },
                constraints: table =>
                {
                });

            migrationBuilder.CreateTable(
                name: "Pharmacy",
                columns: table => new
                {
                    PharmacyId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    Address = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: true),
                    City = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: true),
                    State = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: true),
                    Zip = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    RxFilledMtd = table.Column<int>(type: "int", nullable: true),
                    CreatedDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    UpdatedDate = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_dbo.Pharmacy", x => x.PharmacyId);
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "PharmacistMTDReportList");

            migrationBuilder.DropTable(
                name: "Pharmacy");
        }
    }
}
