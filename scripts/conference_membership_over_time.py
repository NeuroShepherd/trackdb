
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import json
from bs4 import BeautifulSoup
import time
from utils import dismiss_cookie_banner
import dotenv
import os


dotenv.load_dotenv()


# Load the page
driver = webdriver.Chrome()
driver.get(os.getenv("CONFERENCES_OVERVIEW"))

# Wait for body to load
WebDriverWait(driver, 10).until(
    EC.presence_of_element_located((By.TAG_NAME, "body"))
)
time.sleep(2)

# Dismiss cookie consent banner
dismiss_cookie_banner(driver)



# Find all nav-items within the specific ul
nav_ul = driver.find_element(By.CSS_SELECTOR, "ul.nav.nav-tabs.mr-25")
nav_items = nav_ul.find_elements(By.CLASS_NAME, "nav-item")

print(f"Found {len(nav_items)} nav items")

# Structure to hold all data across all years
all_data = {}

for i, nav_item in enumerate(nav_items):
    # Get the link inside this nav-item
    link = nav_item.find_element(By.TAG_NAME, "a")
    link_text = link.text
    
    print(f"\n{'='*50}")
    print(f"Clicking {i+1}: {link_text}")
    print('='*50)
    
    # Try clicking with JS if regular click fails
    try:
        link.click()
    except:
        print("Regular click failed, using JavaScript click...")
        driver.execute_script("arguments[0].click();", link)
    
    time.sleep(2)
    
    # Parse the page content
    html = driver.page_source
    soup = BeautifulSoup(html, 'html.parser')
    
    # Find the tab-content container
    tab_content = soup.find('div', class_='tab-content py-15')
    if not tab_content:
        print("  No tab-content found")
        continue
    
    # Find the active tab-pane within it
    active_pane = tab_content.find('div', class_='tab-pane active')
    if not active_pane:
        print("  No active tab-pane found")
        continue
    
    # Find all h3 tags within the active pane only
    h3s = active_pane.find_all('h3')
    print(f"Found {len(h3s)} h3 tags in active tab-pane")
    
    # Extract data from the first 4 divisions
    section_count = 0
    tab_year_data = {}
    
    for h3 in h3s:
        if section_count >= 4:
            break
        
        link_in_h3 = h3.find('a')
        if not link_in_h3:
            continue
            
        division_name = link_in_h3.get_text(strip=True)
        print(f"  {section_count + 1}. {division_name}")
        
        # Find the ul right after this h3
        ul = h3.find_next('ul', class_='list-unstyled')
        if not ul:
            print(f"      No ul found")
            section_count += 1
            continue
        
        # Extract all li items
        lis = ul.find_all('li', recursive=False)
        print(f"      Found {len(lis)} conferences")
        
        # Collect conference data
        division_data = {}
        for li in lis:
            # Get all links in this li
            links = li.find_all('a')
            if not links:
                continue
            
            # First link is the conference name
            conf_name = links[0].get_text(strip=True)
            
            # Collect all hrefs (main + gender variants)
            hrefs = [a.get('href') for a in links if a.get('href')]
            
            if hrefs:
                division_data[conf_name] = hrefs
        
        if division_data:
            tab_year_data[division_name] = division_data
            # Show sample
            sample = list(division_data.items())[:2]
            for name, hrefs in sample:
                print(f"        - {name}: {len(hrefs)} links")
            if len(division_data) > 2:
                print(f"        ... and {len(division_data) - 2} more")
        
        section_count += 1
    
    print(f"  Extracted data for {len(tab_year_data)} divisions")
    
    # Store this year's data
    all_data[link_text] = tab_year_data

driver.quit()

# Save all data to JSON
with open('output/conference_data.json', 'w') as f:
    json.dump(all_data, f, indent=2)

print("\n" + "="*50)
print("FINAL SUMMARY")
print("="*50)
for year, divisions in all_data.items():
    print(f"{year}:")
    for div, confs in divisions.items():
        print(f"  {div}: {len(confs)} conferences")
print("\nSaved to conference_data.json")