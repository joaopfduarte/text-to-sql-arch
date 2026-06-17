#!/usr/bin/env python3
"""Remove credenciais e PII óbvios de ficheiros publicados no repositório."""
from __future__ import annotations

import re
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent

# Ordem: strings mais longas primeiro.
SECRET_REPLACEMENTS: list[tuple[str, str]] = [
    ("RangerAdminPassword2025", "__REDACTED_RANGER_ADMIN_PASSWORD__"),
    ("HiveUserMeta2025", "__REDACTED_HIVE_DB_PASSWORD__"),
    ("P1!qdZ5BalM0LDP2", "__REDACTED_RANGER_ADMIN_PASSWORD__"),
    ("Pedrinho2002*", "__REDACTED_NIFI_SENSITIVE_KEY__"),
    ("Ambari1234567", "__REDACTED_NIFI_SENSITIVE_KEY__"),
    ("rangerLookup123", "__REDACTED_RANGER_LOOKUP_PASSWORD__"),
    ("Ambari1234", "__REDACTED_AMBARI_ADMIN_PASSWORD__"),
    ("Ambari123", "__REDACTED_AMBARI_DB_PASSWORD__"),
    ("myKeyFilePassword", "__REDACTED_KEYSTORE_PASSWORD__"),
    ("UnIx529p", "__REDACTED_KEYSTORE_PASSWORD__"),
    ("1aB@2bC#", "__REDACTED_CONSOLE_PASSWORD__"),
    ('"ranger.solr.audit.user.password": "ranger"', '"ranger.solr.audit.user.password": "__REDACTED_RANGER_SOLR_PASSWORD__"'),
]

PASSWORD_VALUE_PATTERNS: list[tuple[re.Pattern[str], str]] = [
    (
        re.compile(r'("(?:[^"]*password[^"]*)"\s*:\s*)"bigdata"', re.IGNORECASE),
        r'\1"__REDACTED_SSL_PASSWORD__"',
    ),
    (
        re.compile(r'("(?:[^"]*truststore[^"]*)"\s*:\s*)"changeit"', re.IGNORECASE),
        r'\1"__REDACTED_TRUSTSTORE_PASSWORD__"',
    ),
    (
        re.compile(r'("ranger\.truststore\.password"\s*:\s*)"changeit"', re.IGNORECASE),
        r'\1"__REDACTED_TRUSTSTORE_PASSWORD__"',
    ),
]

LEGACY_GLOBS = (
    "legacy-infra/**/*.yml",
    "legacy-infra/**/*.yaml",
    "legacy-infra/**/*.json",
    "legacy-infra/**/*.sh",
    "legacy-infra/**/*.tf",
)

DB_REFERENCE_FILES = (
    ROOT / "db-reference" / "putz_db.sql",
    ROOT / "db-reference" / "putz_db.md",
)

AUTHOR_PATTERN = re.compile(r"@author Aléssio Miranda Júnior")


def redact_secrets(text: str) -> str:
    for old, new in SECRET_REPLACEMENTS:
        text = text.replace(old, new)
    for pattern, repl in PASSWORD_VALUE_PATTERNS:
        text = pattern.sub(repl, text)
    return text


def redact_provider_tf(path: Path) -> bool:
    text = path.read_text(encoding="utf-8")
    original = text
    text = re.sub(r"^\s*#ocid1\..*$", "", text, flags=re.MULTILINE)
    text = re.sub(r"^\s*#sa-saopaulo-1\s*$", "", text, flags=re.MULTILINE)
    text = re.sub(r"\n{3,}", "\n\n", text)
    if text != original:
        path.write_text(text, encoding="utf-8")
        return True
    return False


def redact_authors(path: Path) -> bool:
    text = path.read_text(encoding="utf-8")
    updated = AUTHOR_PATTERN.sub("@author [redacted]", text)
    if updated != text:
        path.write_text(updated, encoding="utf-8")
        return True
    return False


def main() -> None:
    changed: list[str] = []

    for pattern in LEGACY_GLOBS:
        for path in ROOT.glob(pattern):
            if not path.is_file():
                continue
            if path.name.endswith(".tf"):
                if redact_provider_tf(path):
                    changed.append(str(path.relative_to(ROOT)))
                continue
            text = path.read_text(encoding="utf-8")
            updated = redact_secrets(text)
            if updated != text:
                path.write_text(updated, encoding="utf-8")
                changed.append(str(path.relative_to(ROOT)))

    for path in DB_REFERENCE_FILES:
        if path.exists() and redact_authors(path):
            changed.append(str(path.relative_to(ROOT)))

    print(f"sanitized {len(changed)} files")
    for item in changed:
        print(f"  - {item}")


if __name__ == "__main__":
    main()
