/**
 * Checks whether a MySQL DB connection is available by probing galaxy.php,
 * which immediately calls die("service offline") when the DB is unreachable.
 * Returns true when the DB is connected and the page renders content.
 */
async function isDbConnected(request) {
  try {
    const response = await request.get('/galaxy.php?planet=infos', { timeout: 5000 });
    const text = await response.text();
    return !text.includes('service offline');
  } catch {
    return false;
  }
}

module.exports = { isDbConnected };
