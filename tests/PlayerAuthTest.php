<?php
declare(strict_types=1);

use PHPUnit\Framework\TestCase;

/**
 * Tests for the pure functions in www/player_auth.php — CD-key handling, LIKE
 * escaping, and the map tile visibility rule. The DB-backed functions
 * (player_login, player_register, player_discovered_tiles) need a live pwdata
 * table and are covered by the Playwright suite in www/tests/ instead.
 */
class PlayerAuthTest extends TestCase
{
    // ------------------------------------------------------------------
    // cdkey_normalize / cdkey_valid
    // ------------------------------------------------------------------

    public function testNormalizeUppercasesAndStripsWhitespace(): void
    {
        $this->assertSame('ABCD1234', cdkey_normalize(' abcd 1234 '));
        $this->assertSame('ABCD1234', cdkey_normalize("abcd\t1234\n"));
    }

    public function testValidAcceptsEightAlphanumerics(): void
    {
        $this->assertTrue(cdkey_valid('ABCD1234'));
        $this->assertTrue(cdkey_valid('12345678'));
        $this->assertTrue(cdkey_valid('ZZZZZZZZ'));
    }

    public function testValidRejectsWrongLengthOrCharacters(): void
    {
        $this->assertFalse(cdkey_valid('ABC'));            // too short
        $this->assertFalse(cdkey_valid('ABCD12345'));      // too long
        $this->assertFalse(cdkey_valid('abcd1234'));       // must be normalized first
        $this->assertFalse(cdkey_valid("ABCD123'"));       // quote — would break SQL/APS
        $this->assertFalse(cdkey_valid('ABCD_234'));       // underscore is a LIKE wildcard
        $this->assertFalse(cdkey_valid(''));
    }

    // ------------------------------------------------------------------
    // like_escape — planet names may legitimately contain _ or %
    // ------------------------------------------------------------------

    public function testLikeEscapeNeutralisesWildcards(): void
    {
        $this->assertSame('Star\_System', like_escape('Star_System'));
        $this->assertSame('100\%', like_escape('100%'));
        $this->assertSame('back\\\\slash', like_escape('back\\slash'));
    }

    public function testLikeEscapeLeavesPlainNamesAlone(): void
    {
        $this->assertSame('Alderan', like_escape('Alderan'));
    }

    // ------------------------------------------------------------------
    // tile_is_visible — the whole point of the feature
    // ------------------------------------------------------------------

    public function testDmSeesEverything(): void
    {
        $this->assertTrue(tile_is_visible(true, false, 0, 0, ''));
    }

    public function testPlayerSeesOnlyOwnDiscoveries(): void
    {
        $this->assertTrue(tile_is_visible(false, true, 0, 0, ''));
        $this->assertFalse(tile_is_visible(false, false, 0, 0, ''));
    }

    public function testAnonymousSeesNothingByDefault(): void
    {
        // Anonymous visitors reach this with $player_discovered = false.
        $this->assertFalse(tile_is_visible(false, false, 0, 0, '1'));
    }

    public function testShowAreasRevealsTheMapToEveryone(): void
    {
        // The DM's global override still works, exactly as before.
        $this->assertTrue(tile_is_visible(false, false, 1, 0, ''));
    }

    public function testShowInterestsRevealsOnlyTilesWithAnInterest(): void
    {
        $this->assertTrue(tile_is_visible(false, false, 0, 1, '2'));
        $this->assertFalse(tile_is_visible(false, false, 0, 1, ''));
    }
}
