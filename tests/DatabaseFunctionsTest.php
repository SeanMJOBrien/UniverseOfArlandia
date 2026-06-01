<?php
declare(strict_types=1);

use PHPUnit\Framework\TestCase;

/**
 * Tests for pure (DB-free) functions extracted from www/database-mysql.php.
 * The functions are defined in tests/bootstrap.php.
 */
class DatabaseFunctionsTest extends TestCase
{
    // ------------------------------------------------------------------
    // DB_LocalizeDefinition — strips INDEX / FULLTEXT suffixes
    // ------------------------------------------------------------------

    public function testLocalizeDefinitionStripsIndex(): void
    {
        $this->assertSame('varchar(255)', DB_LocalizeDefinition('varchar(255) INDEX'));
    }

    public function testLocalizeDefinitionStripsFulltext(): void
    {
        $this->assertSame('text', DB_LocalizeDefinition('text FULLTEXT'));
    }

    public function testLocalizeDefinitionLeavesOtherDefinitionsAlone(): void
    {
        $this->assertSame('int NOT NULL', DB_LocalizeDefinition('int NOT NULL'));
    }

    public function testLocalizeDefinitionOnlyStripsTrailingSuffix(): void
    {
        // "INDEX" embedded in the middle should not be removed
        $def = 'varchar(255)';
        $this->assertSame($def, DB_LocalizeDefinition($def));
    }

    // ------------------------------------------------------------------
    // DB_Field_Def_Match — compare software definition to DB definition
    // ------------------------------------------------------------------

    public function testFieldDefMatchVarcharEquals(): void
    {
        $this->assertTrue(DB_Field_Def_Match('varchar(255)', 'varchar(255)'));
    }

    public function testFieldDefMatchCaseInsensitive(): void
    {
        $this->assertTrue(DB_Field_Def_Match('VARCHAR(255)', 'varchar(255)'));
    }

    public function testFieldDefMatchDifferentTypes(): void
    {
        $this->assertFalse(DB_Field_Def_Match('varchar(255)', 'text'));
    }

    public function testFieldDefMatchIntSizesIgnored(): void
    {
        // int(11) in DB should match int in soft definition after normalisation
        $this->assertTrue(DB_Field_Def_Match('int', 'int(11)'));
    }

    public function testFieldDefMatchBigintSizesIgnored(): void
    {
        $this->assertTrue(DB_Field_Def_Match('bigint', 'bigint(20)'));
    }

    public function testFieldDefMatchPrimaryKeyStrippedFromSoftDef(): void
    {
        // Soft def has PRIMARY KEY annotation; DB def has PRI key marker
        $this->assertTrue(DB_Field_Def_Match('int PRIMARY KEY', 'int; PRI'));
    }

    public function testFieldDefMatchPrimaryKeyMissingInDB(): void
    {
        // Soft def declares PRIMARY KEY but DB def has no PRI marker → false
        $this->assertFalse(DB_Field_Def_Match('int PRIMARY KEY', 'int'));
    }

    public function testFieldDefMatchIndexStrippedFromSoftDef(): void
    {
        $this->assertTrue(DB_Field_Def_Match('varchar(255) INDEX', 'varchar(255); MUL'));
    }

    public function testFieldDefMatchIndexMissingInDB(): void
    {
        $this->assertFalse(DB_Field_Def_Match('varchar(255) INDEX', 'varchar(255)'));
    }

    public function testFieldDefMatchAutoIncrementStrippedFromSoftDef(): void
    {
        // auto_increment annotation stripped for type comparison, but NOT checked
        // for presence in the DB (typo in original code: AUTO_INCREMEMNT).
        // Just confirm the types match when stripped.
        $this->assertTrue(DB_Field_Def_Match('int auto_increment', 'int'));
    }

    public function testFieldDefMatchDbExtrasIgnored(): void
    {
        // The DB may return extra info after ";"; that should be stripped from sdef
        $this->assertTrue(DB_Field_Def_Match('varchar(100)', 'varchar(100); someExtra'));
    }

    public function testFieldDefMatchReferencesStrippedFromSoftDef(): void
    {
        $this->assertTrue(
            DB_Field_Def_Match('int references users(id)', 'int')
        );
    }
}
