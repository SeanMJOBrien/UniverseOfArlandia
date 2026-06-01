<?php
declare(strict_types=1);

use PHPUnit\Framework\TestCase;

/**
 * Tests for pure (DB-free) functions in www/sql.php.
 */
class SqlFunctionsTest extends TestCase
{
    // ------------------------------------------------------------------
    // DB_String — escape strings for DB insertion
    // ------------------------------------------------------------------

    public function testDbStringEscapesBackslash(): void
    {
        $this->assertSame('foo\\\\bar', DB_String('foo\\bar'));
    }

    public function testDbStringEscapesDoubleQuote(): void
    {
        $this->assertSame('say \\"hello\\"', DB_String('say "hello"'));
    }

    public function testDbStringEscapesNewline(): void
    {
        $this->assertSame('line1\\nline2', DB_String("line1\nline2"));
    }

    public function testDbStringPassesThroughCleanString(): void
    {
        $this->assertSame('hello world', DB_String('hello world'));
    }

    // ------------------------------------------------------------------
    // DB_Enclose — wrap values for use in SQL statements
    // ------------------------------------------------------------------

    public function testDbEncloseInteger(): void
    {
        $this->assertSame(42, DB_Enclose(42));
    }

    public function testDbEncloseFloat(): void
    {
        $this->assertSame(3.14, DB_Enclose(3.14));
    }

    public function testDbEncloseNull(): void
    {
        $this->assertSame('NULL', DB_Enclose(null));
    }

    public function testDbEncloseFalse(): void
    {
        $this->assertSame('NULL', DB_Enclose(false));
    }

    public function testDbEncloseString(): void
    {
        $this->assertSame('"hello"', DB_Enclose('hello'));
    }

    public function testDbEncloseStringWithQuotes(): void
    {
        $this->assertSame('"say \\"hi\\""', DB_Enclose('say "hi"'));
    }

    public function testDbEncloseNullType(): void
    {
        $this->assertSame('NULL', DB_Enclose(['type' => 'null']));
    }

    public function testDbEncloseUnrecognisedArray(): void
    {
        $this->assertSame('NULL', DB_Enclose(['unknown' => 'value']));
    }

    public function testDbEncloseCrc32(): void
    {
        $result = DB_Enclose(['crc32' => 'test']);
        $this->assertSame('CRC32("test")', $result);
    }

    public function testDbEncloseDbfield(): void
    {
        $result = DB_Enclose(['dbfield' => 'username']);
        $this->assertSame('username', $result);
    }

    public function testDbEncloseDbfieldStripsNonWordChars(): void
    {
        $result = DB_Enclose(['dbfield' => 'user; DROP TABLE users--']);
        $this->assertSame('userDROPTABLEusers', $result);
    }

    // ------------------------------------------------------------------
    // UnixToSqlTime — epoch → "Y-m-d H:i:s"
    // ------------------------------------------------------------------

    public function testUnixToSqlTimeFormat(): void
    {
        // 2000-01-01 00:00:00 UTC
        $result = UnixToSqlTime(946684800);
        $this->assertMatchesRegularExpression('/^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}$/', $result);
    }

    public function testUnixToSqlTimeFloorsDecimal(): void
    {
        $a = UnixToSqlTime(946684800.9);
        $b = UnixToSqlTime(946684800.0);
        $this->assertSame($b, $a);
    }

    // ------------------------------------------------------------------
    // DB_DBTimeToEpoch — "Y-m-d H:i:s" → epoch
    // ------------------------------------------------------------------

    public function testDbDBTimeToEpochValidString(): void
    {
        $epoch = DB_DBTimeToEpoch('2000-01-01 00:00:00');
        $this->assertIsInt($epoch);
        $this->assertGreaterThan(0, $epoch);
    }

    public function testDbDBTimeToEpochRoundTrip(): void
    {
        $original = 946684800;
        $sqlTime  = UnixToSqlTime($original);
        $back     = DB_DBTimeToEpoch($sqlTime);
        $this->assertSame($original, $back);
    }

    public function testDbDBTimeToEpochReturnsFalseOnBadInput(): void
    {
        $this->assertFalse(DB_DBTimeToEpoch('not-a-date'));
        $this->assertFalse(DB_DBTimeToEpoch(''));
    }

    // ------------------------------------------------------------------
    // DateStringPlusSeconds / DateStringMinusSeconds
    // ------------------------------------------------------------------

    public function testDateStringPlusSeconds(): void
    {
        $result = DateStringPlusSeconds('2000-01-01 00:00:00', 3600);
        $this->assertSame('2000-01-01 01:00:00', $result);
    }

    public function testDateStringMinusSeconds(): void
    {
        $result = DateStringMinusSeconds('2000-01-01 01:00:00', 3600);
        $this->assertSame('2000-01-01 00:00:00', $result);
    }

    public function testDateStringPlusSecondsDay(): void
    {
        $result = DateStringPlusSeconds('2000-01-01 00:00:00', 86400);
        $this->assertSame('2000-01-02 00:00:00', $result);
    }

    // ------------------------------------------------------------------
    // DB_WhereClause — builds SQL WHERE sub-clauses
    // ------------------------------------------------------------------

    public function testWhereClauseSimpleString(): void
    {
        $result = DB_WhereClause('name', 'Alice');
        $this->assertSame('name = "Alice"', $result);
    }

    public function testWhereClauseInteger(): void
    {
        $result = DB_WhereClause('id', 5);
        $this->assertSame('id = 5', $result);
    }

    public function testWhereClauseLike(): void
    {
        $result = DB_WhereClause('name', ['like' => '%Alice%']);
        $this->assertSame('name LIKE "%Alice%"', $result);
    }

    public function testWhereClauseNotLike(): void
    {
        $result = DB_WhereClause('name', ['notlike' => '%Bob%']);
        $this->assertSame('NOT (name LIKE "%Bob%")', $result);
    }

    public function testWhereClauseIsnot(): void
    {
        $result = DB_WhereClause('status', ['isnot' => 'deleted']);
        $this->assertSame('status != "deleted"', $result);
    }

    public function testWhereClauseIsNull(): void
    {
        $result = DB_WhereClause('deleted_at', ['isnull' => true]);
        $this->assertSame('ISNULL(deleted_at)', $result);
    }

    public function testWhereClauseIsNotNull(): void
    {
        $result = DB_WhereClause('deleted_at', ['isnotnull' => true]);
        $this->assertSame('NOT (ISNULL(deleted_at))', $result);
    }

    public function testWhereClauseGreaterThan(): void
    {
        $result = DB_WhereClause('age', ['operator' => '>', 'value' => 18]);
        $this->assertSame('age > 18', $result);
    }

    public function testWhereClauseLessThan(): void
    {
        $result = DB_WhereClause('age', ['operator' => '<', 'value' => 65]);
        $this->assertSame('age < 65', $result);
    }

    public function testWhereClauseFieldStripsNonWordChars(): void
    {
        // Injection attempt in field name should be sanitised
        $result = DB_WhereClause('id; DROP TABLE users--', 1);
        $this->assertSame('idDROPTABLEusers = 1', $result);
    }
}
