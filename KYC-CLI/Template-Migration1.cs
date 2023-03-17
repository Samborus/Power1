namespace ITM.SD.BGZ.KYC.Db.Migrations
{
    using FluentMigrator;
    [Migration(Template1)]
    public class Template2 : Migration
    {
        public override void Up() => Execute.Script("Migrations/Scripts/Template3");

        public override void Down() => Execute.Script("Migrations/Scripts/Template4");
    }
}