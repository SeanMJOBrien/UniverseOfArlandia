<?php
declare(strict_types=1);

use PHPUnit\Framework\TestCase;

/**
 * Tests for www/logging.php helpers.
 */
class LoggingTest extends TestCase
{
    // ------------------------------------------------------------------
    // console_log — emits a <script>console.log(…)</script> block
    // ------------------------------------------------------------------

    public function testConsoleLogWithScriptTags(): void
    {
        ob_start();
        console_log('hello');
        $output = ob_get_clean();

        $this->assertStringContainsString('<script>', $output);
        $this->assertStringContainsString('console.log(', $output);
        $this->assertStringContainsString('</script>', $output);
        $this->assertStringContainsString('hello', $output);
    }

    public function testConsoleLogWithoutScriptTags(): void
    {
        ob_start();
        console_log('hello', false);
        $output = ob_get_clean();

        $this->assertStringNotContainsString('<script>', $output);
        $this->assertStringContainsString('console.log(', $output);
        $this->assertStringContainsString('hello', $output);
    }

    public function testConsoleLogEncodesSpecialChars(): void
    {
        ob_start();
        console_log('<b>XSS</b>');
        $output = ob_get_clean();

        // json_encode with JSON_HEX_TAG should encode < and > as unicode escapes
        $this->assertStringNotContainsString('<b>', $output);
        $this->assertStringContainsString('XSS', $output);
    }

    public function testConsoleLogArray(): void
    {
        ob_start();
        console_log(['key' => 'value']);
        $output = ob_get_clean();

        $this->assertStringContainsString('console.log(', $output);
        $this->assertStringContainsString('key', $output);
        $this->assertStringContainsString('value', $output);
    }

    public function testConsoleLogInteger(): void
    {
        ob_start();
        console_log(42);
        $output = ob_get_clean();

        $this->assertStringContainsString('42', $output);
    }
}
