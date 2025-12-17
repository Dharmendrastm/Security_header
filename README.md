---
```md
# 🔐 Web Security Headers & HTTP Methods Check (Using curl)

This document provides a standard way to verify **security headers** and **allowed HTTP methods**
using `curl`.  
Useful for **security audits, penetration testing, and compliance checks (OWASP, CIS, PCI-DSS)**.

---

## 🌐 Target Information

```

Target URL : [https://example.com](https://example.com)
Tool       : curl
Test Date  : DD-MM-YYYY

````

---

## 📌 Base Command (All Headers)

```bash
curl -I -L https://example.com
````

---

## 🔐 Security Headers Checklist

| Header Name               | Expected Value                      | Status |
| ------------------------- | ----------------------------------- | ------ |
| Strict-Transport-Security | max-age=31536000; includeSubDomains | ✅ / ❌  |
| Content-Security-Policy   | default-src 'self'                  | ✅ / ❌  |
| X-Frame-Options           | DENY / SAMEORIGIN                   | ✅ / ❌  |
| X-Content-Type-Options    | nosniff                             | ✅ / ❌  |
| Referrer-Policy           | no-referrer / strict-origin         | ✅ / ❌  |
| Permissions-Policy        | geolocation=()                      | ✅ / ❌  |
| Set-Cookie Flags          | Secure; HttpOnly; SameSite          | ✅ / ❌  |

---

## 🔍 Individual Header Verification

```bash
curl -I https://example.com | grep -i strict-transport-security
curl -I https://example.com | grep -i content-security-policy
curl -I https://example.com | grep -i x-frame-options
curl -I https://example.com | grep -i x-content-type-options
curl -I https://example.com | grep -i referrer-policy
curl -I https://example.com | grep -i permissions-policy
curl -I https://example.com | grep -i set-cookie
```

---

## 🔄 HTTP Methods Enumeration

### OPTIONS Method

```bash
curl -X OPTIONS -i https://example.com
```

### Expected (Secure)

```
Allow: GET, POST, HEAD
```

### Risky Methods (Should be Disabled)

* PUT
* DELETE
* TRACE
* CONNECT

---

## ⚠️ TRACE Method Test (XST)

```bash
curl -X TRACE -i https://example.com
```

❌ If TRACE echoes request → **Security Risk**

---

## 📋 HTTP Methods Status Table

| Method  | Status   | Risk   |
| ------- | -------- | ------ |
| GET     | Enabled  | Low    |
| POST    | Enabled  | Low    |
| HEAD    | Enabled  | Low    |
| OPTIONS | Enabled  | Medium |
| PUT     | Disabled | ✅      |
| DELETE  | Disabled | ✅      |
| TRACE   | Disabled | ✅      |
| CONNECT | Disabled | ✅      |

---

## ⚠️ Risk Assessment Summary

| Finding         | Risk Level |
| --------------- | ---------- |
| Missing HSTS    | High       |
| Missing CSP     | High       |
| TRACE Enabled   | High       |
| OPTIONS Enabled | Medium     |

---

## 📝 Final Security Summary

```
✔ X-Frame-Options present
✔ X-Content-Type-Options present
❌ Content-Security-Policy missing
❌ Strict-Transport-Security missing
❌ OPTIONS method enabled

Overall Security Risk: HIGH
```

---

## ✅ Recommendations

* Enable **HSTS**
* Implement **Content-Security-Policy**
* Disable **TRACE and unused HTTP methods**
* Restrict OPTIONS if not required

---

## 📚 References

* OWASP Secure Headers Project
* OWASP Testing Guide
* CIS Benchmarks

---

## 🛠 Author

Security Testing using curl

```

---

Agar chaho to main:
- 🧪 **Auto bash script (`security_check.sh`)**
- 📄 **GitHub Action**
- 📊 **CSV / Excel output**
- 🛡️ **OWASP mapping version**
--
