import csv
import json
import re
from pathlib import Path


def normalize_name(value: str) -> str:
	value = value.strip().lower()
	value = re.sub(r"[\s\-_/]+", " ", value)
	value = re.sub(r"[^a-z0-9 ]", "", value)
	return value


conference_json_path = Path("scripts/output/conference_data_cleaned.json")
conference_csv_path = Path("conferences.csv")
if not conference_csv_path.exists():
	conference_csv_path = Path("sql/conferences.csv")

with conference_json_path.open() as f:
	all_data = json.load(f)

csv_names = set()
csv_norm_names = set()

with conference_csv_path.open(newline="") as f:
	reader = csv.DictReader(f)
	for row in reader:
		name = row.get("name", "").strip()
		abbrev = row.get("abbreviation", "").strip()
		if name:
			csv_names.add(name)
			csv_norm_names.add(normalize_name(name))
		if abbrev:
			csv_names.add(abbrev)
			csv_norm_names.add(normalize_name(abbrev))

json_confs = set()
for year_data in all_data.values():
	for div_data in year_data.values():
		json_confs.update(div_data.keys())

alias_map = {
	"Metro Atlantic": "Metro Atlantic Athletic Conference",
	"The American": "American Conference",
	"Michigan Intercollegiate AA": "Michigan Intercollegiate Athletic Association",
	"Mid-American": "Mid-American Conference",
	"Missouri Valley": "Missouri Valley Conference",
	"Mountain West": "Mountain West Conference",
	"American Conference": "The American",
	"The Summit League": "Summit League",
	"Atlantic 10": "Atlantic 10 Conference",
}
alias_norm_map = {
	normalize_name(k): normalize_name(v) for k, v in alias_map.items()
}

missing = []
for conf in sorted(json_confs):
	if conf in csv_names:
		continue
	conf_norm = normalize_name(conf)
	if conf_norm in csv_norm_names:
		continue
	alias_norm = alias_norm_map.get(conf_norm)
	if alias_norm and alias_norm in csv_norm_names:
		continue
	missing.append(conf)

print(f"Total conferences in JSON: {len(json_confs)}")
print(f"Total conferences in CSV (names+abbrev): {len(csv_names)}")
print(f"Missing from CSV: {len(missing)}")

if missing:
	print("\nMissing conference names:")
	for name in missing:
		print(f"- {name}")
