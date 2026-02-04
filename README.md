# Permis Conduire Checker (French Driving License Slot Checker)

Bash scripts to check available driving test slots on the French government's permit platform using the official API.

## Description

Check driving test slot availability across all French departments (001-099) using authenticated API requests. The scripts require valid session cookies from an authenticated browser session.

## Scripts

| Script | Description |
|--------|-------------|
| `check_permis_api.sh` | Main scanner - checks all departments (001-099) for available slots |
| `extract_cookies.sh` | Helper to format cookies from browser DevTools |
| `test_api.sh` | Quick test script to verify API connectivity |

## Prerequisites

- Bash shell (Linux/macOS/WSL)
- `curl` command-line tool
- `jq` (optional, for JSON formatting)
- Valid account on [candidat.permisdeconduire.gouv.fr](https://candidat.permisdeconduire.gouv.fr)

## Setup

### 1. Get Session Cookies

The API requires authenticated session cookies that expire quickly (~30 minutes).

1. Log in to [candidat.permisdeconduire.gouv.fr](https://candidat.permisdeconduire.gouv.fr)
2. Open DevTools (F12) -> Network tab
3. Search for available slots on the website
4. Click on a `creneaux?code-departement=...` request
5. In Request Headers, copy the entire `cookie:` header value

### 2. Configure the Script

Edit `check_permis_api.sh` and paste your cookies:

```bash
COOKIES='paste_your_cookies_here'
```

Or use the helper script:
```bash
./extract_cookies.sh
# Follow the instructions to format your cookies
```

## Usage

### Full Department Scan

```bash
./check_permis_api.sh
```

Scans all departments (001-099) with a 3-second delay between requests to avoid rate limiting.

### Quick API Test

```bash
./test_api.sh
```

Tests connectivity with a single department to verify cookies are valid.

## Output

The scanner displays:
- Connection test status
- Per-department results (available slots, empty, invalid code, errors)
- Summary with totals

Example output:
```
+===========================================================+
|    Scan des codes departement (001 a 099)                |
+===========================================================+

[OK] Connexion OK

[01/99] Code 001 : Vide
[02/99] Code 002 : Vide
[03/99] Code 003 : [OK] CRENEAUX DISPONIBLES!
{ ... JSON data ... }
...

+===========================================================+
|                       RESUME                              |
+===========================================================+
| Total teste           : 99 codes                          |
| [OK] Creneaux disponibles : 3                                |
| [ ] Centres vides        : 80                               |
| [X] Codes invalides      : 15                               |
| ! Erreurs              : 1                                |
+===========================================================+
```

## Error Handling

| Error | Cause | Solution |
|-------|-------|----------|
| `Bloque par Cloudflare` | Cookies invalid/expired | Get fresh cookies from browser |
| `Session expiree` | Session timeout | Re-authenticate and get new cookies |
| `Rate limit` | Too many requests | Script auto-pauses 10s, or increase `DELAY` |

## Configuration

In `check_permis_api.sh`:

```bash
DELAY=3  # Seconds between requests (default: 3)
```

Increase `DELAY` if you encounter rate limiting.

## Departments

Common department codes:
- **75**: Paris
- **92**: Hauts-de-Seine
- **93**: Seine-Saint-Denis
- **94**: Val-de-Marne
- **91**: Essonne
- **78**: Yvelines

## Important Notes

- **Cookie expiration**: Session cookies expire in ~30 minutes
- **Rate limiting**: Use reasonable delays between requests
- **Personal use only**: For checking your own appointment availability
- **No guarantee**: Website structure and API may change

## Troubleshooting

### Cookies Not Working

```bash
# Verify cookies format - should be a single line with semicolons
echo $COOKIES | head -c 100
```

### Cloudflare Blocks

Wait a few minutes before retrying. The site uses Cloudflare protection that may temporarily block automated requests.

### Empty Results Everywhere

This is normal - available slots are rare and fill up quickly.

## Legal & Ethical Notes

- This tool automates checking of public information
- Respect the website's terms of service
- Use reasonable request intervals
- For personal use only

## License

Personal project - Private use

---

**Disclaimer**: This tool is for personal convenience. Always verify slot availability on the official website. Session cookies are sensitive - never share them.
