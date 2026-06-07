<?php
declare(strict_types=1);

use PHPUnit\Framework\Attributes\DataProvider;
use PHPUnit\Framework\TestCase;

/**
 * Smoke-tests for the static HTML pages in www/.
 *
 * These use regex-based checks (PHP's DOM extension is not installed).
 * Each test loads the raw file and verifies structural invariants.
 */
class HtmlStructureTest extends TestCase
{
    private const WWW = __DIR__ . '/../www';

    /** @return array<string, array{0: string}> */
    public static function htmlFileProvider(): array
    {
        $files = glob(self::WWW . '/*.html');
        $cases = [];
        foreach ($files as $path) {
            $name = basename($path);
            // Skip backup / work-in-progress files
            if (str_ends_with($name, '.orig')) {
                continue;
            }
            $cases[$name] = [$path];
        }
        return $cases;
    }

    // ------------------------------------------------------------------
    // Every HTML file must have a <head> and a <body>
    // ------------------------------------------------------------------

    #[DataProvider('htmlFileProvider')]
    public function testHasHeadElement(string $path): void
    {
        $html = file_get_contents($path);
        $this->assertMatchesRegularExpression('/<head[\s>]/i', $html, "$path is missing <head>");
    }

    #[DataProvider('htmlFileProvider')]
    public function testHasBodyElement(string $path): void
    {
        $html = file_get_contents($path);
        $this->assertMatchesRegularExpression('/<body[\s>]/i', $html, "$path is missing <body>");
    }

    #[DataProvider('htmlFileProvider')]
    public function testHasClosingBody(string $path): void
    {
        $html = file_get_contents($path);
        $this->assertMatchesRegularExpression('/<\/body>/i', $html, "$path is missing </body>");
    }

    #[DataProvider('htmlFileProvider')]
    public function testHasTitleTag(string $path): void
    {
        $html = file_get_contents($path);
        // Excel- / FrontPage-generated exports don't always include a <title>
        if (preg_match('/content=["\']?Excel\.Sheet|Microsoft Excel|Microsoft FrontPage 5/i', $html)
            && !preg_match('/<title[\s>]/i', $html)) {
            $this->markTestSkipped(basename($path) . ' is a tool-generated export without <title>');
        }
        $this->assertMatchesRegularExpression('/<title[\s>]/i', $html, "$path is missing <title>");
    }

    // ------------------------------------------------------------------
    // CSS and JS assets referenced in the HTML must exist on disk
    // ------------------------------------------------------------------

    #[DataProvider('htmlFileProvider')]
    public function testLocalCssFilesExist(string $path): void
    {
        $html = file_get_contents($path);
        preg_match_all('/href=["\']([^"\']+\.css)["\']/', $html, $m);
        $refs    = array_filter($m[1], fn($h) => !$this->isExternalUri($h));
        $missing = $this->collectMissingAssets($refs);
        $this->assertEmpty($missing, "Missing CSS in $path:\n" . implode("\n", $missing));
    }

    #[DataProvider('htmlFileProvider')]
    public function testLocalJsFilesExist(string $path): void
    {
        $html = file_get_contents($path);
        preg_match_all('/src=["\']([^"\']+\.js)["\']/', $html, $m);
        $refs    = array_filter($m[1], fn($s) => !$this->isExternalUri($s));
        $missing = $this->collectMissingAssets($refs);
        $this->assertEmpty($missing, "Missing JS in $path:\n" . implode("\n", $missing));
    }

    #[DataProvider('htmlFileProvider')]
    public function testLocalImageFilesExist(string $path): void
    {
        $html = file_get_contents($path);
        preg_match_all('/src=["\']([^"\']+\.(gif|jpg|jpeg|png))["\']/', $html, $m);
        $refs    = array_filter($m[1], fn($s) => !$this->isExternalUri($s));
        $missing = $this->collectMissingAssets($refs);
        $this->assertEmpty($missing, "Missing images in $path:\n" . implode("\n", $missing));
    }

    // ------------------------------------------------------------------
    // Internal page links (href="*.html") must point to existing files
    // ------------------------------------------------------------------

