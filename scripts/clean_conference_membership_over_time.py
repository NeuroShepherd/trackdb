

import json


with open("scripts/output/conference_data.json", "r") as f:
    all_data = json.load(f)

excluded_names = {
    "Div. I Combined List",
    "Div. I East Qualifying List",
    "Div. I West Qualifying List",
    "DI Great Lakes Region",
    "DI Mid-Atlantic Region",
    "DI Midwest Region",
    "DI Mountain Region",
    "DI Northeast Region",
    "DI South Central Region",
    "DI South Region",
    "DI Southeast Region",
    "DI West Region",
    "IC4A/ECAC",
    "NEICAAA",
    "DII Atlantic Region",
    "DII Central Region",
    "DII East Region",
    "DII Midwest Region",
    "DII South Central Region",
    "DII South Region",
    "DII Southeast Region",
    "DII West Region",
    "DIII East Region",
    "DIII Great Lakes Region",
    "DIII Metro Region",
    "DIII Mid-Atlantic Region",
    "DIII Mideast Region",
    "DIII Midwest Region",
    "DIII Niagara Region",
    "DIII North Region",
    "DIII South Region",
    "DIII West Region",
    "DIII All-Ohio",
    "DIII New England",
    "Indoor Qualifying List",
    "Outdoor Qualifying List",
    "AARTFC",
    "ECAC DIII",
    "Frozen 8",
    "HBCU", #the MEAC and SWAC cover these schools
    "Mets", # can't even really find out what this is--mostly NY and NJ schools
    "NYSCTC", # more NY and east coast schools--think it's just some regional championships
    "Ohio Valley",
    "United East/AMCC", # this is a recent merger of two small DIII conferences, and the membership is really just the two original conferences
    "MPSF", # this is a west coast conference that only sponsors indoor track, and most of its members are in the Pac-12, so it doesn't make sense to include it as a separate conference
}

for key, value in all_data.items():
    for division, confs in value.items():
        filtered_confs = {}
        for conf_name, hrefs in confs.items():
            if conf_name in excluded_names:
                continue
            unique_hrefs = list(set(hrefs))
            # remove the non-gendered version if both gendered versions exist
            if len(unique_hrefs) > 2:
                non_gendered = [
                    href
                    for href in unique_hrefs
                    if not any(g in href for g in ["gender=m", "gender=f"])
                ]
                unique_hrefs = [href for href in unique_hrefs if href not in non_gendered]
            filtered_confs[conf_name] = unique_hrefs
        all_data[key][division] = filtered_confs

for key, value in list(all_data.items())[:1]:
    for division, confs in value.items():
        print(division)
        print("======================")
        for conf_name, hrefs in confs.items():
            print(conf_name)




with open('scripts/output/conference_data_cleaned.json', 'w') as f:
    json.dump(all_data, f, indent=2)