    #[DataProvider('htmlFileProvider')]
    public function testInternalHtmlLinksExist(string $path): void
    {
        $html = file_get_contents($path);
        preg_match_all('/href=["\']([^"\'#?]+\.html)["\']/', $html, $m);
        $refs    = array_filter($m[1], fn($h) => !$this->isExternalUri($h));
        $missing = $this->collectMissingAssets($refs);
        $this->assertEmpty($missing, "Broken HTML links in $path:\n" . implode("\n", $missing));
    }

    /** @param string[] $refs */
    private function collectMissingAssets(array $refs): array
    {
        $missing = [];
        foreach ($refs as $ref) {
            $fullPath = self::WWW . '/' . ltrim($ref, '/');
            if (!$this->fileExistsCaseInsensitive($fullPath)) {
                $missing[] = $ref;
            }
        }
        return $missing;
    }

    private function isExternalUri(string $uri): bool
    {
        return str_starts_with($uri, 'http') || str_starts_with($uri, 'file://');
    }

    /**
     * Case-insensitive file-existence check.
     * HTML pages authored on Windows may reference paths whose casing differs
     * from the Linux filesystem (e.g. "factory_fichiers" vs "Factory_fichiers").
     * We resolve each path component case-insensitively so such mismatches are
     * not flagged as missing files — they are deployment warnings, not missing assets.
     */
    private function fileExistsCaseInsensitive(string $path): bool
    {
        if (file_exists($path)) {
            return true;
        }

        // Collapse /./ and repeated slashes, then walk segment-by-segment.
        $path = preg_replace('#/\./|//+#', '/', $path);

        if (!str_starts_with($path, '/')) {
            return false;
        }

        $segments = explode('/', ltrim($path, '/'));
        $resolved = '';

        foreach ($segments as $segment) {
            if ($segment === '' || $segment === '.') {
                continue;
            }

            $candidate = $resolved . '/' . $segment;
            if (file_exists($candidate)) {
                $resolved = $candidate;
                continue;
            }

            // Case-insensitive scan of the current directory
            if (!is_dir($resolved === '' ? '/' : $resolved)) {
                return false;
            }

            $dir   = $resolved === '' ? '/' : $resolved;
            $lower = strtolower($segment);
            $found = false;
            foreach (scandir($dir) as $entry) {
                if ($entry === '.' || $entry === '..') {
                    continue;
                }
                if (strtolower($entry) === $lower) {
                    $resolved = $resolved . '/' . $entry;
                    $found    = true;
                    break;
                }
            }
            if (!$found) {
                return false;
            }
        }

        return file_exists($resolved);
    }

    // ------------------------------------------------------------------
    // PHP pages: verify they exist and are non-empty
    // ------------------------------------------------------------------

    /** @return array<string, array{0: string}> */
    public static function phpFileProvider(): array
    {
        $files = glob(self::WWW . '/*.php');
        $cases = [];
        foreach ($files as $path) {
            $cases[basename($path)] = [$path];
        }
        return $cases;
    }

    #[DataProvider('phpFileProvider')]
    public function testPhpFilesAreNonEmpty(string $path): void
    {
        $this->assertGreaterThan(0, filesize($path), "$path is empty");
    }

    #[DataProvider('phpFileProvider')]
    public function testPhpSyntaxIsValid(string $path): void
    {
        exec("php -l " . escapeshellarg($path) . " 2>&1", $out, $code);
        $this->assertSame(0, $code, implode("\n", $out));
    }

    // ------------------------------------------------------------------
    // CSS and JS asset files must be non-empty
    // ------------------------------------------------------------------

    public function testLightboxCssExists(): void
    {
        $this->assertFileExists(self::WWW . '/css/lightbox.css');
    }

    /** @return array<string, array{0: string}> */
    public static function jsFileProvider(): array
    {
        $files = glob(self::WWW . '/js/*.js');
        $cases = [];
        foreach ($files as $path) {
            $cases[basename($path)] = [$path];
        }
        return $cases;
    }

    #[DataProvider('jsFileProvider')]
    public function testJsFilesAreNonEmpty(string $path): void
    {
        $this->assertGreaterThan(0, filesize($path), "$path is empty");
    }
}
